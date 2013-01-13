//
//  DetailViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWordViewController.h"

@interface DetailViewController : UIViewController<UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *timeView;
@property (retain, nonatomic) IBOutlet UISwitch *onButton;

- (IBAction)wordList:(UIButton *)sender;
- (IBAction)wordAlert:(UIButton *)sender;
- (IBAction)onOFF:(UISwitch *)sender;
- (IBAction)addTime:(UIButton *)sender;
- (IBAction)reduceTime:(UIButton *)sender;
- (IBAction)submitTime:(UIButton *)sender;

@end
