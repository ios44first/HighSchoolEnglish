//
//  TalkViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-9.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "TalkViewController.h"

@interface TalkViewController ()

@end

@implementation TalkViewController
@synthesize question,i,arr,dictionary,str;

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
    self.navigationItem.title=@"英语听力";
    
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
    
    [self.sliderAV addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventTouchUpInside];
    
    resultView=[[UITextView alloc]initWithFrame:CGRectMake(320, 0, 320, 400)];
    [resultView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:resultView];
    [resultView release];
    
    [self setData];
}
-(void)setData
{
    if (self.question.queTitle!=nil)
        self.listenTitle.text=[self filterString:self.question.queTitle];
    else
        self.listenTitle.text=@"暂无标题。。。";
    self.selectA.text=[NSString stringWithFormat:@"A.  %@",[self filterString:self.question.optionA]];
    self.selectB.text=[NSString stringWithFormat:@"B.  %@",[self filterString:self.question.optionB]];
    self.selectC.text=[NSString stringWithFormat:@"C.  %@",[self filterString:self.question.optionC]];
    self.sliderAV.value=0;
    isPlay=NO;
}
-(void)changeValue
{
    if (streamer.duration)
	{
		double newSeekTime = (self.sliderAV.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
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
	
	NSURL *url = [NSURL URLWithString:self.question.midFile];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	progressUpdateTimer =
    [NSTimer
     scheduledTimerWithTimeInterval:0.1
     target:self
     selector:@selector(updateProgress:)
     userInfo:nil
     repeats:YES];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_listenTitle release];
    [_selectA release];
    [_selectB release];
    [_selectC release];
    [_butA release];
    [_butB release];
    [_butC release];
    [_sliderAV release];
    [_butPlay release];
    [super dealloc];
}
#pragma mark -
#pragma mark Button method
- (IBAction)butSelect:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            answer=@"A";
            [self.butA setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [self.butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [self.butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 2:
            answer=@"B";
            [self.butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [self.butB setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [self.butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;

        case 3:
            answer=@"C";
            [self.butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [self.butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [self.butC setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            break;
    }
}

- (IBAction)playStop:(UIButton *)sender
{
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

- (IBAction)submitAnswer:(UIButton *)sender
{
    resultView.text=self.question.answer;
    
    UIAlertView *alert;
    if ([answer isEqualToString:self.question.answer])
        alert=[[UIAlertView alloc]initWithTitle:@"答题结果" message:@"恭喜你答对了！" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    else
    {
        NSString *an=[NSString stringWithFormat:@"很遗憾您答错了，正确答案是%@",self.question.answer];
        alert=[[UIAlertView alloc]initWithTitle:@"答题结果" message:an delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    }
    [alert show];
    [alert release];
}

- (IBAction)nextTI:(UIButton *)sender
{
    [streamer stop];
    [self destroyStreamer];
    isPlay=NO;
    [self.butPlay setImage:[UIImage imageNamed:@"btn_play_pressed.png"] forState:UIControlStateNormal];
    if (i<[self.arr count]-1)
    {
        self.question=[self.arr objectAtIndex:++i];
    }
    [self setData];
    [self.butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
    [self.butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
    [self.butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
}
-(void)goBack
{
    [streamer stop];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 过滤字符串
- (NSString *)filterString:(NSString *)string
{
    if (string!=nil)
    {
        NSMutableString *str1=[NSMutableString stringWithString:string];
        [str1 replaceOccurrencesOfString:@"&lt;U&gt;" withString:@"`" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;/U&gt;" withString:@"`" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&amp;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"nbsp;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;P&gt;" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;/P&gt;" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&#xd;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;P style=&quot;TEXT-ALIGN: center&quot; align=center&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&apos;" withString:@"'" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=\"text-align:left\" align=\"left\"&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=\"text-align:right\" align=\"right\"&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"<P style=\"TEXT-INDENT: 2em\">" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"</P>;" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"<STRONG>" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"<U>" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"</U>" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"</STRONG>" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"</P>" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        
        return str1;
    }
    else
        return @"";
}
@end
