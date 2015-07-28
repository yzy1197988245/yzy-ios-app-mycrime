//
//  NSObject+MyApplication.h
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface NSObject (MyApplication)

@property (nonatomic, readonly) UIApplication *application;
@property (nonatomic, readonly) AppDelegate *app;

@end
