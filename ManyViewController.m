//
//  ManyViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-10.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ManyViewController.h"

@interface ManyViewController ()

@end

@implementation ManyViewController
@synthesize listen,i,arr,madeArray;

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
    self.title=@"短文听力";
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
//进度条
    [self.sliderAV addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventTouchUpInside];
//显示答案和听力原文的textView
    resultView=[[UITextView alloc]initWithFrame:CGRectMake(320, 10, 320, 320)];
    [resultView setBackgroundColor:[UIColor clearColor]];
    resultView.editable=NO;
    [self.view addSubview:resultView];
    [resultView release];
    
    listenView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 340)];
    [listenView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:listenView];
    
    [self setData];
}
-(void)setData
{//根据解析后的数据，初始化题干和按钮
    for (int j=0; j<5; j++)
    {
        answer[j]='0';
    }
    for(UIView *view in [listenView subviews])
    {
        [view removeFromSuperview];
    }
    if (self.listen.listenTitle!=nil)
        self.listen.listenTitle=[NSString filterString:self.listen.listenTitle];
    else
        self.listen.listenTitle=@"暂无标题。。。";
    int selectLength=[self.listen.childArray count]*150;
    [listenView setContentSize:CGSizeMake(320, selectLength+80)];
    UILabel *listenTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 40)];
    listenTitle.numberOfLines=0;
    [listenTitle setBackgroundColor:[UIColor clearColor]];
    listenTitle.text=[NSString stringWithFormat:@"%@",self.listen.listenTitle];
    [listenView addSubview:listenTitle];
    [listenTitle release];
    for (int n=0; n<[self.listen.childArray count]; n++)
    {
        ListenChild *child=[self.listen.childArray objectAtIndex:n];
        UILabel *question=[[UILabel alloc]initWithFrame:CGRectMake(10, 60+150*n, 300, 40)];
        question.numberOfLines=0;
        question.font=[UIFont systemFontOfSize:14];
        question.backgroundColor=[UIColor clearColor];
        if (child.childTitle==nil)
            child.childTitle=@"暂无标题。。。";
        question.text=[NSString stringWithFormat:@"%d. %@",n+1,child.childTitle];
        [listenView addSubview:question];
        [question release];
        
        UIButton *selectA=[UIButton buttonWithType:UIButtonTypeCustom];
        [selectA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        [selectA addTarget:self action:@selector(chooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
        selectA.frame=CGRectMake(20, 110+150*n, 20, 20);
        selectA.tag=10*n+1;
        [listenView addSubview:selectA];
        UIButton *selectB=[UIButton buttonWithType:UIButtonTypeCustom];
        [selectB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        [selectB addTarget:self action:@selector(chooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
        selectB.frame=CGRectMake(20, 145+150*n, 20, 20);
        selectB.tag=10*n+2;
        [listenView addSubview:selectB];
        UIButton *selectC=[UIButton buttonWithType:UIButtonTypeCustom];
        [selectC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        [selectC addTarget:self action:@selector(chooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
        selectC.frame=CGRectMake(20, 180+150*n, 20, 20);
        selectC.tag=10*n+3;
        [listenView addSubview:selectC];
        UITextView *la=[[UITextView alloc]initWithFrame:CGRectMake(40, 150*n+110, 270, 40)];
        la.editable=NO;
        [la setBackgroundColor:[UIColor clearColor]];
        la.text=[NSString stringWithFormat:@" A. %@",child.optiona];
        [listenView addSubview:la];
        [la release];
        UITextView *lb=[[UITextView alloc]initWithFrame:CGRectMake(40, 150*n+145, 260, 40)];
        lb.editable=NO;
        [lb setBackgroundColor:[UIColor clearColor]];
        lb.text=[NSString stringWithFormat:@" B. %@",child.optionb];
        [listenView addSubview:lb];
        [lb release];
        UITextView *lc=[[UITextView alloc]initWithFrame:CGRectMake(40, 150*n+180, 260, 40)];
        lc.editable=NO;
        [lc setBackgroundColor:[UIColor clearColor]];
        lc.text=[NSString stringWithFormat:@" C. %@",child.optionc];
        [listenView addSubview:lc];
        [lc release];
    }
    
    self.sliderAV.value=0;
    isPlay=NO;
}
-(void)chooseAnswer:(UIButton *)sender
{//选择答案
    int x=sender.tag/10;
    int y=sender.tag%10;
    UIButton *b1=(UIButton *)[listenView viewWithTag:x*10+1];
    UIButton *b2=(UIButton *)[listenView viewWithTag:x*10+2];
    UIButton *b3=(UIButton *)[listenView viewWithTag:x*10+3];
    switch (y)
    {
        case 1:
            answer[x]='A';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 2:
            answer[x]='B';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 3:
            answer[x]='C';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            break;
    }
}
-(void)changeValue
{//改变听力进度
    if (streamer.duration)
	{
		double newSeekTime = (self.sliderAV.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}
#pragma mark -
#pragma mark BUtton Action
- (IBAction)playStop:(UIButton *)sender
{// 开始  暂停
    if (isPlay)
    {
        isPlay=NO;
        [self.butPlay setImage:[UIImage imageNamed:@"btn_play_pressed.png"] forState:UIControlStateNormal];
        [streamer pause];
    }
    else
    {
        isPlay=YES;
        [self.butPlay setImage:[UIImage imageNamed:@"btn_pause_pressed.png"] forState:UIControlStateNormal];
        if (streamer)
            [streamer start];
        else
        {
            [self createStreamer];
            [streamer start];
        }
    }
}
-(void)moveLR:(NSArray *)viewArray
{//左右移动
    if (isShow)
    {
        isShow=NO;
        for (UIView *view in viewArray)
        {
            view.frame=CGRectMake(view.frame.origin.x+320, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
    }
    else
    {
        isShow=YES;
        for (UIView *view in viewArray)
        {
            view.frame=CGRectMake(view.frame.origin.x-320, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
    }
}
- (IBAction)submitAnswer:(UIButton *)sender
{//提交答案
    NSString *contain=@"";
    for (ListenChild *child in self.listen.childArray)
    {
        int index=[self.listen.childArray indexOfObject:child];
        if ([[NSString stringWithFormat:@"%c",answer[index]] isEqualToString:child.answer])
            contain=[contain stringByAppendingFormat:@"\n%d. √ 回答正确，答案为%@",index+1,child.answer];
        else
            contain=[contain stringByAppendingFormat:@"\n%d. × 回答错误，您选了%c，答案为%@",index+1,answer[index],child.answer];
       // NSLog(@"--------%@",contain);
    }
    contain=[contain stringByAppendingFormat:@"\n\n%@",self.listen.original];
    resultView.text=[NSString filterString:contain];
   // NSLog(@"%@",resultView.text);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    NSArray *viewArray=[NSArray arrayWithObjects:listenView,resultView, nil];
    [self moveLR:viewArray];
    [UIView commitAnimations];
    
    if (isShow)
        [self.submitButton setBackgroundImage:[UIImage imageNamed:@"btn_listen_back_pressed.png"] forState:UIControlStateNormal];
    else
        [self.submitButton setBackgroundImage:[UIImage imageNamed:@"btn_listen_submit_pressed.png"] forState:UIControlStateNormal];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questionID" ofType:@"plist"];
    NSString *queNum=[NSString stringWithFormat:@"%d",self.listen.listenId];
    //NSLog(@"%@",queNum);
    if (![madeArray containsObject:queNum])
    {
        [madeArray addObject:queNum];
        [madeArray writeToFile:path atomically:YES];
    }
}

- (IBAction)nextTI:(UIButton *)sender
{//下一题
    [streamer stop];
    [self destroyStreamer];
    isPlay=NO;
    for (int j=0; j<5; j++)
    {
        answer[j]='0';
    }
    [self.butPlay setImage:[UIImage imageNamed:@"btn_play_pressed.png"] forState:UIControlStateNormal];
    if (isShow)
    {
        [self submitAnswer:nil];
    }
    if (i<[self.arr count]-1)
    {
        self.listen=[self.arr objectAtIndex:++i];
    }
    [self setData];
}
-(void)goBack
{
    [streamer stop];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 音频流
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}
- (void)createStreamer
{
	if (streamer)
	{
		return;
	}
	[self destroyStreamer];
    if (self.listen.midFile==nil)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Sorry，暂无音频。。。" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
    }
    else
    {
	    NSURL *url = [NSURL URLWithString:self.listen.midFile];
	    streamer = [[AudioStreamer alloc] initWithURL:url];
	    progressUpdateTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    }
}
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		if (duration > 0)
		{
			[self.sliderAV setEnabled:YES];
			[self.sliderAV setValue:100 * progress / duration];
		}
		else
		{
			[self.sliderAV setEnabled:NO];
		}
	}
    if ([streamer isIdle])
    {
        isPlay=NO;
        self.sliderAV.value=0;
        [self.butPlay setImage:[UIImage imageNamed:@"btn_play_pressed.png"] forState:UIControlStateNormal];
    }
}
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

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_submitButton release];
    [super dealloc];
}
@end
