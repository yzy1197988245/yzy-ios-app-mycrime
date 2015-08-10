//
//  YZYTableViewManager.h
//  MyCrime
//
//  Created by mini2 on 15/8/7.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YZYTableView.h"

@interface YZYTableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)setTableView:(YZYTableView *)tableView forKey:(NSString *)key;
- (YZYTableView *)tableViewForKey:(NSString *)key;

@end
