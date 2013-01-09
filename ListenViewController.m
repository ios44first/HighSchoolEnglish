//
//  ListenViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ListenViewController.h"

@interface ListenViewController ()

@end

@implementation ListenViewController
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    self.navigationItem.title=@"英语听力";
    
    NSLog(@"%d",self.grade);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (IBAction)gotoList:(UIButton *)sender
{
    ListViewController *list=[[ListViewController alloc]init];
    list.grade=grade;
    list.titleType=sender.tag;
    list.url=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=getlisteningthemes&currentpagenum=1&pagesize=20&listentype=%d",sender.tag];
    list.title=@"英语听力";
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}
@end
