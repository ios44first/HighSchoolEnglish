//
//  ManyListenViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-10.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface ManyListenViewController : UITableViewController<NSXMLParserDelegate,EGORefreshTableHeaderDelegate ,UIScrollViewDelegate>
{
    int currentpagenum;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
@property(assign,nonatomic)int titleType;
@property(retain,nonatomic) NSMutableArray *arrayData;
@property(retain,nonatomic) NSMutableArray *array;
@property(retain,nonatomic) NSMutableString *str;
@property(retain,nonatomic) NSMutableDictionary *dictionary;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
