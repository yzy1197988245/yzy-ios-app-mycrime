//
//  DetailViewController.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "DetailViewController.h"
#import "MyCrime.h"
#import "DetailCell.h"
#import "NSObject+MyApplication.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSIndexPath *currentItem;

@property (assign, nonatomic) BOOL isUpdatingLayout;

@end

@implementation DetailViewController
#pragma mark - private methods
- (void)UpdateCollectionViewLayout{
//    NSLog(@"Update layout");
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.collectionView.frame.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.isUpdatingLayout = YES;
    [self.collectionView setCollectionViewLayout:layout];
    self.isUpdatingLayout = NO;
    
//    if (self.currentItem) {
//        [self.collectionView scrollToItemAtIndexPath:self.currentItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    }
}

#pragma mark - assert methods
- (void)setStartIndex:(NSIndexPath *)startIndex{
    NSLog(@"set start index");
    self.currentItem = startIndex;
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.app.crimeLab.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.crime = [self.app.crimeLab objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"willDisplayCell");
    if (!self.isUpdatingLayout) {
        self.currentItem = indexPath;
    }
}



#pragma mark - view events
- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"viewDidLoad!");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear!");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear!");
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.crime.title = self.titleTextField.text;
//    self.crime.isChecked = self.checkSwitch.isOn;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-mm-dd hh-mm-ss zzzzz"];
//    NSDate *date = [formatter dateFromString:self.dateButton.titleLabel.text];
//    self.crime.date = date;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    [self UpdateCollectionViewLayout];
    
    if (self.currentItem) {
        [self.collectionView scrollToItemAtIndexPath:self.currentItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

@end
