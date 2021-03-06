//
//  NewCrimeViewController.h
//  MyCrime
//
//  Created by mini2 on 15/8/5.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCrime.h"
#import "YZYPopoverViewController.h"

@protocol NewCrimeDelegate;

@interface NewCrimeViewController : YZYPopoverViewController

@property id<NewCrimeDelegate> delegate;

@end


@protocol NewCrimeDelegate <NSObject>

- (void)onCrimeCreated:(MyCrime *)crime;

@end