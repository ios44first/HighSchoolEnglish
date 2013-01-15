//
//  ReadArtical.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-15.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReadArtical : NSManagedObject

@property (nonatomic, retain) NSString * contain;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * tishi;
@property (nonatomic, retain) NSString * titleType;

@end
