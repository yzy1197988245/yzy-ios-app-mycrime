//
//  MyCrime.h
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCrime : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isChecked;

- (NSUUID *)getId;
- (instancetype)initWith:(NSUUID *)id andTitle:(NSString *)title andDate:(NSDate *)date andIsChecked:(BOOL)checked;

@end
