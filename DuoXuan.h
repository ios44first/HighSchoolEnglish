//
//  DuoXuan.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DuoXuan : NSManagedObject

@property (nonatomic, retain) NSNumber * titleType;
@property (nonatomic, retain) NSNumber * tiId;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * title;

@end
