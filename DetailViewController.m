//
//  DetailViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    self.array=[NSMutableArray array];
    [self getData];
}
-(void)getData
{
    [self.array removeAllObjects];
    factory=[DataFactory instance];
    id delegate=[[UIApplication sharedApplication]delegate];
    factory.managedObjectContext=[delegate managedObjectContext];
    for (id temp in [factory getData:@"NewWord" andSort:@"createDate"])
    {
        [self.array addObject:temp];
    }
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark UIAlertViewDelegate Methods
-(void)willPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.tag==100)
    {
        alertView.frame=CGRectMake(10, 150, 300, 165);
        for (UIView *view in  alertView.subviews)
        {
            if ([view isKindOfClass:[UILabel class]])
            {
                UILabel *label=(UILabel *)view;
                label.textColor=[UIColor colorWithRed:0.22 green:0.77 blue:0.99 alpha:1.0];
            }
            if ([view isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)view;
                img.image=[UIImage imageNamed:@"bg_reviewwords.png"];
            }
            if (view.tag==1)
            {
                [view removeFromSuperview];
            }
        }
        
        UIButton *close=[UIButton buttonWithType:UIButtonTypeCustom];
        [close setImage:[UIImage imageNamed:@"btn_closereview_pressed.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
        close.frame=CGRectMake(255, 0, 45, 36);
        [alertView addSubview:close];
        contain=[[UITextView alloc]initWithFrame:CGRectMake(10, 40, 280, 80)];
        contain.backgroundColor=[UIColor clearColor];
        contain.editable=NO;
        [self getData];
        index=0;
        if ([self.array count]>0)
        {
            word=[self.array objectAtIndex:0];
            contain.text=[NSString stringWithFormat:@"%@\n%@",word.title,word.result];
        }
        else
            contain.text=@"暂无内容。。。";
        contain.font=[UIFont systemFontOfSize:17];
        [alertView addSubview:contain];
        [contain release];
        UIButton *preButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [preButton setImage:[UIImage imageNamed:@"btn_previous_pressed.png"] forState:UIControlStateNormal];
        [preButton addTarget:self action:@selector(preOne) forControlEvents:UIControlEventTouchUpInside];
        preButton.frame=CGRectMake(12, 120, 82, 38);
        [alertView addSubview:preButton];
        UIButton *deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"btn_delete_curword_pressed.png"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteOne) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.frame=CGRectMake(108, 120, 82, 38);
        [alertView addSubview:deleteButton];
        UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"btn_next_pressed.png"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextOne) forControlEvents:UIControlEventTouchUpInside];
        nextButton.frame=CGRectMake(204, 120, 82, 38);
        [alertView addSubview:nextButton];
    }
    else
    {
        alertView.frame=CGRectMake(10, 150, 300, 180);
        for (UIView *view in  alertView.subviews)
        {
            [view removeFromSuperview];
        }
        UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 180)];
        iv.image=[UIImage imageNamed:@"bg_reviewwords.png"];
        [alertView addSubview:iv];
        [iv release];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(45, 0, 210, 36)];
        label.text=title;
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:0.22 green:0.66 blue:1 alpha:1.0];
        [alertView addSubview:label];
        [label release];
        
        UIButton *close=[UIButton buttonWithType:UIButtonTypeCustom];
        [close setImage:[UIImage imageNamed:@"btn_closereview_pressed.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
        close.frame=CGRectMake(255, 0, 45, 36);
        [alertView addSubview:close];
        
        message = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, 280, 120)];
        message.editable=NO;
        message.textColor=[UIColor colorWithRed:0.22 green:0.66 blue:1 alpha:1.0];
        message.font=[UIFont systemFontOfSize:17];
        message.textAlignment=NSTextAlignmentCenter;
        [message setBackgroundColor:[UIColor clearColor]];
        message.text=msg;
        [alertView addSubview:message];
    }
}
-(void)preOne
{
    if ([self.array count]>0)
    {
        if (index>0&&index<[self.array count])
        {
            word=[self.array objectAtIndex:--index];
            contain.text=[NSString stringWithFormat:@"%@\n%@",word.title,word.result];
        }
    }
}
-(void)deleteOne
{
    if ([self.array count]>0)
    {
        id tem=[self.array objectAtIndex:index];
        [factory.managedObjectContext deleteObject:tem];
        [self.array removeObjectAtIndex:index];
        NSError *error;
        if (![factory.managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        //[self getData];
        if ([self.array count]>0)
        {
            --index;
            if (-1<index&&index<[self.array count])
            {
                word=[self.array objectAtIndex:index];
                contain.text=[NSString stringWithFormat:@"%@\n%@",word.title,word.result];
            }
            else
            {
                index=0;
                word=[self.array objectAtIndex:0];
                contain.text=[NSString stringWithFormat:@"%@\n%@",word.title,word.result];
            }
        }
        else
            contain.text=@"暂无内容。。。";
    }
}
-(void)nextOne
{
    if ([self.array count]>0)
    {
        if (index>-1&&index<[self.array count]-1)
        {
            word=[self.array objectAtIndex:++index];
            contain.text=[NSString stringWithFormat:@"%@\n%@",word.title,word.result];
        }
    }
}
-(void)closeAlert:(UIButton *)sender
{
    UIAlertView *sup=(UIAlertView *)[sender superview];
    [sup dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark -
- (IBAction)wordList:(UIButton *)sender
{
    NewWordViewController *newWord=[[NewWordViewController alloc]init];
    newWord.title=@"生 词 本";
    [self.navigationController pushViewController:newWord animated:YES];
    [newWord release];
}

- (IBAction)wordAlert:(UIButton *)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"生 词 回 顾" message:@"" delegate:self cancelButtonTitle:@"返   回" otherButtonTitles:nil, nil];
    alert.tag=100;
    [alert show];
    [alert release];
}

- (IBAction)onOFF:(UISwitch *)sender
{
}

- (IBAction)addTime:(UIButton *)sender
{
    NSString *hour=[self.timeView.text substringToIndex:2];
    NSString *minute=[self.timeView.text substringFromIndex:11];
    //NSLog(@"-%@-%@-",hour,minute);
    //07    :    00
    int newHour=[hour intValue];
    int newMinute=[minute intValue];
    if (sender.tag==1)
    {
        if (newHour>-1&&newHour<24)
           newHour += 1;
    }
    else if (sender.tag==2)
    {
        if (newMinute>-1&&newMinute<60)
            newMinute += 1;
    }
    NSString *result=[NSString stringWithFormat:@"%02d    :    %02d",newHour,newMinute];
    self.timeView.text=result;
}

- (IBAction)reduceTime:(UIButton *)sender
{
    NSString *hour=[self.timeView.text substringToIndex:2];
    NSString *minute=[self.timeView.text substringFromIndex:11];
    int newHour=[hour intValue];
    int newMinute=[minute intValue];
    if (sender.tag==3)
    {
        if (newHour>0&&newHour<25)
            newHour -= 1;
    }
    else if (sender.tag==4)
    {
        if (newMinute>0&&newMinute<61)
            newMinute -= 1;
    }
    NSString *result=[NSString stringWithFormat:@"%02d    :    %02d",newHour,newMinute];
    self.timeView.text=result;
}

- (IBAction)submitTime:(UIButton *)sender
{
    title=@"温馨提示：";
    msg=[NSString stringWithFormat:@"生词提醒时间设置成功！\n%@   将提醒您查看生词本。",self.timeView.text];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示：" message:[NSString stringWithFormat:@"生词提醒时间设置成功！\n%@   将提醒您查看生词本。",self.timeView.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
    //设置闹钟
    NSString *hour=[self.timeView.text substringToIndex:2];
    NSString *minute=[self.timeView.text substringFromIndex:11];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dageStr = [NSString stringWithFormat:@"%@ %d:%@:00",[[[NSDate date] description] substringToIndex:10],[hour intValue],minute];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *_date =  [dateFormatter dateFromString:dageStr];
    //NSLog(@"%@,%@",_date,[NSDate dateWithTimeIntervalSinceNow:10]);
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        notification.fireDate=_date; //设置响应时间,单位 秒
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName = @"local.caf";          //加入声音
        notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"您回顾生词的时间到了！",@"It is time to learn the new world!")];  //弹出对话框
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
    [dateFormatter release];
    [notification release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_timeView release];
    [_onButton release];
    [super dealloc];
}
@end
