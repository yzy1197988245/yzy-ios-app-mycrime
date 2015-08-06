//
//  MyPresentationController.m
//  MyCrime
//
//  Created by mini2 on 15/7/31.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "MyPresentationController.h"

@interface MyPresentationController ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) CGRect viewSize;


@end

@implementation MyPresentationController

- (UIView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:self.presentingViewController.view.frame];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPresentedView)];
        [view addGestureRecognizer:gesture];
        _backgroundView = view;
        return _backgroundView;
    }
}

- (void)dismissPresentedView {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    [self.containerView addSubview:self.backgroundView];
//    [self.backgroundView addSubview:self.presentedViewController.view];
//    self.backgroundView addSubview:sel;
    self.backgroundView.alpha = 0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundView.alpha = 1;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.backgroundView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.backgroundView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
//    if (CGRectEqualToRect(self.viewSize, CGRectZero)) {
//        CGFloat x = (self.containerView.frame.size.width - 400) / 2;
//        CGFloat y = (self.containerView.frame.size.height - 300) / 2;
//        self.viewSize = CGRectMake(x, y, 400, 300);
//        return self.viewSize;
//    } else {
//        NSLog(@"%@,%@",@(self.viewSize.size.height),@(self.viewSize.size.width));
//        return self.viewSize;
//    }
    self.viewSize = self.presentedView.frame;
    return self.presentedView.frame;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundView.frame = self.presentingViewController.view.frame;
        self.presentedViewController.view.frame = self.viewSize;
    } completion:nil];
}

@end
