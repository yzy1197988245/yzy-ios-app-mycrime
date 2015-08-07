//
//  YZYPopoverDialogViewController.m
//  MyCrime
//
//  Created by mini2 on 15/8/6.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "YZYPopoverViewController.h"
#import "MyPresentationController.h"

@interface YZYPopoverViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation YZYPopoverViewController

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    [super setModalPresentationStyle:modalPresentationStyle];
    if (modalPresentationStyle == UIModalPresentationCustom) {
        self.transitioningDelegate = self;
    }
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    if (presented == self) {
        MyPresentationController *pc = [[MyPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
        pc.style = self.presentationStyle;
        return pc;
    } else {
        return self.presentationController;
    }
}

@end
