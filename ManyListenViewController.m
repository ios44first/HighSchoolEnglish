//
//  ManyListenViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-10.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ManyListenViewController.h"

@interface ManyListenViewController ()

@end

@implementation ManyListenViewController
@synthesize array,arrayData,str,dictionary,titleType,arrayChild,dictionaryChild;

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
//初始化显示下拉刷新的视图
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
//初始化 解析用到的 属性
    self.array=[NSMutableArray array];
    self.arrayChild=[NSMutableArray array];
    self.arrayData=[NSMutableArray array];
    self.str=[NSMutableString string];
    self.dictionary=[NSMutableDictionary dictionary];
    self.dictionaryChild=[NSMutableDictionary dictionary];
    currentpagenum=0;
    [self getData];
    
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
}
-(void)getData
{//开始解析  获得数据
    isChild=NO;
    NSString *string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=getlisteningthemes&currentpagenum=%d&pagesize=20&listentype=%d",++currentpagenum,self.titleType];
    NSURL *newsURL=[[NSURL alloc]initWithString:string];
    NSData *xmlData=[[NSData alloc] initWithContentsOfURL:newsURL];
    NSXMLParser *parserTool=[[NSXMLParser alloc]initWithData:xmlData];
    parserTool.delegate=self;
    [parserTool parse];
    [newsURL release];
    [xmlData release];
    [parserTool release];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear: (BOOL)animated
{//显示本视图前调用的方法
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questionID" ofType:@"plist"];
    madeArray=[[NSMutableArray alloc]initWithContentsOfFile:path];
    //NSLog(@"%@",madeArray);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSXMLParserDelegate 代理方法
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{//解析时遇到 节点的开始
    if ([elementName isEqualToString:@"childThemeList"])
    {
        isChild=YES;
        [self.arrayChild removeAllObjects];
    }
    else if ([elementName isEqualToString:@"item"])
    {
        if (isChild)
            [self.dictionaryChild removeAllObjects];
        else
            [self.dictionary removeAllObjects];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"optiona"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"optionb"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"optionc"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"answer"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"midfile"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"original"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"createdate"])
    {
        [str setString:@""];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{//获得节点的内容
    [str appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{//解析到节点结束的时候
    if ([elementName isEqualToString:@"item"])
    {
        if (isChild)
            [self.arrayChild addObject:[NSMutableDictionary dictionaryWithDictionary:self.dictionaryChild]];
        else
            [self.array addObject:[NSMutableDictionary dictionaryWithDictionary:self.dictionary]];
    }
    else if ([elementName isEqualToString:@"childThemeList"])
    {
        isChild=NO;
        [self.dictionary setObject:[NSArray arrayWithArray:self.arrayChild] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        if (!isChild)
            [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        if (isChild)
            [self.dictionaryChild setObject:[NSString stringWithString:str] forKey:elementName];
        else
            [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"optiona"])
    {
        [self.dictionaryChild setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"optionb"])
    {
        [self.dictionaryChild setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"optionc"])
    {
        [self.dictionaryChild setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"answer"])
    {
        [self.dictionaryChild setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"midfile"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"original"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"createdate"])
    {
        if (!isChild)
            [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{//解析完成的时候调用，整理解析后得到的数据
    NSMutableArray *arr=[NSMutableArray array];
    for (id element in self.array)
    {
        ListenMany *many=[[ListenMany alloc]init];
        many.listenId=[[element objectForKey:@"id"] intValue];
        many.listenTitle=[element objectForKey:@"title"];
        many.midFile=[element objectForKey:@"midfile"];
        many.original=[element objectForKey:@"original"];
        many.createTime=[element objectForKey:@"createdate"];
        NSMutableArray *ma=[NSMutableArray array];
        for (id temp in [element objectForKey:@"childThemeList"])
        {
            ListenChild *child=[[ListenChild alloc]init];
            child.childTitle=[temp objectForKey:@"title"];
            child.optiona=[temp objectForKey:@"optiona"];
            child.optionb=[temp objectForKey:@"optionb"];
            child.optionc=[temp objectForKey:@"optionc"];
            child.answer=[temp objectForKey:@"answer"];
            [ma addObject:child];
            [child release];
        }
        many.childArray=[NSArray arrayWithArray:ma];
       //ListenChild *l=[many.childArray objectAtIndex:0];
       // NSLog(@"%@",l.childTitle);
        [arr addObject:many];
        [many release];
    }
    [self.array removeAllObjects];
    self.array=[NSMutableArray arrayWithArray:arr];
    for (ListenMany *tem in self.array)
    {
        //NSLog(@"%@\n%@\n%@\n%@\n%@",tem.listenTitle,tem.midFile,tem.original,tem.createTime,tem.childArray);
        [self.arrayData addObject:tem];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayData count]+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil==cell)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row<[self.arrayData count])
    {//初始化cell的内容
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        ListenMany *many=[self.arrayData objectAtIndex:indexPath.row];
        if (many.listenTitle==nil)
            cell.textLabel.text=@"暂无标题";
        else
            cell.textLabel.text=[NSString filterString:many.listenTitle];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Thonburi" size:13]];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@                %@",self.title,[many.createTime substringToIndex:10]];
        
        if ([madeArray containsObject:[NSString stringWithFormat:@"%d",many.listenId]])
            cell.imageView.image=[UIImage imageNamed:@"bg_point_yi.png"];
        else
            cell.imageView.image=[UIImage imageNamed:@"bg_point_wei.png"];
    }
    else
    {//设置上拉加载更多的cell的内容
        if (self.tableView.contentSize.height<420)
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.imageView.image=nil;
            cell.detailTextLabel.text=@"";
        }
        else
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.imageView.image=nil;
            cell.detailTextLabel.text=@"";
            cell.textLabel.text=@"                   Loding ...";
            cell.textLabel.textAlignment=NSTextAlignmentRight;
            cell.backgroundColor=[UIColor grayColor];
            UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
            activityIndicator.color=[UIColor colorWithRed:0.22 green:0.66 blue:1 alpha:1.0];
            activityIndicator.frame=CGRectMake(20, 5, 30, 30);
            [activityIndicator startAnimating];
            [cell addSubview:activityIndicator];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<[self.arrayData count])
    {
        ManyViewController *detailViewController = [[ManyViewController alloc] init];
        ListenMany *lis=[self.arrayData objectAtIndex:indexPath.row];
        NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
        detailViewController.madeArray=ma;
        [ma release];
        detailViewController.listen=lis;
        detailViewController.i=indexPath.row;
        detailViewController.arr=self.arrayData;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height) )//上拉加载更多
    {
        [self.array removeAllObjects];
        [self.arrayChild removeAllObjects];
        [self getData];
        [self.tableView reloadData];
    }
    else if (self.tableView.contentOffset.y < -20)//下拉刷新
    {
        [self.array removeAllObjects];
        [self.arrayChild removeAllObjects];
        [self.arrayData removeAllObjects];
        [self getData];
        //sleep(2.0);
        [self.tableView reloadData];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}
- (void)dealloc {
    _refreshHeaderView = nil;
    [super dealloc];
}
@end
