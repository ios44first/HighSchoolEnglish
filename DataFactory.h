//
//  DataFactory.h
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-14.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadArtical.h"
#import "DuoXuan.h"
#import "DanXuan.h"
#import "NewWord.h"

@interface DataFactory : NSObject<NSFetchedResultsControllerDelegate>

@property(retain,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(retain,nonatomic)NSFetchedResultsController *fetchedResultsController;
//获取数据
-(NSArray *)getData:(NSString *)entityName andSort:(NSString *)sort;
+(DataFactory *)instance;// 单例模式

@end
