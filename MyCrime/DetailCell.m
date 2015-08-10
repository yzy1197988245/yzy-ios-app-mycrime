//
//  DetailCell.m
//  MyCrime
//
//  Created by mini2 on 15/7/28.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "DetailCell.h"
#import "MyDatePickerDialogViewController.h"

@interface DetailCell () <MyDateChangedDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UISwitch *checkSwitch;

- (IBAction)dateButtonClicked:(UIButton *)sender;
- (IBAction)titleChanged:(UITextField *)sender;
- (IBAction)checkChanged:(UISwitch *)sender;


@end

@implementation DetailCell

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.titleTextField endEditing:YES];
}

- (void)onDateChanged:(NSDate *)date {
    if (self.crime.date.description != date.description) {
        self.crime.date = date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateString = [formatter stringFromDate:self.crime.date];
        [self.dateButton setTitle:dateString forState:UIControlStateNormal];
    }
}

- (void)setCrime:(MyCrime *)crime{
    if (_crime.title == crime.title) {
        return;
    }
    
    _crime = crime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:self.crime.date];
    
    self.titleTextField.text = crime.title;
    [self.dateButton setTitle:dateString forState:UIControlStateNormal];
    self.checkSwitch.on = crime.isChecked;
    
}

- (IBAction)dateButtonClicked:(UIButton *)sender {
    MyDatePickerDialogViewController *controller = [self.viewController.storyboard instantiateViewControllerWithIdentifier:@"DatePickerController"];
    controller.dateNow = self.crime.date;
    controller.dateChangedDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self.viewController presentViewController:controller animated:YES completion:nil];
}

- (IBAction)titleChanged:(UITextField *)sender {
    self.crime.title = sender.text;
}

- (IBAction)checkChanged:(UISwitch *)sender {
    self.crime.isChecked = sender.isOn;
}




@end
