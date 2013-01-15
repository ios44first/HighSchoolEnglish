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
#import "EGORefreshTableHeaderView.h"
#import "TalkViewController.h"
#import "BuQuanViewController.h"
#import "NSString+Filter.h"
#import "DanXuanTi.h"

@interface ListViewController : UITableViewController<NSXMLParserDelegate,EGORefreshTableHeaderDelegate ,UIScrollViewDelegate>
{
    int currentpagenum;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@property(assign,nonatomic)BOOL TIKU;
@property(assign,nonatomic)int grade,year,titleType;
@property(retain,nonatomic) NSMutableArray *arrayData;
@property(retain,nonatomic) NSMutableArray *array;
@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableDictionary *dictionary;
@property(retain,nonatomic) Questions *question;
@property(retain,nonatomic) NSDictionary *areaDic;
@end
