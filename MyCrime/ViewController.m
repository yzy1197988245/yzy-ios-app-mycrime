//
//  ViewController.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+MyApplication.h"
#import "CrimeTableViewCell.h"
#import "DetailViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectedItem;
@property (strong, nonatomic) EGORefreshTableHeaderView *headView;

@end

@implementation ViewController

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    return NO;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    return [NSDate date];
}


- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    [self performSelectorInBackground:@selector(test) withObject:nil];
}

- (void) test{
    [NSThread sleepForTimeInterval:1];
    [self performSelectorOnMainThread:@selector(test2) withObject:nil waitUntilDone:YES];
}

- (void) test2{
//    NSLog(@"task end");
    [self.headView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.headView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.app.crimeLab.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CrimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.crime = [self.app.crimeLab objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedItem = indexPath;
    DetailViewController *controller =(DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    controller.currentItem = indexPath;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - notification methods
- (void)updateView:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"updateView"]) {
        self.selectedItem = notification.object;
    }
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];

  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView:) name:nil object:nil];
    
    [self.tableView reloadData];
    
    if (self.selectedItem) {
        [self.tableView selectRowAtIndexPath:self.selectedItem animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:self.selectedItem atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.selectedItem = nil;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!self.headView) {
        self.headView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.tableView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        self.headView.delegate = self;
        [self.tableView addSubview:self.headView];
    }
    
}

@end
