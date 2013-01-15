//
//  DanXuan.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DanXuan : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * selectA;
@property (nonatomic, retain) NSString * selectB;
@property (nonatomic, retain) NSString * selectC;
@property (nonatomic, retain) NSString * selectD;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSNumber * titleType;
@property (nonatomic, retain) NSString * tishi;
@property (nonatomic, retain) NSDate * createDate;

@end
