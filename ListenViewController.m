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
    switch (sender.tag)
    {
        case 610:
        case 641:
        case 669:
        case 670:
        case 671:
        case 672:
        case 675:
        {
            ListViewController *list=[[ListViewController alloc]init];
            list.grade=grade;
            list.titleType=sender.tag;
            list.TIKU=NO;
            list.title=@"英语听力";
            [self.navigationController pushViewController:list animated:YES];
            [list release];
        }
            break;
        case 647:
        case 650:
        case 651:
        case 653:
        case 645:
        case 673:
        case 674:
        case 680:
        case 681:
        case 683:
        case 684:
        {
            ManyListenViewController *many=[[ManyListenViewController alloc]init];
            many.title=@"短文听力";
            many.titleType=sender.tag;
            [self.navigationController pushViewController:many animated:YES];
            [many release];
        }
            break;
            
        default:
            break;
    }
}
@end
