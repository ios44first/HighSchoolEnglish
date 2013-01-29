//
//  DicViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewWord.h"
#import "JSON.h"
#import "NSString+Filter.h"

@interface DicViewController : UIViewController<UITextFieldDelegate>
{
    BOOL exChangeL;
    //UIBarButtonItem* back;
    UIButton* backButton;
    UIImageView *imgV;
}
@property (retain, nonatomic) IBOutlet UITextField *inputWord;
@property (retain, nonatomic) IBOutlet UITextView *translationView;

- (IBAction)searchWord:(UIButton *)sender;
@end
