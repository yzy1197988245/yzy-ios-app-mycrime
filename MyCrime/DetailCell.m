//
//  DetailCell.m
//  MyCrime
//
//  Created by mini2 on 15/7/28.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UISwitch *checkSwitch;

- (IBAction)dateButtonClicked:(UIButton *)sender;

@end

@implementation DetailCell
- (void)setCrime:(MyCrime *)crime{
    if (_crime.title == crime.title) {
        return;
    }
    
    _crime = crime;
    
    self.titleTextField.text = crime.title;
    [self.dateButton setTitle:crime.date.description forState:UIControlStateNormal];
    self.checkSwitch.on = crime.isChecked;
    
}

//- (void)awakeFromNib{
//    [super awakeFromNib];
//}
//
//- (void)prepareForReuse{
//    [super prepareForReuse];
//    
//}


- (IBAction)dateButtonClicked:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:@"test" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles: nil];
    [alert show];
}
@end
