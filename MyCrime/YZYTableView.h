//
//  YZYTableView.h
//  MyCrime
//
//  Created by mini2 on 15/8/7.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class YZYTableView;

@protocol YZYTableViewDelegate <UITableViewDelegate, UITableViewDataSource>

- (id)yzyTableViewOnRefrehDoing:(YZYTableView *)tableView;
- (void)yzyTableView:(YZYTableView *)tableView onRefreshDoneWithResult:(id)result;

@end

@interface YZYTableView : UITableView <EGORefreshTableHeaderDelegate>

@property (nonatomic, assign) BOOL showHeaderView;
@property (nonatomic, weak) id<YZYTableViewDelegate> yzyDelegate;

@property (nonatomic, readonly) EGORefreshTableHeaderView *headerView;

@end
