//
//  YZYTableView.m
//  MyCrime
//
//  Created by mini2 on 15/8/7.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "YZYTableView.h"

@interface YZYTableView () 


@property (nonatomic, assign) BOOL isLoadingData;

@end

@implementation YZYTableView

#pragma mark - assert methods
- (void)setShowHeaderView:(BOOL)showHeaderView {
    _showHeaderView = showHeaderView;
    if (showHeaderView) {
        if (!self.headerView) {
            _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
            self.headerView.delegate = self;
        }
        [self addSubview:self.headerView];
        self.isLoadingData = NO;
    } else {
        [self.headerView removeFromSuperview];
    }
}

#pragma mark - ego delegate
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    return self.isLoadingData;
}
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    return [NSDate date];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    if (self.showHeaderView) {
        self.isLoadingData = YES;
        [self performSelectorInBackground:@selector(onRefreshDoingInBackground:) withObject:self];
    }
}

- (void)onRefreshDoingInBackground:(YZYTableView *)view {
    id result = [self.yzyDelegate yzyTableViewOnRefrehDoing:view];
    [self performSelectorOnMainThread:@selector(onRefrehDoneInBackgroundWithResult:) withObject:result waitUntilDone:YES];
}

- (void)onRefrehDoneInBackgroundWithResult:(id)result {
    self.isLoadingData = NO;
    [self.headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    [self reloadData];
    [self.yzyDelegate yzyTableView:self onRefreshDoneWithResult:result];
}

@end
