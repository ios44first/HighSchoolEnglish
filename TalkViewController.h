//
//  TalkViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-9.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>
#import "AudioStreamer.h"

#import "Questions.h"
#import "NSString+Filter.h"


@interface TalkViewController : UIViewController
{
    UITextView *resultView;
    NSString *answer;
    
    AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
    BOOL isPlay;
    BOOL isShow;
}

@property (retain,nonatomic) Questions *question;
@property (assign,nonatomic) int i;
@property(retain,nonatomic) NSArray *arr;

@property (retain, nonatomic) UILabel *listenTitle;
@property (retain, nonatomic) UILabel *selectA;
@property (retain, nonatomic) UILabel *selectB;
@property (retain, nonatomic) UILabel *selectC;
@property (retain, nonatomic) UIButton *butA;
@property (retain, nonatomic) UIButton *butB;
@property (retain, nonatomic) UIButton *butC;
@property (retain, nonatomic) IBOutlet UISlider *sliderAV;
@property (retain, nonatomic) IBOutlet UIButton *butPlay;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)playStop:(UIButton *)sender;
- (IBAction)submitAnswer:(UIButton *)sender;
- (IBAction)nextTI:(UIButton *)sender;

@end
