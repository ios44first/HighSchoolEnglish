//
//  NewWordViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "NewWordViewController.h"

@interface NewWordViewController ()

@end

@implementation NewWordViewController
@synthesize array;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage* image= [UIImage imageNamed:@"return_pressed.png"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* back= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:back];
    [back release];
    [backButton release];
    
    UIImage* image1= [UIImage imageNamed:@"delete_pressed.png"];
    CGRect frame_2= CGRectMake(0, 0, image1.size.width, image1.size.height);
    UIButton* backButton1= [[UIButton alloc] initWithFrame:frame_2];
    [backButton1 setBackgroundImage:image1 forState:UIControlStateNormal];
    SEL s=self.editButtonItem.action;
    [backButton1 addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
    [backButton1 addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* back1= [[UIBarButtonItem alloc] initWithCustomView:backButton1];
    [self.navigationItem setRightBarButtonItem:back1];
    [back1 release];
    [backButton1 release];
    
    self.array=[NSMutableArray array];
    factory=[DataFactory instance];
    id delegate=[[UIApplication sharedApplication]delegate];
    factory.managedObjectContext=[delegate managedObjectContext];
    for (id temp in [factory getData:@"NewWord" andSort:@"title"])
    {
        [self.array addObject:temp];
    }
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changeImg:(UIButton *)sender
{
    if (isEditing)
    {
        isEditing=NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"delete_pressed.png"] forState:UIControlStateNormal];
    }
    else
    {
        isEditing=YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"done_pressed.png"] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image=[UIImage imageNamed:@"icon_word.png"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NewWord *word=[self.array objectAtIndex:indexPath.row];
    cell.textLabel.text=word.title;
    UIFont *font=[UIFont systemFontOfSize:14];
    NSMutableString *string = [NSMutableString stringWithString:word.result];
    [string replaceOccurrencesOfString:@"\n" withString:@" " options:0 range:NSMakeRange(0, string.length)];
    CGSize size=[string sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:(NSLineBreakByTruncatingTail)];
    UIScrollView *sc=[[UIScrollView alloc]initWithFrame:CGRectMake(50, 22, 240, 20)];
    sc.userInteractionEnabled=NO;
    [sc setContentSize:size];
    //[sc setBackgroundColor:[UIColor redColor]];
    [cell addSubview:sc];
    [sc release];
    
    UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 20)];
    //NSLog(@"%f,%f",size.width,size.height);
    if (size.width>250)
    {
        content.frame=CGRectMake(0, 0, size.width, 20);
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(rollLabel:) userInfo:sc repeats:YES];
    }
    content.textColor=[UIColor colorWithRed:0 green:0.7 blue:1 alpha:1.0];
    content.font=font;
    content.text=string;
    [sc addSubview:content];
    [content release];
    cell.detailTextLabel.text=@"  ";
}
-(void)rollLabel:(NSTimer *)theTimer
{
    UIScrollView *scr=[theTimer userInfo];
    if (scr.contentOffset.x<scr.contentSize.width-244)
    {
        [scr setContentOffset:CGPointMake(scr.contentOffset.x+4, 0) animated:YES];
    }
    else
        [scr setContentOffset:CGPointMake(-80, 0) animated:YES];
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        id tem=[self.array objectAtIndex:indexPath.row];
        [self.array removeObjectAtIndex:indexPath.row];
        [factory.managedObjectContext deleteObject:tem];
        [self.tableView reloadData];
        NSError *error;
        if (![factory.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewWord *word=[self.array objectAtIndex:indexPath.row];
    WordViewController *wordView=[[WordViewController alloc] init];
    wordView.newword=word;
    wordView.i=indexPath.row;
    wordView.array=self.array;
    [self.navigationController pushViewController:wordView animated:YES];
    [wordView release];
}

#pragma mark - NSFetchedResultsControllerDelegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
@end
