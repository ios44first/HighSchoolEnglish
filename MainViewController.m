//
//  MainViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize grade;

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
    
    UIImage *image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"titlebar" ofType:@"png"]];
    TikuViewController *tiku=[[TikuViewController alloc]init];
    tiku.grade=self.grade;
    UINavigationController *na1=[[UINavigationController alloc]initWithRootViewController:tiku];
    na1.navigationBar.tintColor=[UIColor colorWithPatternImage:image];

    DicViewController *dic=[[DicViewController alloc]init];
    UINavigationController *na2=[[UINavigationController alloc]initWithRootViewController:dic];
    na2.navigationBar.tintColor=[UIColor colorWithPatternImage:image];
    
    ListenViewController *lis=[[ListenViewController alloc]init];
    lis.grade=self.grade;
    UINavigationController *na3=[[UINavigationController alloc]initWithRootViewController:lis];
    na3.navigationBar.tintColor=[UIColor colorWithPatternImage:image];
    
    MoreViewController *more=[[MoreViewController alloc]init];
    UINavigationController *na4=[[UINavigationController alloc]initWithRootViewController:more];
    na4.navigationBar.tintColor=[UIColor colorWithPatternImage:image];
    
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=[NSArray arrayWithObjects:na1,na2,na3,na4, nil];
    tab.delegate=self;
    tab.selectedIndex=0;
    [self.view addSubview:tab.view];
    [tiku release];
    [dic release];
    [lis release];
    [more release];
    [na1 release];
    [na2 release];
    [na3 release];
    [na4 release];
    
    imgview1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"smart_selected.png"]];
    imgview1.frame=CGRectMake(0, 410, 80, 50);
    [self.view addSubview:imgview1];
    imgview2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dictionary_normal.png"]];
    imgview2.frame=CGRectMake(80, 410, 80, 50);
    [self.view addSubview:imgview2];
    imgview3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"listening_normal.png"]];
    imgview3.frame=CGRectMake(160, 410, 80, 50);
    [self.view addSubview:imgview3];
    imgview4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more_normal.png"]];
    imgview4.frame=CGRectMake(240, 410, 80, 50);
    [self.view addSubview:imgview4];
    
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backView)];
    swipe.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
    [swipe release];
}
-(void)backView
{
    ChooseViewController *choose=[[ChooseViewController alloc]init];
    [self presentViewController:choose animated:YES completion:nil];
    [choose release];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (tabBarController.selectedIndex)
    {
        case 0:
            [imgview1 setImage:[UIImage imageNamed:@"smart_selected.png"]];
            [imgview2 setImage:[UIImage imageNamed:@"dictionary_normal.png"]];
            [imgview3 setImage:[UIImage imageNamed:@"listening_normal.png"]];
            [imgview4 setImage:[UIImage imageNamed:@"more_normal.png"]];
            break;
        case 1:
            [imgview1 setImage:[UIImage imageNamed:@"smart_normal.png"]];
            [imgview2 setImage:[UIImage imageNamed:@"dictionary_selected.png"]];
            [imgview3 setImage:[UIImage imageNamed:@"listening_normal.png"]];
            [imgview4 setImage:[UIImage imageNamed:@"more_normal.png"]];
            break;
        case 2:
            [imgview1 setImage:[UIImage imageNamed:@"smart_normal.png"]];
            [imgview2 setImage:[UIImage imageNamed:@"dictionary_normal.png"]];
            [imgview3 setImage:[UIImage imageNamed:@"listening_selected.png"]];
            [imgview4 setImage:[UIImage imageNamed:@"more_normal.png"]];
            break;
        case 3:
            [imgview1 setImage:[UIImage imageNamed:@"smart_normal.png"]];
            [imgview2 setImage:[UIImage imageNamed:@"dictionary_normal.png"]];
            [imgview3 setImage:[UIImage imageNamed:@"listening_normal.png"]];
            [imgview4 setImage:[UIImage imageNamed:@"more_selected.png"]];
            break;
            
        default:
            break;
    }
}
- (void)dealloc
{
    [imgview1 release];
    [imgview2 release];
    [imgview3 release];
    [imgview4 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
