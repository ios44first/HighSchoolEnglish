//
//  doWorkViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-7.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "doWorkViewController.h"

@interface doWorkViewController ()

@end

@implementation doWorkViewController
@synthesize question,arr,strTitle,str,dictionary,i,titleType,isWrong,madeArray;

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
    self.dictionary=[NSMutableDictionary dictionary];
    
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
    DanXuan *dan=[NSEntityDescription insertNewObjectForEntityForName:@"DanXuan" inManagedObjectContext:managedObjectContext];
    dan.titleType=[NSString stringWithFormat:@"%d",self.titleType];
    dan.title=[NSString filterString:self.danxuanti.tiTitle];
    dan.selectA=[NSString filterString:self.danxuanti.select1];
    dan.selectB=[NSString filterString:self.danxuanti.select2];
    dan.selectC=[NSString filterString:self.danxuanti.select3];
    dan.selectD=[NSString filterString:self.danxuanti.select4];
    dan.result=self.danxuanti.result;
    dan.tishi=[NSString stringWithFormat:@"%@\n%@\n%@",self.danxuanti.hint1,self.danxuanti.hint2,self.danxuanti.hint3];
    dan.createDate=[NSDate date];
    
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
    UIGraphicsBeginImageContext(CGSizeMake(320, 310));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    imgV=[[UIImageView alloc]initWithImage:viewImage];
    imgV.frame=CGRectMake(0, 0, 320, 310);
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
    }
    
    self.questionContain.text=[NSString filterString:self.danxuanti.tiTitle];
    self.chooseA.text=[NSString stringWithFormat:@"A.  %@",[NSString filterString:self.danxuanti.select1]];
    self.chooseB.text=[NSString stringWithFormat:@"B.  %@",[NSString filterString:self.danxuanti.select2]];
    self.chooseC.text=[NSString stringWithFormat:@"C.  %@",[NSString filterString:self.danxuanti.select3]];
    self.chooseD.text=[NSString stringWithFormat:@"D.  %@",[NSString filterString:self.danxuanti.select4]];
}

#pragma mark - NSXMLParserDelegate 代理方法
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
}
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
    else if ([elementName isEqualToString:@"year"])
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
    else if ([elementName isEqualToString:@"createdate"])
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
        
    }
    else if ([elementName isEqualToString:@"id"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
    else if ([elementName isEqualToString:@"year"])
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
    else if ([elementName isEqualToString:@"createdate"])
    {
        [self.dictionary setObject:[NSString stringWithString:str] forKey:elementName];
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    //NSLog(@"%@",self.dictionary);
    self.danxuanti.tiId=[[self.dictionary objectForKey:@"id"] intValue];
    self.danxuanti.tiYear=[[self.dictionary objectForKey:@"year"] intValue];
    self.danxuanti.tiTitle=[self.dictionary objectForKey:@"title"];
    self.danxuanti.select1=[self.dictionary objectForKey:@"select1"];
    self.danxuanti.select2=[self.dictionary objectForKey:@"select2"];
    self.danxuanti.select3=[self.dictionary objectForKey:@"select3"];
    self.danxuanti.select4=[self.dictionary objectForKey:@"select4"];
    self.danxuanti.result=[self.dictionary objectForKey:@"result"];
    self.danxuanti.hint1=[self.dictionary objectForKey:@"hint1"];
    if ([[self.dictionary allKeys]containsObject:@"hint2"])
        self.danxuanti.hint2=[self.dictionary objectForKey:@"hint2"];
    else
        self.danxuanti.hint2=@"";
    if ([[self.dictionary allKeys]containsObject:@"hint3"])
        self.danxuanti.hint3=[self.dictionary objectForKey:@"hint3"];
    else
        self.danxuanti.hint3=@"";
    self.danxuanti.createdate=[self.dictionary objectForKey:@"createdate"];
   
    //NSLog(@"%@",self.danxuanti.tiTitle);
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods
-(void)willPresentAlertView:(UIAlertView *)alertView
{
    alertView.frame=CGRectMake(10, 150, 300, 180);
    for (UIView *view in  alertView.subviews)
    {
        [view removeFromSuperview];
    }
    UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 180)];
    iv.image=[UIImage imageNamed:@"bg_reviewwords.png"];
    [alertView addSubview:iv];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(45, 0, 210, 36)];
    label.text=title;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor colorWithRed:0.22 green:0.77 blue:0.99 alpha:1.0];
    [alertView addSubview:label];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[UIImage imageNamed:@"btn_closereview_pressed.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    close.frame=CGRectMake(255, 0, 45, 36);
    [alertView addSubview:close];
    
    message = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, 280, 120)];
    message.editable=NO;
    message.textColor=[UIColor colorWithRed:0.22 green:0.77 blue:0.99 alpha:1.0];
    message.font=[UIFont systemFontOfSize:17];
    message.textAlignment=NSTextAlignmentCenter;
    [message setBackgroundColor:[UIColor clearColor]];
    message.text=msg;
    [alertView addSubview:message];
}
-(void)closeAlert:(UIButton *)sender
{
    UIAlertView *sup=(UIAlertView *)[sender superview];
    [sup dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -
#pragma mark 隐藏tabBar
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
    [_questionContain release];
    [_chooseA release];
    [_chooseB release];
    [_chooseC release];
    [_chooseD release];
    [_butA release];
    [_butB release];
    [_butC release];
    [_butD release];
    [_downButton release];
    [super dealloc];
}
- (IBAction)nextQuestion:(UIButton *)sender
{
    if (!isWrong)
    {
        if (i<[self.arr count]-1)
        {
            self.question=[self.arr objectAtIndex:++i];
        }
    }else
    {
        if (i<[self.arr count]-1)
        {
            DanXuan *dan=[self.arr objectAtIndex:++i];
            self.danxuanti.tiTitle=dan.title;
            self.danxuanti.select1=dan.selectA;
            self.danxuanti.select2=dan.selectB;
            self.danxuanti.select3=dan.selectC;
            self.danxuanti.select4=dan.selectD;
            self.danxuanti.result=dan.result;
            self.danxuanti.hint1=dan.tishi;
            self.danxuanti.hint2=@"";
            self.danxuanti.hint3=@"";
        }
    }
    
    [self setContain];
    [_butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
    [_butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
    [_butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
    [_butD setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
}

- (IBAction)tiShi:(UIButton *)sender
{
    UIAlertView *alert;
    NSString *an=[NSString stringWithFormat:@"%@\n%@\n%@",self.danxuanti.hint1,self.danxuanti.hint2,self.danxuanti.hint3];
     msg=[NSString filterString:an];
    title=@"提示：";
    alert=[[UIAlertView alloc]initWithTitle:@"提示：" message:[NSString filterString:an] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
    
}

- (IBAction)submitAnswer:(UIButton *)sender
{   
    UIAlertView *alert;
    title=@"答题结果";
    if ([answer isEqualToString:self.danxuanti.result])
    {
        msg=@"恭喜你答对了！";
       alert=[[UIAlertView alloc]initWithTitle:@"答题结果" message:@"恭喜你答对了！" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    }
    else
    {
        NSString *an=[NSString stringWithFormat:@"很遗憾您答错了，正确答案是%@",self.danxuanti.result];
        msg=an;
        alert=[[UIAlertView alloc]initWithTitle:@"答题结果" message:an delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    }
    [alert show];
    [alert release];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questionID" ofType:@"plist"];
    NSString *num=[NSString stringWithFormat:@"%d",self.danxuanti.tiId];
    if (![madeArray containsObject:num])
    {
        [madeArray addObject:num];
        [madeArray writeToFile:path atomically:YES];
    }
}

- (IBAction)chooseAnswer:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 11:
            answer=@"A";
            [_butA setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [_butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butD setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 12:
            answer=@"B";
            [_butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butB setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [_butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butD setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 13:
            answer=@"C";
            [_butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butC setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [_butD setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 14:
            answer=@"D";
            [_butA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [_butD setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            break;
    }
}
@end
