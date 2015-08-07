//
//  ViewController.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NewCrimeDelegate, YZYTableViewDelegate>

@property (weak, nonatomic) IBOutlet YZYTableView *tableView;
@property (strong, nonatomic) YZYTableViewManager *manager;

@property (strong, nonatomic) NSIndexPath *selectedItem;

@property (strong, nonatomic) NSMutableArray *delItems;
@property (strong, nonatomic) NSMutableArray *delCrimes;

@end

@implementation ViewController
#pragma mark - private methods
- (void)newCrimeAction {
    NewCrimeViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewCrimeViewController"];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGRect frame = CGRectMake(width*0.1, height*0.1, width*0.8, height*0.8);
    controller.view.frame = frame;
    controller.delegate = self;
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
- (id)yzyTableViewOnRefrehDoing:(YZYTableView *)tableView {
    [NSThread sleepForTimeInterval:1];
    return nil;
}
- (void)yzyTableView:(YZYTableView *)tableView onRefreshDoneWithResult:(id)result {
    
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
    if (tableView == self.tableView) {
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
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.app.crimeLab removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.app savaDatatoFile];
        }
    }
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
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"批量删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    UIBarButtonItem *newCrimeButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(newCrimeAction)];
    self.navigationItem.leftBarButtonItem = newCrimeButton;

    self.delItems = [[NSMutableArray alloc] init];
    self.delCrimes = [[NSMutableArray alloc] init];
    
    self.tableView.showHeaderView = YES;
    self.tableView.yzyDelegate = self;
    
    self.manager = [[YZYTableViewManager alloc] init];
    [self.manager setTableView:self.tableView forKey:@"test"];
    
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


@end
