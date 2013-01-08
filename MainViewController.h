//
//  MainViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreViewController.h"
#import "DicViewController.h"
#import "ListenViewController.h"
#import "TikuViewController.h"

@interface MainViewController : UIViewController<UITabBarControllerDelegate>
{
    UIImageView *imgview1;
    UIImageView *imgview2;
    UIImageView *imgview3;
    UIImageView *imgview4;
}

@property(assign,nonatomic) int grade;

@end
