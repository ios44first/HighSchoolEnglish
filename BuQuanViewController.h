//
//  BuQuanViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-10.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

@interface BuQuanViewController : UIViewController
{
    UITextView *resultView;
    
    AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
    BOOL isPlay;
     BOOL isShow;
}

@property (retain,nonatomic) Questions *question;
@property (assign,nonatomic) int i;
@property(retain,nonatomic) NSArray *arr;
@property (retain, nonatomic) IBOutlet UITextView *listenTitle;
@property (retain, nonatomic) IBOutlet UISlider *sliderAV;
@property (retain, nonatomic) IBOutlet UIButton *butPlay;

- (IBAction)submitButton:(UIButton *)sender;
- (IBAction)nextTI:(UIButton *)sender;
- (IBAction)playStop:(UIButton *)sender;

@end
