//
//  WordViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-30.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWord.h"

@interface WordViewController : UIViewController

@property (retain,nonatomic) UITextView *word;
@property (retain,nonatomic) UITextView *translation;
@property (retain,nonatomic) NewWord *newword;
@property (retain,nonatomic) NSArray *array;
@property (assign,nonatomic) int i;

@end
