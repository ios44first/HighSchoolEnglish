//
//  ReadArtical.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReadArtical : NSManagedObject

@property (nonatomic, retain) NSString * contain;
@property (nonatomic, retain) NSNumber * titleType;
@property (nonatomic, retain) NSString * tishi;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSDate * createDate;

@end
