//
//  NewCrimeViewController.m
//  MyCrime
//
//  Created by mini2 on 15/8/5.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "NewCrimeViewController.h"
#import "MyCrime.h"
#import "MyDatePickerDialogViewController.h"
#import "MyPresentationController.h"

@interface NewCrimeViewController () <UIViewControllerTransitioningDelegate, MyDateChangedDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;


- (IBAction)titleChanged:(UITextField *)sender;
- (IBAction)dateChanged:(UIButton *)sender;
- (IBAction)okButtonClicked:(UIButton *)sender;
- (IBAction)cancleButtonClicked:(UIButton *)sender;


@property (strong, nonatomic) MyCrime *crime;

@end

@implementation NewCrimeViewController

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.view.frame = CGRectMake(width*0.1, height*0.1, width*0.8, height*0.8);
    
    [super setModalPresentationStyle:modalPresentationStyle];
}

- (void)onDateChanged:(NSDate *)date {
    self.crime.date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    [self.dateButton setTitle:[dateFormatter stringFromDate:self.crime.date] forState:UIControlStateNormal];
}

- (IBAction)titleChanged:(UITextField *)sender {
    self.crime.title = sender.text;
}


- (IBAction)dateChanged:(UIButton *)sender {
    MyDatePickerDialogViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerController"];
    controller.dateNow = self.crime.date;
    controller.dateChangedDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)okButtonClicked:(UIButton *)sender {
    if (self.delegate) {
        self.crime.title = self.titleTextField.text;
        [self.delegate onCrimeCreated:self.crime];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancleButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.crime = [[MyCrime alloc] init];
    self.crime.title = @"";
    self.crime.isChecked = NO;
    self.crime.date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    [self.dateButton setTitle:[dateFormatter stringFromDate:self.crime.date] forState:UIControlStateNormal];

    [self.titleTextField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.titleTextField endEditing:YES];
}

@end
