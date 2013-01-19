//
//  ListenMany.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-11.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListenMany : NSObject

@property (assign,nonatomic) int listenId;
@property (retain,nonatomic) NSString *listenTitle;
@property (retain,nonatomic) NSString *midFile;
@property (retain,nonatomic) NSString *original;
@property (retain,nonatomic) NSString *createTime;
@property (retain,nonatomic) NSArray *childArray;

@end
