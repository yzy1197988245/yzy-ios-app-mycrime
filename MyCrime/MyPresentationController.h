//
//  MyPresentationController.h
//  MyCrime
//
//  Created by mini2 on 15/7/31.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YZYPopoverViewStyleNormal = 0,
    YZYPopoverViewStyleDialog,
}YZYPopoverViewStyle;

@interface MyPresentationController : UIPresentationController

@property (nonatomic, assign) YZYPopoverViewStyle style;

@end
