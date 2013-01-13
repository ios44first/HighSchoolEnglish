//
//  LoginViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (![self.inputWord isExclusiveTouch])
//    {
//        [self.inputWord resignFirstResponder];
//    }
//}
#pragma mark -
#pragma mark 隐藏tabbar
- (void)viewWillAppear: (BOOL)animated
{
    [self hideTabBar:YES];
}
- (void)viewWillDisappear: (BOOL)animated
{
    [self hideTabBar:NO];
}

- (void) hideTabBar:(BOOL) hidden
{
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden)
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
            } else
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
            }
        }
    }
    UIView *superView=[self.tabBarController.view superview];
    for(UIView *view in superView.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
        {
            if (hidden)
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
                superView.frame=CGRectMake(0, 20, 320, 510);
            } else
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
                superView.frame=CGRectMake(0, 20, 320, 460);
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_selectBut release];
    [_loginView release];
    [_registerView release];
    [super dealloc];
}
- (IBAction)registerBut:(UIButton *)sender
{
    self.loginView.hidden=YES;
    self.registerView.hidden=NO;
}
- (IBAction)selectAction:(UIButton *)sender
{
    if (isSelect)
    {
        isSelect=NO;
        [sender setImage:[UIImage imageNamed:@"btn_selected_no.png"] forState:UIControlStateNormal];
    }
    else
    {
        isSelect=YES;
        [sender setImage:[UIImage imageNamed:@"btn_selected_yes.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)backLogin:(UIButton *)sender
{
    self.loginView.hidden=NO;
    self.registerView.hidden=YES;
}
@end
