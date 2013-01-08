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
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
    UIControl *con=[[UIControl alloc]initWithFrame:CGRectMake(84, 308, 228, 57)];
    [con addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con];
    [con release];
    grade = 12;
}
-(void)goNext
{
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
{
    grade=10;
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
}

- (IBAction)MiddleTwo:(UIButton *)sender
{
    grade=11;
    [_butOne setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
    [_butTwo setBackgroundImage:[UIImage imageNamed:@"choose_but.png"] forState:UIControlStateNormal];
    [_butThree setBackgroundImage:[UIImage imageNamed:@"choose_but1.png"] forState:UIControlStateNormal];
}

- (IBAction)MiddleThree:(UIButton *)sender
{
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
