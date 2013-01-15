//
//  NewWord.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-14.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewWord : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * titleType;

@end
