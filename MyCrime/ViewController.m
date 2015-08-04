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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectedItem;

@end

@implementation ViewController

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


@end
