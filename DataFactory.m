//
//  DataFactory.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-14.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "DataFactory.h"

@implementation DataFactory

@synthesize managedObjectContext;
@synthesize fetchedResultsController= _fetchedResultsController;


-(NSArray *)getData:(NSString *)entityName andSort:(NSString *)sort
{
    //NSLog(@"------getData---------");
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        //[fetchRequest setFetchBatchSize:20];
    NSSortDescriptor *sortDescriptor=nil;
    if ([sort isEqualToString:@"createDate"])
        sortDescriptor=[[NSSortDescriptor alloc] initWithKey:sort ascending:NO];
    else
        sortDescriptor=[[NSSortDescriptor alloc] initWithKey:sort ascending:YES];
    NSArray *sortArray=[NSArray arrayWithObjects:sortDescriptor, nil];
        [sortDescriptor release];
        [fetchRequest setSortDescriptors:sortArray];
        
    NSFetchedResultsController *afetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:entityName];
    [fetchRequest release];
    afetchedResultsController.delegate=self;
    self.fetchedResultsController=afetchedResultsController;
    [afetchedResultsController release];
        
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error])
    {
       NSLog(@"获取信息失败,%@,%@",error,[error userInfo]);
            abort();
    }

    NSArray *dataArray=[NSArray array];
    id<NSFetchedResultsSectionInfo> sectionInfo=[[self.fetchedResultsController sections] objectAtIndex:0];
    dataArray=[sectionInfo objects];
    //NSLog(@"%@",[[[sectionInfo objects] objectAtIndex:0] class]);
    return dataArray;
}

+(DataFactory *)instance
{
    static DataFactory *dataFactory;
    if(!dataFactory)
    {
        dataFactory = [[DataFactory alloc] init];
    }
    return dataFactory;
}

@end
