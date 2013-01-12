//
//  ListenViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import "ManyListenViewController.h"

@interface ListenViewController : UIViewController<UIScrollViewDelegate>
@property(assign,nonatomic) int grade;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)gotoList:(UIButton *)sender;
@end
