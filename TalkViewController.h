//
//  TalkViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-9.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

@interface TalkViewController : UIViewController<NSXMLParserDelegate>
{
    UITextView *resultView;
    NSString *answer;
    
    AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
    BOOL isPlay;
}

@property (retain,nonatomic) Questions *question;
@property (assign,nonatomic) int i;
@property(retain,nonatomic) NSArray *arr;
@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableDictionary *dictionary;

@property (retain, nonatomic) IBOutlet UILabel *listenTitle;
@property (retain, nonatomic) IBOutlet UILabel *selectA;
@property (retain, nonatomic) IBOutlet UILabel *selectB;
@property (retain, nonatomic) IBOutlet UILabel *selectC;
@property (retain, nonatomic) IBOutlet UIButton *butA;
@property (retain, nonatomic) IBOutlet UIButton *butB;
@property (retain, nonatomic) IBOutlet UIButton *butC;
@property (retain, nonatomic) IBOutlet UISlider *sliderAV;
@property (retain, nonatomic) IBOutlet UIButton *butPlay;

- (IBAction)butSelect:(UIButton *)sender;
- (IBAction)playStop:(UIButton *)sender;
- (IBAction)submitAnswer:(UIButton *)sender;
- (IBAction)nextTI:(UIButton *)sender;

@end
