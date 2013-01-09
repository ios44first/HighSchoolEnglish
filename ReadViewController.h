//
//  ReadViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-8.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "WanXing.h"

@interface ReadViewController : UIViewController<NSXMLParserDelegate>
{
    UIScrollView *scrollView;
    UIImageView *imgView;
    UITextView *tishiAnswer;
    NSString *readContain;
    BOOL isDown;
}

@property(assign,nonatomic) int i;
@property(retain,nonatomic)Questions *question;
@property(retain,nonatomic) NSArray *arr;
@property(retain,nonatomic) NSString *strTitle;

@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableArray *array;
@property(retain,nonatomic) NSMutableDictionary *dictionary;
@property (retain, nonatomic) IBOutlet UIButton *tiShi;
@property (retain, nonatomic) IBOutlet UIButton *anSwer;
@property (retain, nonatomic) IBOutlet UIButton *nextButton;
@property (retain, nonatomic) IBOutlet UITextView *allContain;

- (IBAction)showTishi:(UIButton *)sender;
- (IBAction)showAnswer:(UIButton *)sender;
- (IBAction)nextTi:(UIButton *)sender;
- (NSString *)filterString:(NSString *)string;
@end
