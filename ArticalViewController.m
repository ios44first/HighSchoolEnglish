//
//  ArticalViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-15.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ArticalViewController.h"

@interface ArticalViewController ()

@end

@implementation ArticalViewController
@synthesize question,arr,strTitle,str,dictionary,i,titleType,array=_array,stringAnswer,stringTishi,madeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=[NSString stringWithFormat:@"%@",self.strTitle];
    self.str=[NSMutableString string];
    self.array=[NSMutableArray array];
    self.dictionary=[NSMutableDictionary dictionary];
    imgURL=nil;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 420, 320 , 150)];
	scrollView.userInteractionEnabled = YES;
	scrollView.scrollEnabled = YES;
	[scrollView setContentSize:CGSizeMake(320, 150)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_answersheet.png"]];
    imgView.frame=CGRectMake(0, 420, 320, 150);
	[self.view addSubview:imgView];
	[self.view addSubview:scrollView];
    tishiAnswer=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    tishiAnswer.text=@"asdasdasdasdasdasdasdasdasdasdasdasdasd";
    tishiAnswer.backgroundColor=[UIColor clearColor];
    tishiAnswer.editable=NO;
    [scrollView addSubview:tishiAnswer];
    UIControl *con=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    [con addTarget:self action:@selector(goDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con];
    [con release];
    
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

    [self setContain];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setContain
{
    NSString *string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=gettheme&subjectid=3&id=%d",self.question.questionsId];
    NSURL *newsURL=[[NSURL alloc]initWithString:string];
    NSData *xmlData=[[NSData alloc] initWithContentsOfURL:newsURL];
    NSXMLParser *parserTool=[[NSXMLParser alloc]initWithData:xmlData];
    parserTool.delegate=self;
    [parserTool parse];
    [newsURL release];
    [xmlData release];
    [parserTool release];
    
    NSString *contain1=[NSString stringWithFormat:@"\n参考答案："];
    if ([self.array count]>0)
    {
        WanXing *wx=[self.array objectAtIndex:0];
        contain1=[contain1 stringByAppendingFormat:@"\n%@ \n",wx.result];
    }
    self.stringAnswer=[NSString stringWithString:[NSString filterString:contain1]];
    NSString *contain2=[NSString stringWithString:[NSString stringWithFormat:@"\n提示信息："]];
    if ([self.array count]>0)
    {
        WanXing *wx=[self.array objectAtIndex:0];
        contain2=[contain2 stringByAppendingFormat:@"\n%@ \n %@ \n  %@ \n",wx.hint1,wx.hint2,wx.hint3];
    }
    self.stringTishi=[NSString stringWithString:[NSString filterString:contain2]];
    
    WanXing *wan=[self.array objectAtIndex:0];
    int start=[wan.tiTitle rangeOfString:@"http://"].location;
    int end = [wan.tiTitle rangeOfString:@".gif"].location;
    if (end==NSNotFound)
    {
        end = [wan.tiTitle rangeOfString:@".jpg"].location;
    }
    if (start!=NSNotFound)
    {
        imgURL = [wan.tiTitle substringWithRange:NSRangeFromString([NSString stringWithFormat:@"%d,%d",start,end-start+4])];
        int startImg=[wan.tiTitle rangeOfString:@"&lt;IMG"].location;
        NSMutableString *mutableStr=[NSMutableString stringWithString:wan.tiTitle];
        if (startImg!=NSNotFound&&startImg<end)
        {
            [mutableStr deleteCharactersInRange:NSRangeFromString([NSString stringWithFormat:@"%d,%d",startImg,end-startImg+4])];
            wan.tiTitle = mutableStr;
        }
    }
    UIFont *font=[UIFont systemFontOfSize:14];
    CGSize size=[[NSString filterString:wan.tiTitle] sizeWithFont:font constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:(NSLineBreakByTruncatingTail)];
    for (UIView *v in self.allContain.subviews)
    {
        [v removeFromSuperview];
    }
    self.allContain.contentSize=CGSizeMake(320, size.height+30);
    content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height+30)];
    content.backgroundColor=[UIColor clearColor];
    content.font=font;
    content.numberOfLines=0;
    content.text=[NSString filterString:wan.tiTitle];
    [self.allContain addSubview:content];
    [content release];
    if (imgURL!=nil)
    {
        NSURL *url=[[NSURL alloc]initWithString:imgURL];
        NSData *data=[[NSData alloc]initWithContentsOfURL:url];
        UIImage *img=[[UIImage alloc]initWithData:data];
        CGSize cgs=img.size;
        if (cgs.width>320)
        {
            cgs = CGSizeMake(cgs.width/2, cgs.height/2);
        }
        UIImageView *tu=[[UIImageView alloc]initWithFrame:CGRectMake(0, size.height+30, cgs.width, cgs.height)];
        tu.image=img;
        self.allContain.contentSize=CGSizeMake(320, size.height+30+cgs.height);
        [self.allContain addSubview:tu];
        [url release];
        [data release];
        [img release];
        [tu release];
    }
}
#pragma mark - NSXMLParserDelegate 代理方法
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"])
    {
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
    else if ([elementName isEqualToString:@"result"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"hint1"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"hint2"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"hint3"])
    {
        [str setString:@""];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [str appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [self.array addObject:[NSMutableDictionary dictionaryWithDictionary:self.dictionary]];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"result"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"hint1"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"hint2"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"hint3"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSMutableArray *arr1=[NSMutableArray array];
    for (id element in self.array)
    {
        WanXing *temp=[[WanXing alloc]init];
        if ([[element allKeys] containsObject:@"id"])
            temp.tiId=[[element objectForKey:@"id"] intValue];
        else
            temp.tiId=0;
        if ([[element allKeys] containsObject:@"title"])
            temp.tiTitle=[element objectForKey:@"title"];
        else
            temp.tiTitle=@"";
        if ([[element allKeys] containsObject:@"result"])
            temp.result=[element objectForKey:@"result"];
        else
            temp.result=@"";
        if ([[element allKeys] containsObject:@"hint1"])
            temp.hint1=[element objectForKey:@"hint1"];
        else
            temp.hint1=@"";
        if ([[element allKeys] containsObject:@"hint2"])
            temp.hint2=[element objectForKey:@"hint2"];
        else
            temp.hint2=@"";
        if ([[element allKeys] containsObject:@"hint3"])
            temp.hint3=[element objectForKey:@"hint3"];
        else
            temp.hint3=@"";
        [arr1 addObject:temp];
        [temp release];
    }
    [self.array removeAllObjects];
    self.array=[NSMutableArray arrayWithArray:arr1];
}

#pragma mark -
#pragma mark - 隐藏tabBar
- (void)viewWillAppear: (BOOL)animated
{
    [self hideTabBar:YES];
}
- (void)viewWillDisappear: (BOOL)animated
{
    [self hideTabBar:NO];
}
- (void) hideTabBar:(BOOL) hidden
{
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden)
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
            } else
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
            }
        }
    }
    UIView *superView=[self.tabBarController.view superview];
    for(UIView *view in superView.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
        {
            if (hidden)
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
                superView.frame=CGRectMake(0, 20, 320, 510);
            } else
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
                superView.frame=CGRectMake(0, 20, 320, 460);
            }
        }
    }
}
#pragma mark -
#pragma mark - button
- (IBAction)showTishi:(UIButton *)sender
{
    [self downBut];
    tishiAnswer.text=self.stringTishi;
}

- (IBAction)showAnswer:(UIButton *)sender
{
    [self downBut];
    tishiAnswer.text=self.stringAnswer;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questionID" ofType:@"plist"];
    NSString *queNum=[NSString stringWithFormat:@"%d",self.question.questionsId];
    if (![madeArray containsObject:queNum])
    {
        [madeArray addObject:queNum];
        [madeArray writeToFile:path atomically:YES];
    }
}

- (IBAction)nextTi:(UIButton *)sender
{
    [self.dictionary removeAllObjects];
    [self.array removeAllObjects];
    if (i<[self.arr count]-1)
    {
        self.question=[self.arr objectAtIndex:++i];
    }
    [self goDown];
    [self setContain];
}
- (void)goDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    if (isDown)
    {
        isDown=NO;
        self.allContain.frame=CGRectMake(0, 0, 320, self.allContain.frame.size.height+150);
        self.tiShi.frame=CGRectMake(self.tiShi.frame.origin.x, self.tiShi.frame.origin.y+150, self.tiShi.frame.size.width, self.tiShi.frame.size.height);
        self.anSwer.frame=CGRectMake(self.anSwer.frame.origin.x, self.anSwer.frame.origin.y+150, self.anSwer.frame.size.width, self.anSwer.frame.size.height);
        self.nextButton.frame=CGRectMake(0, self.nextButton.frame.origin.y+150, self.nextButton.frame.size.width, self.nextButton.frame.size.height);
        scrollView.frame=CGRectMake(0, scrollView.frame.origin.y+150, scrollView.frame.size.width, scrollView.frame.size.height);
        imgView.frame=CGRectMake(0, imgView.frame.origin.y+150, imgView.frame.size.width, imgView.frame.size.height);
    }
    [UIView commitAnimations];
}
- (void)downBut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    if (!isDown)
    {
        isDown=YES;
        self.allContain.frame=CGRectMake(0, 0, 320, self.allContain.frame.size.height-150);
        self.tiShi.frame=CGRectMake(self.tiShi.frame.origin.x, self.tiShi.frame.origin.y-150, self.tiShi.frame.size.width, self.tiShi.frame.size.height);
        self.anSwer.frame=CGRectMake(self.anSwer.frame.origin.x, self.anSwer.frame.origin.y-150, self.anSwer.frame.size.width, self.anSwer.frame.size.height);
        self.nextButton.frame=CGRectMake(0, self.nextButton.frame.origin.y-150, self.nextButton.frame.size.width, self.nextButton.frame.size.height);
        scrollView.frame=CGRectMake(0, scrollView.frame.origin.y-150, scrollView.frame.size.width, scrollView.frame.size.height);
        imgView.frame=CGRectMake(0, imgView.frame.origin.y-150, imgView.frame.size.width, imgView.frame.size.height);
    }
    [UIView commitAnimations];
}
- (void)dealloc {
    [_allContain release];
    [_tiShi release];
    [_anSwer release];
    [_nextButton release];
    [super dealloc];
}
@end
