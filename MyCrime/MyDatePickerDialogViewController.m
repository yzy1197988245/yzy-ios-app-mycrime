//
//  MyDatePickerDialogViewController.m
//  MyCrime
//
//  Created by mini2 on 15/7/31.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "MyDatePickerDialogViewController.h"
#import "MyPresentationController.h"

@interface MyDatePickerDialogViewController () <UIViewControllerTransitioningDelegate>

//@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancleButtonClicked:(UIButton *)sender;
- (IBAction)okButtonClicked:(UIButton *)sender;

- (IBAction)dateChanged:(UIDatePicker *)sender;

- (IBAction)todayButtonClicked:(UIButton *)sender;

@end

@implementation MyDatePickerDialogViewController

- (void)setDateNow:(NSDate *)dateNow {
    _dateNow = dateNow;
    self.datePicker.date = dateNow;
}

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    if (modalPresentationStyle == UIModalPresentationCustom) {
        [super setModalPresentationStyle:modalPresentationStyle];
        self.transitioningDelegate = self;
    } else {
        [super setModalPresentationStyle:modalPresentationStyle];
    }
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    if (presented == self) {
        MyPresentationController *controller = [[MyPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
        return controller;
    } else {
        return nil;
    }
}

- (IBAction)cancleButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okButtonClicked:(UIButton *)sender {
    self.dateNow = self.datePicker.date;
}
- (IBAction)dateChanged:(UIDatePicker *)sender {
    self.dateNow = self.datePicker.date;
//    NSLog(@"dateChanged");
}

- (IBAction)todayButtonClicked:(UIButton *)sender {
    self.dateNow = [NSDate date];
    self.datePicker.date = [NSDate date];
}
@end
