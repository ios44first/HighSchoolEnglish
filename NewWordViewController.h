//
//  NewWordViewController.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFactory.h"
#import "NewWord.h"
#import "WordViewController.h"

@interface NewWordViewController : UITableViewController<NSFetchedResultsControllerDelegate>
{
    DataFactory *factory;
    BOOL isEditing;
}

@property(retain,nonatomic) NSMutableArray *array;

@end
