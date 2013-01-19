//
//  ReadViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-8.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController
@synthesize question,arr,strTitle,str,dictionary,i,titleType,array=_array,stringAnswer,stringTishi,isWrong,artical,madeArray;

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
    
    if (!isWrong)
    {
        UIImage* image1= [UIImage imageNamed:@"btn_favorite_normal.png"];
        CGRect frame_2= CGRectMake(0, 0, image1.size.width, image1.size.height);
        UIButton* backButton1= [[UIButton alloc] initWithFrame:frame_2];
        [backButton1 setBackgroundImage:image1 forState:UIControlStateNormal];
        [backButton1 addTarget:self action:@selector(addQuestion) forControlEvents:UIControlEventTouchUpInside];
        //定制自己的风格的 UIBarButtonItem
        UIBarButtonItem* back1= [[UIBarButtonItem alloc] initWithCustomView:backButton1];
        [self.navigationItem setRightBarButtonItem:back1];
        [back1 release];
        [backButton1 release];
    }
    
    [self setContain];
}
-(void)addQuestion
{
    id delegate=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext=[delegate managedObjectContext];
    ReadArtical *read=[NSEntityDescription insertNewObjectForEntityForName:@"ReadArtical" inManagedObjectContext:managedObjectContext];
    read.titleType=[NSString stringWithFormat:@"%d",self.titleType];
    read.contain=self.allContain.text;
    read.result=self.stringAnswer;
    read.tishi=self.stringTishi;
    read.createDate=[NSDate date];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"添加题目失败, %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self drawRect];
}
- (void)drawRect
{
    UIGraphicsBeginImageContext(CGSizeMake(320, 330));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    imgV=[[UIImageView alloc]initWithImage:viewImage];
    imgV.frame=CGRectMake(0, 0, 320, 330);
    [self.view addSubview:imgV];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];//制定操作的属性名
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.toValue=[NSNumber numberWithFloat:0.0f];
    [animation setDuration:1.0f];
    [animation setDelegate:self];
    [imgV.layer addAnimation:animation forKey:@"animation"];
    
    CAKeyframeAnimation *animationPosition=[CAKeyframeAnimation animationWithKeyPath:@"position"];//制定操作的属性名
    NSArray *values=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(160, 155)],[NSValue valueWithCGPoint:CGPointMake(300, -20)], nil];
    [animationPosition setValues:values];
    [animationPosition setDuration:1.0f];
    [animationPosition setDelegate:self];
    [imgV.layer addAnimation:animationPosition forKey:@"img-position"];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setContain
{
    if (!isWrong)
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
        
        NSString *contain=[NSString stringWithFormat:@"%@",readContain];
        for (int n=0; n<[self.array count]-1; n++)
        {
            WanXing *wx=[self.array objectAtIndex:n];
            contain=[contain stringByAppendingFormat:@"\n%d. %@ \n A. %@ \n B. %@ \n C. %@ \n D. %@ \n",n+1,wx.tiTitle,wx.select1,wx.select2,wx.select3,wx.select4];
        }
        self.allContain.text=[NSString filterString:contain];
        //NSLog(@"%d",[self.array count]);
        NSString *contain1=[NSString stringWithFormat:@"\n参考答案："];
        if ([self.array count]==1)
        {
            WanXing *wx=[self.array objectAtIndex:0];
            contain1=[contain1 stringByAppendingFormat:@"\n%@ \n",wx.result];
        }
        else
        {
            for (int n=0; n<[self.array count]-1; n++)
            {
                WanXing *wx=[self.array objectAtIndex:n];
                contain1=[contain1 stringByAppendingFormat:@"\n%d. %@ \n",n+1,wx.result];
            }
        }
        self.stringAnswer=[NSString filterString:contain1];
        NSString *contain2=[NSString stringWithString:[NSString stringWithFormat:@"\n提示信息："]];
        if ([self.array count]==1)
        {
            WanXing *wx=[self.array objectAtIndex:0];
            contain2=[contain2 stringByAppendingFormat:@"\n%@ \n %@ \n  %@ \n",wx.hint1,wx.hint2,wx.hint3];
        }
        else
        {
            for (int n=0; n<[self.array count]-1; n++)
            {
                WanXing *wx=[self.array objectAtIndex:n];
                contain2=[contain2 stringByAppendingFormat:@"\n%d. %@ \n %@ \n  %@ \n",n+1,wx.hint1,wx.hint2,wx.hint3];
            }
        }
        self.stringTishi=[NSString stringWithString:[NSString filterString:contain2]];
    }
    else
    {
        self.allContain.text=self.artical.contain;
        self.stringAnswer=self.artical.result;
        self.stringTishi=self.artical.tishi;
    }
}
#pragma mark - NSXMLParserDelegate 代理方法
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"])
    {
        [self.dictionary removeAllObjects];
    }
    else if ([elementName isEqualToString:@"childThemeList"])
    {
        readContain=[NSString stringWithString:str];
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"select1"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"select2"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"select3"])
    {
        [str setString:@""];
    }
    else if ([elementName isEqualToString:@"select4"])
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
    else if ([elementName isEqualToString:@"select1"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"select2"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"select3"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"select4"])
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
        if ([[element allKeys] containsObject:@"select1"])
            temp.select1=[element objectForKey:@"select1"];
        else
            temp.select1=@"";
        if ([[element allKeys] containsObject:@"select2"])
            temp.select2=[element objectForKey:@"select2"];
        else
            temp.select2=@"";
        if ([[element allKeys] containsObject:@"select3"])
            temp.select3=[element objectForKey:@"select3"];
        else
            temp.select3=@"";
        if ([[element allKeys] containsObject:@"select4"])
            temp.select4=[element objectForKey:@"select4"];
        else
            temp.select4=@"";
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
    
    if (readContain!=nil)
     readContain=[[NSString filterString:readContain] substringToIndex:[[NSString filterString:readContain] length]-28];
    else
    {
        WanXing *wan=[self.array objectAtIndex:0];
        readContain=[[NSString filterString:wan.tiTitle] substringToIndex:[[NSString filterString:wan.tiTitle] length]-28];
    }
   // NSLog(@"%@",[[self filterString:readContain] substringToIndex:[[self filterString:readContain] length]-28]);
    // WanXing *wan=[self.array objectAtIndex:0];
   //  NSLog(@"%d",wan.tiId);
    //NSLog(@"%d",[self.array count]);
}
#pragma mark - 按钮
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
- (IBAction)nextTi:(UIButton *)sender
{
    if (!isWrong)
    {
        [self.dictionary removeAllObjects];
        [self.array removeAllObjects];
        if (i<[self.arr count]-1)
        {
            self.question=[self.arr objectAtIndex:++i];
        }
        readContain=nil;
    }
    else
    {
        if (i<[self.arr count]-1)
        {
            self.artical=[self.arr objectAtIndex:++i];
        }
    }
    [self goDown];
    [self setContain];
}

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_allContain release];
    [_tiShi release];
    [_anSwer release];
    [_nextButton release];
    [super dealloc];
}
@end
