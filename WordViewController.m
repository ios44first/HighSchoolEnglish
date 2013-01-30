//
//  WordViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-30.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()

@end

@implementation WordViewController
@synthesize word,translation,newword,array,i;

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
    self.navigationItem.title=@"生词详细信息";
    UIImage* image= [UIImage imageNamed:@"return_pressed.png"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* back= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:back];
    [back release];
    [backButton release];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 20)];
    title.text=@"生 词：";
    title.textColor=[UIColor colorWithRed:0 green:0.4 blue:1 alpha:1.0];
    [self.view addSubview:title];
    [title release];
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0, 25, 320, 50)];
    text.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1.0];
    text.font=[UIFont systemFontOfSize:17];
    //text.textAlignment=NSTextAlignmentCenter;
    text.editable = NO;
    self.word=text;
    [self.view addSubview:self.word];
    [text release];
    UILabel *tr=[[UILabel alloc]initWithFrame:CGRectMake(0, 81, 320, 20)];
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 76, 320, 1)];
    imgV.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:imgV];
    [imgV release];
    tr.text=@"词 义：";
    tr.textColor=[UIColor colorWithRed:0 green:0.4 blue:1 alpha:1.0];
    [self.view addSubview:tr];
    [tr release];
    UITextView *trans = [[UITextView alloc]initWithFrame:CGRectMake(0, 101, 320, 220)];
    trans.textColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1.0];
    trans.font=[UIFont systemFontOfSize:17];
    //trans.textAlignment=NSTextAlignmentCenter;
    trans.editable = NO;
    self.translation=trans;
    [self.view addSubview:self.translation];
    [trans release];
    
    UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame=CGRectMake(0, 325, 320, 44);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"item_pressed.png"] forState:UIControlStateNormal];
    [nextButton setTitle:@"下  一  个" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
	
    [self getData];
}
-(void)getData
{
    self.word.text=self.newword.title;
    self.translation.text=self.newword.result;
}
-(void)nextWord
{
    if (i<[self.array count]-1)
    {
        self.newword=[self.array objectAtIndex:++i];
        [self getData];
    }
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
