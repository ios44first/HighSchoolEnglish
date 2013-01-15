//
//  WrongViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "WrongViewController.h"

@interface WrongViewController ()

@end

@implementation WrongViewController

@synthesize array;

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
    
    //self.navigationItem.rightBarButtonItem=self.editButtonItem;

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
    
    self.array=[NSMutableArray array];
    DataFactory *factory=[DataFactory instance];
    id delegate=[[UIApplication sharedApplication]delegate];
    factory.managedObjectContext=[delegate managedObjectContext];
    NSMutableArray *tem=[NSMutableArray array];
    for (id temp in [factory getData:@"DanXuan" andSort:@"createDate"])
    {
        [tem addObject:temp];
    }
    [self.array addObject:[NSArray arrayWithArray:tem]];
    [tem removeAllObjects];
    for (id temp in [factory getData:@"ReadArtical" andSort:@"createDate"])
    {
        [tem addObject:temp];
    }
    [self.array addObject:[NSArray arrayWithArray:tem]];
    [tem removeAllObjects];
    for (id temp in [factory getData:@"DuoXuan" andSort:@"createDate"])
    {
        [tem addObject:temp];
    }
    [self.array addObject:[NSArray arrayWithArray:tem]];
    [tem removeAllObjects];
    num=[[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1", nil];
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
-(void)tapHeader:(UIButton *)sender
{
    if ([[num objectAtIndex:sender.tag - 100]intValue]==1)
        [num replaceObjectAtIndex:sender.tag - 100 withObject:@"0"];
    else
        [num replaceObjectAtIndex:sender.tag - 100 withObject:@"1"];
    [self.tableView reloadData];
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *ti=@"";
    switch (section)
    {
        case 0:
            ti=@"单选题";
            break;
        case 1:
            ti=@"阅读理解";
            break;
        case 2:
            ti=@"多选题";
            break;
    }
    UIView * mySectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(0, 0, 320, 30);
    myButton.tag = 100 + section;
    [myButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"titlebar.png"]]];
    [myButton addTarget:self action:@selector(tapHeader:) forControlEvents:UIControlEventTouchUpInside];
    [mySectionView addSubview:myButton];
    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 30)];
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.text = ti;
    [myButton addSubview:myLabel];
    [myLabel release];
    return mySectionView;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"单选题";
            break;
        case 1:
            return @"阅读理解";
            break;
        case 2:
            return @"多选题";
            break;
    }
    return @"";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[num objectAtIndex:section]intValue]==1)
    {
        return [[self.array objectAtIndex:section]count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image=[UIImage imageNamed:@"bg_point.png"];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    if (indexPath.section==1)
    {
        ReadArtical *read=[[self.array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.textLabel.text=read.contain;
        NSString *temp=@"";
        switch ([read.titleType intValue])
        {
           case 15:temp=[temp stringByAppendingFormat:@"阅读理解"];break;
           case 16:temp=[temp stringByAppendingFormat:@"补全阅读"];break;
           case 17:temp=[temp stringByAppendingFormat:@"短文改错"];break;
           case 18:temp=[temp stringByAppendingFormat:@"书面表达"];break;
           case 19:temp=[temp stringByAppendingFormat:@"单词拼写"];break;
           case 20:temp=[temp stringByAppendingFormat:@"阅读表达"];break;
           case 21:temp=[temp stringByAppendingFormat:@"情景对话"];break;
           case 24:temp=[temp stringByAppendingFormat:@"翻 译"];break;
           case 28:temp=[temp stringByAppendingFormat:@"句型转换"];break;
        }
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@           %@",temp,[format stringFromDate:read.createDate]];
    }
    else if (indexPath.section==2)
    {
        DuoXuan *duo=[[self.array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.textLabel.text=duo.title;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"完形填空           %@",[format stringFromDate:duo.createDate]];
    }
    else if (indexPath.section==0)
    {
        DanXuan *dan=[[self.array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.textLabel.text=dan.title;
        if ([dan.titleType intValue]==1)
            cell.detailTextLabel.text=[NSString stringWithFormat:@"单选题           %@",[format stringFromDate:dan.createDate]];
        else
            cell.detailTextLabel.text=[NSString stringWithFormat:@"语音知识            %@",[format stringFromDate:dan.createDate]];
    }
    else
    {
        cell.textLabel.text=@"暂无标题。。。";
        cell.detailTextLabel.text=@"暂无信息。。。";
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
