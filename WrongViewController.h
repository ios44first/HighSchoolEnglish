//
//  WrongViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFactory.h"
#import "ReadArtical.h"
#import "DuoXuan.h"
#import "DanXuan.h"

#import "doWorkViewController.h"
#import "WanXingViewController.h"
#import "ReadViewController.h"
#import "Questions.h"

@interface WrongViewController : UITableViewController<NSFetchedResultsControllerDelegate>
{
    NSMutableArray *num;
    DataFactory *factory;
    BOOL isEditing;
}
@property(retain,nonatomic) NSMutableArray *array;

@end
