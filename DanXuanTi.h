//
//  DanXuanTi.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-7.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanXuanTi : NSObject

@property(assign,nonatomic)int tiId;
@property(assign,nonatomic)int tiYear;
@property(retain,nonatomic)NSString *tiTitle;
@property(retain,nonatomic)NSString *select1;
@property(retain,nonatomic)NSString *select2;
@property(retain,nonatomic)NSString *select3;
@property(retain,nonatomic)NSString *select4;
@property(retain,nonatomic)NSString *result;
@property(retain,nonatomic)NSString *hint1;
@property(retain,nonatomic)NSString *hint2;
@property(retain,nonatomic)NSString *hint3;
@property(retain,nonatomic)NSString *createdate;

@end
