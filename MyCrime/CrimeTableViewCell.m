//
//  CrimeTableViewCell.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "CrimeTableViewCell.h"

@interface CrimeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UISwitch *isChecked;

- (IBAction)switchClicked:(UISwitch *)sender;

@end

@implementation CrimeTableViewCell
#pragma mark - assert methods
- (void)setCrime:(MyCrime *)crime{
    _crime = crime;
    self.title.text = crime.title;
    self.isChecked.on = crime.isChecked;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:crime.date];
    self.date.text = dateString;
}

- (IBAction)switchClicked:(UISwitch *)sender {
    self.crime.isChecked = sender.isOn;
}

@end
