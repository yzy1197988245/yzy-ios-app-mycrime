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

@property (assign, nonatomic) BOOL isUpdatingLayout;
@property (assign, nonatomic) CGSize collectionViewCellSize;

@end

@implementation DetailViewController
#pragma mark - private methods
- (void)UpdateCollectionViewLayout{
    if (!CGSizeEqualToSize(self.collectionViewCellSize , self.collectionView.frame.size)) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.collectionView.frame.size;
        self.collectionViewCellSize = self.collectionView.frame.size;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsZero;
        
        self.isUpdatingLayout = YES;
        [self.collectionView setCollectionViewLayout:layout];
        self.isUpdatingLayout = NO;
        
        [self.collectionView scrollToItemAtIndexPath:self.currentItem atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        [self.view layoutSubviews];
    }
}

#pragma mark - assert methods


#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.app.crimeLab.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.crime = [self.app.crimeLab objectAtIndex:indexPath.row];
    cell.viewController = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isUpdatingLayout) {
        self.currentItem = indexPath;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateView" object:indexPath];
    }
}


#pragma mark - view events

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self UpdateCollectionViewLayout];
}

@end
