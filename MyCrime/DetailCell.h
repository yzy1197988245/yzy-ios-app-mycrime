//
//  DetailCell.h
//  MyCrime
//
//  Created by mini2 on 15/7/28.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCrime.h"
#import "DetailViewController.h"

@interface DetailCell : UICollectionViewCell

@property (nonatomic, weak) MyCrime *crime;
@property (nonatomic, weak) DetailViewController *viewController;

@end
