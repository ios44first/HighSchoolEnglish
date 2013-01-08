//
//  TikuViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseViewController.h"
#import "ListViewController.h"


@interface TikuViewController : UIViewController<UICollectionViewDelegate>
{
	UIScrollView *scrollView;
	NSInteger prevButtonIndex;
	UIImage *btnStretchImg;
    int year;
}
@property(assign,nonatomic) int grade;
- (IBAction)goToList:(UIButton *)sender;


- (void)addTitleButtons;
- (void)selectButtonAtIndex:(NSUInteger)index;

@end
