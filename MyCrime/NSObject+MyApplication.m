//
//  NSObject+MyApplication.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "NSObject+MyApplication.h"

@implementation NSObject (MyApplication)

- (UIApplication *)application{
    return [UIApplication sharedApplication];
}
- (AppDelegate *)app{
    return [UIApplication sharedApplication].delegate;
}

@end
