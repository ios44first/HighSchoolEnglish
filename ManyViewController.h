//
//  ManyViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-10.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListenChild.h"
#import "ListenMany.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

@interface ManyViewController : UIViewController
{
    UITextView *resultView;
    UIScrollView *listenView;
    char answer[5];
    
    AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
    BOOL isPlay;
    BOOL isShow;
}

@property (retain,nonatomic) ListenMany *listen;
@property (assign,nonatomic) int i;
@property(retain,nonatomic) NSArray *arr;

@property (retain, nonatomic) IBOutlet UISlider *sliderAV;
@property (retain, nonatomic) IBOutlet UIButton *butPlay;

- (IBAction)playStop:(UIButton *)sender;
- (IBAction)submitAnswer:(UIButton *)sender;
- (IBAction)nextTI:(UIButton *)sender;
@end
