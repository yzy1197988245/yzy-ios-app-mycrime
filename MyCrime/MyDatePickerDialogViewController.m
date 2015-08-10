//
//  MyDatePickerDialogViewController.m
//  MyCrime
//
//  Created by mini2 on 15/7/31.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "MyDatePickerDialogViewController.h"
#import "MyPresentationController.h"

@interface MyDatePickerDialogViewController ()

//@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancleButtonClicked:(UIButton *)sender;
- (IBAction)okButtonClicked:(UIButton *)sender;
- (IBAction)todayButtonClicked:(UIButton *)sender;

@end

@implementation MyDatePickerDialogViewController


- (void)setDateNow:(NSDate *)dateNow {
    _dateNow = dateNow;
    self.yzyPopoverStyle = YZYPopoverViewStyleDialog;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 400) / 2;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - 300) /2;
    self.view.frame = CGRectMake(x, y, 400, 300);
}

- (IBAction)cancleButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okButtonClicked:(UIButton *)sender {
    self.dateNow = self.datePicker.date;
    if (self.dateChangedDelegate) {
        [self.dateChangedDelegate onDateChanged:self.dateNow];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (IBAction)todayButtonClicked:(UIButton *)sender {
    self.dateNow = [NSDate date];
    self.datePicker.date = [NSDate date];
}

- (void)viewDidLoad {
    self.datePicker.date = self.dateNow;
}
@end

