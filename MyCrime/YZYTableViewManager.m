//
//  YZYTableViewManager.m
//  MyCrime
//
//  Created by mini2 on 15/8/7.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "YZYTableViewManager.h"

@interface YZYTableViewManager ()
@property (nonatomic, strong) NSMutableDictionary *tableViews;

@end

@implementation YZYTableViewManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _tableViews = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setTableView:(YZYTableView *)tableView forKey:(NSString *)key {
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.tableViews setValue:tableView forKey:key];
}

- (YZYTableView *)tableViewForKey:(NSString *)key {
    return [self.tableViews objectForKey:key];
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YZYTableView *theView = (YZYTableView *)tableView;
    return [theView.yzyDelegate tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYTableView *theView = (YZYTableView *)tableView;
    return [theView.yzyDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"删除"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYTableView *theView = (YZYTableView *)tableView;
    [theView.yzyDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYTableView *theView = (YZYTableView *)tableView;
    [theView.yzyDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    YZYTableView *tableView = (YZYTableView *) scrollView;
    if (tableView.showHeaderView) {
        [tableView.headerView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    YZYTableView *tableView = (YZYTableView *) scrollView;
    if (tableView.showHeaderView) {
        [tableView.headerView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


@end
