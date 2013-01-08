//
//  ChooseViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface ChooseViewController : UIViewController
{
    int grade;
}
@property (retain, nonatomic) IBOutlet UIButton *butOne;
@property (retain, nonatomic) IBOutlet UIButton *butTwo;
@property (retain, nonatomic) IBOutlet UIButton *butThree;

- (IBAction)MiddleOne:(UIButton *)sender;
- (IBAction)MiddleTwo:(UIButton *)sender;
- (IBAction)MiddleThree:(UIButton *)sender;

@end
