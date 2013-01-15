//
//  doWorkViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-7.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "DanXuanTi.h"
#import "NSString+Filter.h"
#import "DanXuan.h"

@interface doWorkViewController : UIViewController<NSXMLParserDelegate>
{
    NSString *answer;
}

@property(assign,nonatomic) int i,titleType;
@property(retain,nonatomic) Questions *question;
@property(retain,nonatomic) DanXuanTi *danxuanti;
@property(retain,nonatomic) NSArray *arr;
@property(retain,nonatomic) NSString *strTitle;
@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableDictionary *dictionary;
@property (retain, nonatomic) IBOutlet UILabel *questionContain;
@property (retain, nonatomic) IBOutlet UILabel *chooseA;
@property (retain, nonatomic) IBOutlet UILabel *chooseB;
@property (retain, nonatomic) IBOutlet UILabel *chooseC;
@property (retain, nonatomic) IBOutlet UILabel *chooseD;
@property (retain, nonatomic) IBOutlet UIButton *butA;
@property (retain, nonatomic) IBOutlet UIButton *butB;
@property (retain, nonatomic) IBOutlet UIButton *butC;
@property (retain, nonatomic) IBOutlet UIButton *butD;

- (IBAction)nextQuestion:(UIButton *)sender;
- (IBAction)tiShi:(UIButton *)sender;
- (IBAction)submitAnswer:(UIButton *)sender;
- (IBAction)chooseAnswer:(UIButton *)sender;

@end
