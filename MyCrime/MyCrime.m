//
//  MyCrime.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "MyCrime.h"

@interface MyCrime () <NSCoding>

@property (nonatomic, strong) NSUUID *id;

@end

@implementation MyCrime

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.isChecked = [aDecoder decodeBoolForKey:@"isChecked"];
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.id = [NSUUID UUID];
    }
    return self;
}

- (instancetype)initWith:(NSUUID *)id andTitle:(NSString *)title andDate:(NSDate *)date andIsChecked:(BOOL)checked{
    self = [super init];
    if (self) {
        self.title = title;
        self.id = id;
        self.date = date;
        self.isChecked = checked;
    }
    return self;
}

- (NSUUID *)getId {
    return self.id;
}

@end
