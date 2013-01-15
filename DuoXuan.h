//
//  DuoXuan.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-15.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DuoXuan : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * tiId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * titleType;

@end
