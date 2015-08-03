//
//  MyDatePickerDialogViewController.h
//  MyCrime
//
//  Created by mini2 on 15/7/31.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDateChangedDelegate;

@interface MyDatePickerDialogViewController : UIViewController

@property (nonatomic, weak) NSDate *dateNow;


@property id<MyDateChangedDelegate> dateChangedDelegate;

@end


@protocol MyDateChangedDelegate <NSObject>

- (void)onDateChanged:(NSDate *)date;

@end