//
//  MoreViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.title=@"更多";
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 3;
    }
    else if (section==1)
    {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.imageView.image=[UIImage imageNamed:@"icon_word.png"];
                cell.textLabel.text=@"生词本";
                break;
            case 1:
                cell.imageView.image=[UIImage imageNamed:@"icon_wrong.png"];
                cell.textLabel.text=@"错题本";
                break;
            case 2:
                cell.imageView.image=[UIImage imageNamed:@"icon_sync.png"];
                cell.textLabel.text=@"会员管理";
                break;
            default:
                break;
        }

    }
    if (indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.imageView.image=[UIImage imageNamed:@"icon_member.png"];
                cell.textLabel.text=@"关于我们";
                break;
            case 1:
                cell.imageView.image=[UIImage imageNamed:@"icon_exit.png"];
                cell.textLabel.text=@"退出程序";
                break;
                /*case 3:
                 cell.imageView.image=[UIImage imageNamed:@"icon_favorite.png"];
                 cell.textLabel.text=@"信息同步";
                 break;
                 case 4:
                 cell.imageView.image=[UIImage imageNamed:@"icon_sync.png"];
                 cell.textLabel.text=@"应用推荐";
                 break;*/
            default:
                break;
        }
    }
        
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                DetailViewController *detailViewController = [[DetailViewController alloc] init];
                detailViewController.title=@"生词本";
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }
                break;
            case 1:
            {
                WrongViewController *detailViewController = [[WrongViewController alloc] init];
                detailViewController.title=@"错 题 本";
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }
                break;
            case 2:
            {
                LoginViewController *detailViewController = [[LoginViewController alloc] init];
                detailViewController.title=@"会 员 登 陆";
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }
                break;
        }
    }
    if (indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                AboutViewController *about=[[AboutViewController alloc]init];
                [self.navigationController pushViewController:about animated:YES];
                [about release];
            }
                break;
            case 1:
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
                break;
        }
    }
}
#pragma mark -
#pragma mark UIAlertViewDelegate Methods
-(void)willPresentAlertView:(UIAlertView *)alertView
{
    alertView.frame=CGRectMake(35, 150, 250, 130);
    for (UIView *view in  alertView.subviews)
    {
        [view removeFromSuperview];
    }
    UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 130)];
    iv.image=[UIImage imageNamed:@"bg_reviewwords.png"];
    [alertView addSubview:iv];
    [iv release];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 160, 60)];
    label.text=@"您确定要退出吗？";
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor colorWithRed:0.22 green:0.66 blue:1 alpha:1.0];
    [alertView addSubview:label];
    [label release];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[UIImage imageNamed:@"btn_closereview_pressed.png"] forState:UIControlStateNormal];
    close.tag=10;
    [close addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    close.frame=CGRectMake(205, 0, 45, 36);
    [alertView addSubview:close];
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setImage:[UIImage imageNamed:@"member_btn_cancel.png"] forState:UIControlStateNormal];
    cancel.tag=11;
    [cancel addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    cancel.frame=CGRectMake(30, 84, 80, 32);
    [alertView addSubview:cancel];
    UIButton *ok=[UIButton buttonWithType:UIButtonTypeCustom];
    [ok setImage:[UIImage imageNamed:@"member_btn_ok.png"] forState:UIControlStateNormal];
    ok.tag=12;
    [ok addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    ok.frame=CGRectMake(140, 84, 80, 32);
    [alertView addSubview:ok];
}
-(void)closeAlert:(UIButton *)sender
{
    if (sender.tag!=12)
    {
        UIAlertView *sup=(UIAlertView *)[sender superview];
        [sup dismissWithClickedButtonIndex:0 animated:YES];
    }
    else
        exit(0);
}

@end
