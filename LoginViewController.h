//
//  LoginViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    BOOL isSelect;
}

@property (retain, nonatomic) IBOutlet UIView *registerView;
@property (retain, nonatomic) IBOutlet UIView *loginView;
@property (retain, nonatomic) IBOutlet UIButton *selectBut;

- (IBAction)registerBut:(UIButton *)sender;
- (IBAction)selectAction:(UIButton *)sender;
- (IBAction)backLogin:(UIButton *)sender;

@end
