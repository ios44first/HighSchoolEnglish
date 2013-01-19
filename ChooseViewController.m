//
//  ChooseViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ChooseViewController.h"

@interface ChooseViewController ()

@end

@implementation ChooseViewController

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
//设置选择年级的按钮
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
//设置进入下一页的点击区域
    UIControl *con=[[UIControl alloc]initWithFrame:CGRectMake(84, 308, 228, 57)];
    [con addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con];
    [con release];
    grade = 12;
}

-(void)goNext
{//进入主界面
    MainViewController *mainView=[[MainViewController alloc]init];
    mainView.grade=grade;
    //[self presentModalViewController:mainView animated:YES];
    [self presentViewController:mainView animated:YES completion:nil];
    [mainView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MiddleOne:(UIButton *)sender
{//选择年级
    grade=10;
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
}

- (IBAction)MiddleTwo:(UIButton *)sender
{//选择年级
    grade=11;
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
}

- (IBAction)MiddleThree:(UIButton *)sender
{//选择年级
    grade=12;
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
}
- (void)dealloc {
    [_butOne release];
    [_butTwo release];
    [_butThree release];
    [super dealloc];
}
@end
