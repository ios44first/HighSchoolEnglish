//
//  ListViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "doWorkViewController.h"
#import "WanXingViewController.h"
#import "ReadViewController.h"

@interface ListViewController : UITableViewController<NSXMLParserDelegate>
@property(assign,nonatomic)int grade,year,titleType;
@property(retain,nonatomic) NSString *url;
@property(retain,nonatomic) NSMutableArray *array;
@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableDictionary *dictionary;
@property(retain,nonatomic) Questions *question;
@end
