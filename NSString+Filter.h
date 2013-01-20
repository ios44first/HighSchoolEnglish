//
//  NSString+Filter.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Filter)
+ (NSString *)filterString:(NSString *)string;
-(NSString *) genHtmlStr:(NSString *)newStr;
-(NSString *)flattenHTML:(NSString *)htmlstr;
@end
