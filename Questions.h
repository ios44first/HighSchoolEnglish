//
//  Questions.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questions : NSObject

@property(assign,nonatomic)int questionsId,year;
@property(retain,nonatomic)NSString *createDate,*queTitle;
@property (retain,nonatomic) NSString * optionA;
@property (retain,nonatomic) NSString * optionB;
@property (retain,nonatomic) NSString * optionC;
@property (retain,nonatomic) NSString * answer;
@property (retain,nonatomic) NSString * midFile;
@property (retain,nonatomic) NSString * original;

@end
