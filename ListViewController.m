//
//  ListViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize array,str,dictionary,question;
@synthesize grade,year,titleType;

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
    NSLog(@"%d,%d,%d",year,grade,titleType);
    
    self.array=[NSMutableArray array];
    self.str=[NSMutableString string];
    self.dictionary=[NSMutableDictionary dictionary];
    NSString *string=nil;
    if (self.year==1999)
      string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d",self.grade,self.titleType];
    else
      string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d&year=%d",self.grade,self.titleType,self.year];
    NSURL *newsURL=[[NSURL alloc]initWithString:string];
    NSData *xmlData=[[NSData alloc] initWithContentsOfURL:newsURL];
    NSXMLParser *parserTool=[[NSXMLParser alloc]initWithData:xmlData];
    parserTool.delegate=self;
    [parserTool parse];
    [newsURL release];
    [xmlData release];
    [parserTool release];
    
    [self.tableView setSeparatorColor:[UIColor grayColor]];
}
#pragma mark - NSXMLParserDelegate 代理方法
-(void)parserDidStartDocument:(NSXMLParser *)parser
{//解析开始的时候调用该方法。
    //NSLog(@"开始解析。。。parserDidStartDocument");
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{//在XML document中,当解析器在解析的时候遇到了一个新的element时会被调用该方法。
    //NSLog(@"StartElement。。。");
    if ([elementName isEqualToString:@"item"])
    {
        [self.dictionary removeAllObjects];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [str setString:@""];
        //NSLog(@"-------%@",str);
    }
    else if ([elementName isEqualToString:@"year"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"createdate"])
    {
        [str setString:@""];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{//当解析器在解析文档内容的时候被调用。
    [str appendString:string];
    //NSLog(@"foundCharacters。。。%@",str);
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{//当前节点结束之后会调用。
   // NSLog(@"EndElement。。。");
    if ([elementName isEqualToString:@"item"])
    {
        [self.array addObject:[NSMutableDictionary dictionaryWithDictionary:self.dictionary]];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
        // NSLog(@"%@",str);
    }
    else if ([elementName isEqualToString:@"year"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"createdate"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{//解析结束的时候调用该方法。
    //NSLog(@"结束解析。。。parserDidEndDocument");
    NSMutableArray *arr=[NSMutableArray array];
    for (id element in self.array)
    {
        Questions *temp=[[Questions alloc]init];
        temp.questionsId=[[element objectForKey:@"id"] intValue];
        temp.year=[[element objectForKey:@"year"] intValue];
        temp.queTitle=[element objectForKey:@"title"];
        temp.createDate=[element objectForKey:@"createdate"];
        [arr addObject:temp];
        [temp release];
    }
    [self.array removeAllObjects];
    self.array=[NSMutableArray arrayWithArray:arr];
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
    if (nil==cell)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    Questions *que=[self.array objectAtIndex:indexPath.row];
    cell.textLabel.text=que.queTitle;
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Thonburi" size:13]];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%d年%@                     %@",que.year,self.title,[que.createDate substringToIndex:10]];
    cell.imageView.image=[UIImage imageNamed:@"bg_point.png"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Questions *q=[self.array objectAtIndex:indexPath.row];
    NSLog(@"%d",q.questionsId);
    switch (self.titleType)
    {
        case 1:
        case 13:
        {
          doWorkViewController *detailViewController = [[doWorkViewController alloc] init];
          detailViewController.arr=self.array;
          detailViewController.strTitle=self.title;
          detailViewController.question=q;
          detailViewController.i=indexPath.row;
          [self.navigationController pushViewController:detailViewController animated:YES];
          [detailViewController release];
        }
            break;
        case 14:
        {
            WanXingViewController *wanxing=[[WanXingViewController alloc]init];
            wanxing.arr=self.array;
            wanxing.strTitle=self.title;
            wanxing.question=q;
            wanxing.i=indexPath.row;
            [self.navigationController pushViewController:wanxing animated:YES];
            [wanxing release];
        }
            break;
        case 15:
            break;
        case 16:
            break;
        case 17:
            break;
        case 18:
            break;
        case 19:
            break;
        case 20:
            break;
        case 21:
            break;
        case 24:
            break;
        case 28:
            break;
            
        default:
            break;
}

}

@end
