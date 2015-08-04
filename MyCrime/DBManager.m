//
//  DBManager.m
//  MyCrime
//
//  Created by mini2 on 15/8/3.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "MyCrime.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+ (DBManager *)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super alloc] init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

- (BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"crimes.db"]];
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if (![filemgr fileExistsAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "create table if not exists crimes (id text primary key, title text, date text, checked integer)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
                NSLog(@"%@",[NSString stringWithCString:errMsg encoding:NSUTF8StringEncoding]);
            }
            sqlite3_close(database);
            NSLog(@"database create success!");
            return isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open database");
        }
    } else {
        NSLog(@"the database exists");
    }
    return isSuccess;
}

- (BOOL)savaData:(NSMutableArray *)data {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        for (MyCrime *crime in data) {
            NSString *insertSql = [NSString stringWithFormat:@"insert into crimes(id,title,date,checked) values (\"%@\",\"%@\",\"%@\",\"%@\")",[[crime getId] UUIDString], crime.title, crime.date.description, @(crime.isChecked)];
            const char *insert_stmt = [insertSql UTF8String];
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE) {
                NSLog(@"save succeed!!");
//                return YES;
            } else {
                sqlite3_reset(statement);
                NSLog(@"error");
                return NO;
            }
        }
        sqlite3_close(database);
    }
    return NO;
}

- (NSMutableArray *)getData {
    const char *dbpath = [databasePath UTF8String];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySql = [NSString stringWithFormat:@"select * from crimes"];
        const char *query_stmt = [querySql UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char *id = (char *)sqlite3_column_text(statement, 0);
                NSString *idStr = [[NSString alloc] initWithUTF8String:id];
                NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:idStr];
                
                char *title = (char *)sqlite3_column_text(statement, 1);
                NSString *titleStr = [[NSString alloc] initWithUTF8String:title];
                
                char *date = (char *)sqlite3_column_text(statement, 2);
                NSString *dateStr = [[NSString alloc] initWithUTF8String:date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss zzz";
                NSDate *date1 = [dateFormatter dateFromString:dateStr];
                
                NSInteger check = sqlite3_column_int(statement, 3);
                BOOL ischeck = check;
                
                MyCrime *crime = [[MyCrime alloc] initWith:uuid andTitle:titleStr andDate:date1 andIsChecked:ischeck];
                [data addObject:crime];
                
            }
        } else {
            NSAssert(FALSE,nil);
        }
        sqlite3_close(database);
    }
    
    
    return data;
}


@end
