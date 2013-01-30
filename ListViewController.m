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
@synthesize array,str,dictionary,question,arrayData,areaDic;
@synthesize grade,year,titleType,TIKU;

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
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
    //NSLog(@"%d,%d,%d",year,grade,titleType);
    
    self.array=[NSMutableArray array];
    self.arrayData=[NSMutableArray array];
    self.str=[NSMutableString string];
    self.dictionary=[NSMutableDictionary dictionary];
    currentpagenum=0;

    self.areaDic=[NSDictionary dictionaryWithObjectsAndKeys:@"天津",@"120000",@"河北",@"130000",@"山西",@"140000",@"内蒙",@"150000",@"辽宁",@"210000",@"吉林",@"220000",@"黑龙江",@"230000",@"上海",@"310000",@"江苏",@"320000",@"浙江",@"330000",@"安徽",@"340000",@"福建",@"350000",@"江西",@"360000",@"山东",@"370000",@"河南",@"410000",@"湖北",@"420000",@"湖南",@"430000",@"广东",@"440000",@"广西",@"450000",@"海南",@"460000",@"重庆",@"500000",@"四川",@"510000",@"贵州",@"520000",@"云南",@"530000",@"西藏",@"540000",@"陕西",@"610000",@"甘肃",@"620000",@"青海",@"630000",@"宁夏",@"640000",@"新疆",@"650000",@"北京",@"110000", nil];
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
    
    //[self.tableView setSeparatorColor:[UIColor grayColor]];
}
- (void)viewWillAppear: (BOOL)animated
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questionID" ofType:@"plist"];
    madeArray=[[NSMutableArray alloc]initWithContentsOfFile:path];
    //NSLog(@"%@",madeArray);
    [self.tableView reloadData];
}
-(void)getData
{
    //NSLog(@"%d",currentpagenum);
    NSString *string=nil;
    if (TIKU)
    {
        if (self.year==1999)
            string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d&currentpagenum=%d",self.grade,self.titleType,++currentpagenum];
        else
            string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=themelibrary&subjectid=3&pagesize=20&areaid=0&gread=%d&titletype=%d&year=%d&currentpagenum=%d",self.grade,self.titleType,self.year,++currentpagenum];
    }
    else
        string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=getlisteningthemes&currentpagenum=%d&pagesize=20&listentype=%d",++currentpagenum,self.titleType];
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
#pragma mark - NSXMLParserDelegate 代理方法
//-(void)parserDidStartDocument:(NSXMLParser *)parser
//{//解析开始的时候调用该方法。
//    //NSLog(@"开始解析。。。parserDidStartDocument");
//}
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
    else if ([elementName isEqualToString:@"areaid"])
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
    else if ([elementName isEqualToString:@"areaid"])
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
    else if ([elementName isEqualToString:@"optiona"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"optionb"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"optionc"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"answer"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"midfile"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"original"])
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
        if ([[element allKeys] containsObject:@"year"])
            temp.year=[[element objectForKey:@"year"] intValue];
        temp.queTitle=[element objectForKey:@"title"];
        temp.createDate=[element objectForKey:@"createdate"];
        if ([[element allKeys] containsObject:@"optiona"])
            temp.optionA=[element objectForKey:@"optiona"];
        if ([[element allKeys] containsObject:@"optionb"])
            temp.optionB=[element objectForKey:@"optionb"];
        if ([[element allKeys] containsObject:@"optionc"])
            temp.optionC=[element objectForKey:@"optionc"];
        if ([[element allKeys] containsObject:@"answer"])
            temp.answer=[element objectForKey:@"answer"];
        if ([[element allKeys] containsObject:@"midfile"])
            temp.midFile=[element objectForKey:@"midfile"];
        if ([[element allKeys] containsObject:@"original"])
            temp.original=[element objectForKey:@"original"];
        if ([[element allKeys] containsObject:@"areaid"])
            temp.areaId=[element objectForKey:@"areaid"];
        [arr addObject:temp];
        [temp release];
    }
    [self.array removeAllObjects];
    self.array=[NSMutableArray arrayWithArray:arr];
    for (Questions *tem in self.array)
    {
        [self.arrayData addObject:tem];
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
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        Questions *que=[self.arrayData objectAtIndex:indexPath.row];
        if (que.queTitle==nil)
            cell.textLabel.text=@"暂无标题";
        else
            cell.textLabel.text=[NSString filterString:que.queTitle];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Thonburi" size:13]];
        NSString *area=nil;
        if ([self.areaDic.allKeys containsObject:que.areaId])
            area=[areaDic objectForKey:que.areaId];
        else
            area=@"全国";
        if (self.titleType>100)
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@                %@",self.title,[que.createDate substringToIndex:10]];
        else
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%d年%@                %@",que.year,self.title,area];
        
        if ([madeArray containsObject:[NSString stringWithFormat:@"%d",que.questionsId]])
            cell.imageView.image=[UIImage imageNamed:@"bg_point_yi.png"];
        else
            cell.imageView.image=[UIImage imageNamed:@"bg_point_wei.png"];
    }
    else
    {
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
        Questions *q=[self.arrayData objectAtIndex:indexPath.row];
        NSLog(@"%d",q.questionsId);
        switch (self.titleType)
        {
            case 1:
            case 13:
            {
                doWorkViewController *detailViewController = [[doWorkViewController alloc] init];
                DanXuanTi *d=[[DanXuanTi alloc]init];
                detailViewController.danxuanti=d;
                [d release];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                detailViewController.madeArray=ma;
                [ma release];
                detailViewController.arr=self.arrayData;
                detailViewController.strTitle=self.title;
                detailViewController.question=q;
                detailViewController.i=indexPath.row;
                detailViewController.titleType=self.titleType;
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }
                break;
            case 14:
            {
                WanXingViewController *wanxing=[[WanXingViewController alloc]init];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                wanxing.madeArray=ma;
                [ma release];
                wanxing.arr=self.arrayData;
                wanxing.strTitle=self.title;
                wanxing.question=q;
                wanxing.i=indexPath.row;
                wanxing.titleType=self.titleType;
                [self.navigationController pushViewController:wanxing animated:YES];
                [wanxing release];
            }
                break;
            case 15:
            case 16:
            case 17:
            case 19:
            case 20:
            case 21:
            case 24:
            case 28:
            {
                ReadViewController *read=[[ReadViewController alloc]init];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                read.madeArray=ma;
                [ma release];
                read.arr=self.arrayData;
                read.strTitle=self.title;
                read.question=q;
                read.i=indexPath.row;
                read.titleType=self.titleType;
                [self.navigationController pushViewController:read animated:YES];
                [read release];
            }
                break;
            case 18:
            {
                ArticalViewController *artical=[[ArticalViewController alloc]init];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                artical.madeArray=ma;
                [ma release];
                artical.arr=self.arrayData;
                artical.strTitle=self.title;
                artical.question=q;
                artical.i=indexPath.row;
                artical.titleType=self.titleType;
                [self.navigationController pushViewController:artical animated:YES];
                [artical release];
            }
                break;
            case 610:
            case 641:
            case 669:
            case 670:
            case 671:
            case 672:
            {
                TalkViewController *talk =[[TalkViewController alloc]init];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                talk.madeArray=ma;
                [ma release];
                talk.arr=self.arrayData;
                talk.question=q;
                talk.i=indexPath.row;
                [self.navigationController pushViewController:talk animated:YES];
                [talk release];
            }
                break;
            case 675:
            {
                BuQuanViewController *buquan=[[BuQuanViewController alloc]init];
                NSMutableArray *ma=[[NSMutableArray alloc]initWithArray:madeArray];
                buquan.madeArray=ma;
                [ma release];
                buquan.title=@"补全填空";
                buquan.arr=self.arrayData;
                buquan.question=q;
                buquan.i=indexPath.row;
                [self.navigationController pushViewController:buquan animated:YES];
                [buquan release];
            }
                break;
            default:
                break;
        }
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
    if (self.tableView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height) )
    {
       [self.array removeAllObjects];
       [self getData];
       [self.tableView reloadData];
    }
    else if(self.tableView.contentOffset.y < -20)
    {
        [self.array removeAllObjects];
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
