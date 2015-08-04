//
//  DBManager.h
//  MyCrime
//
//  Created by mini2 on 15/8/3.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCrime.h"

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+ (DBManager *)getSharedInstance;
- (BOOL)savaData:(NSMutableArray *)data;
- (NSMutableArray *)getData;

@end
