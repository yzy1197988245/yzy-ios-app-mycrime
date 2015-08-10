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
#import "NewCrimeViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate, NewCrimeDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectedItem;
@property (strong, nonatomic) EGORefreshTableHeaderView *headView;

@property (strong, nonatomic) NSMutableArray *delItems;
@property (strong, nonatomic) NSMutableArray *delCrimes;

@end

@implementation ViewController
#pragma mark - private methods
- (void)newCrimeAction {
    NewCrimeViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewCrimeViewController"];
    controller.delegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)deleteAction {
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"批量删除"]) {
        [self.tableView setEditing:!self.tableView.isEditing animated:YES];
        if (self.tableView.isEditing) {
            [self.navigationItem.rightBarButtonItem setTitle:@"确定"];
        }
    } else if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"确定"]) {
        [self.tableView setEditing:!self.tableView.isEditing animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"批量删除"];
        
        [self.app.crimeLab removeObjectsInArray:self.delCrimes];
        [self.delCrimes removeAllObjects];
        
        [self.tableView deleteRowsAtIndexPaths:self.delItems withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.delItems removeAllObjects];
        
        [self.app savaDatatoFile];
    }
}

- (void)onCrimeCreated:(MyCrime *)crime {
    [self.app.crimeLab addObject:crime];
    [self.tableView reloadData];
    [self.app savaDatatoFile];
}

#pragma mark - task methods
- (void) test{
    [NSThread sleepForTimeInterval:1];
    [self performSelectorOnMainThread:@selector(test2) withObject:nil waitUntilDone:YES];
}

- (void) test2{
    [self.tableView reloadData];
    [self.headView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.app.crimeLab.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CrimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.crime = [self.app.crimeLab objectAtIndex:indexPath.row];

    if ([self.delItems indexOfObject:indexPath] == NSNotFound) {
        return cell;
    } else {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.tableView.editing) {
        self.selectedItem = indexPath;
        DetailViewController *controller =(DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        controller.currentItem = indexPath;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [self.delItems addObject:indexPath];
        [self.delCrimes addObject:[self.app.crimeLab objectAtIndex:indexPath.row]];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
    } else
        return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"删除"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.app.crimeLab removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.app savaDatatoFile];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.headView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark - notification methods
- (void)updateView:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"updateView"]) {
        self.selectedItem = notification.object;
    }
}

#pragma mark - refresh head delegate
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    return NO;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    return [NSDate date];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    [self performSelectorInBackground:@selector(test) withObject:nil];
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"批量删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    UIBarButtonItem *newCrimeButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(newCrimeAction)];
    self.navigationItem.leftBarButtonItem = newCrimeButton;

    self.delItems = [[NSMutableArray alloc] init];
    self.delCrimes = [[NSMutableArray alloc] init];
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
