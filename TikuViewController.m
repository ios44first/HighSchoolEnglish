//
//  TikuViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "TikuViewController.h"

@interface TikuViewController ()

@end

@implementation TikuViewController
@synthesize grade;

const NSUInteger btnNumber = 14;
const NSUInteger screenWidth = 320;
const NSUInteger btnWidth = 60;
const NSUInteger btnHeight = 30;
const NSUInteger btnInterval = 60;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    year=1999;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    self.navigationItem.title=@"智能题库";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, btnHeight)];
	scrollView.userInteractionEnabled = YES;
	scrollView.scrollEnabled = YES;
	[scrollView setContentSize:CGSizeMake(btnNumber * btnInterval, btnHeight)];
	scrollView.backgroundColor = [UIColor colorWithRed:0.22 green:0.77 blue:0.99 alpha:1.0];
	[self.view addSubview:scrollView];
    //[scrollView setContentOffset:CGPointMake(btnNumber * btnInterval-screenWidth, 0) animated:YES];
    btnStretchImg= [UIImage imageNamed:@"select.png"];
    [self addTitleButtons];
    
    NSLog(@"%d",self.grade);
}

- (IBAction)goToList:(UIButton *)sender
{
    ListViewController *list=[[ListViewController alloc]init];
    list.grade=grade;
    list.year=year;
    list.titleType=sender.tag;
    list.title=sender.titleLabel.text;
    list.TIKU=YES;
    /*if (year==1999)
        list.url=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d&currentpagenum=xx",self.grade,sender.tag];
    else
        list.url=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d&year=%d&currentpagenum=xx",self.grade,sender.tag,year];*/
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

- (void)addTitleButtons
{
	UIButton *btn;
	
	for (int i = 0; i < btnNumber; i++) {
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(btnInterval * i, 0, btnWidth, btnHeight);
        if (i==0)
           [btn setTitle:[NSString stringWithFormat:@"不限"] forState:UIControlStateNormal];
        else
		   [btn setTitle:[NSString stringWithFormat:@"%d", i + 1999] forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = i;
		[scrollView addSubview:btn];
	}
	[self selectButtonAtIndex:0];
}
- (void)selectButtonAtIndex:(NSUInteger)index
{
	UIButton *selectedBtn = [[scrollView subviews] objectAtIndex:index];
	[selectedBtn setBackgroundImage:btnStretchImg forState:UIControlStateNormal];
	[selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	prevButtonIndex = index;
}
- (void)deselectButtonAtIndex:(NSUInteger)prevIndex
{
	UIButton *deselectedBtn = [[scrollView subviews] objectAtIndex:prevIndex];
	[deselectedBtn setBackgroundImage:nil forState:UIControlStateNormal];
	[deselectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)buttonSelected:(id)sender
{
	UIButton *selectedBtn = (UIButton *)sender;
	NSUInteger index = selectedBtn.tag;
	year=index+1999;
	if (index != prevButtonIndex) {
		[self deselectButtonAtIndex:prevButtonIndex];
		[self selectButtonAtIndex:index];
		[scrollView scrollRectToVisible:CGRectMake(btnInterval * (index - 1), 20, screenWidth, btnHeight) animated:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
