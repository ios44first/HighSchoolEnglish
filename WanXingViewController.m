//
//  WanXingViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-7.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "WanXingViewController.h"

@interface WanXingViewController ()

@end

@implementation WanXingViewController
@synthesize question,arr,strTitle,str,dictionary,i,array;

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
    self.navigationItem.title=[NSString stringWithFormat:@"%d年%@",self.question.year,self.strTitle];
    self.str=[NSMutableString string];
    self.array=[NSMutableArray array];
    self.dictionary=[NSMutableDictionary dictionary];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 420, 320 , 150)];
	scrollView.userInteractionEnabled = YES;
	scrollView.scrollEnabled = YES;
	[scrollView setContentSize:CGSizeMake(320, 2860)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_answersheet.png"]];
    imgView.frame=CGRectMake(0, 420, 320, 150);
	[self.view addSubview:imgView];
	[self.view addSubview:scrollView];

    [self setContain];
}
-(void)setContain
{
    [self.dictionary removeAllObjects];
    [self.array removeAllObjects];
    NSString *string=[NSString stringWithFormat:@"http://api.winclass.net/serviceaction.do?method=gettheme&subjectid=3&id=%d",self.question.questionsId];
    NSURL *newsURL=[[NSURL alloc]initWithString:string];
    NSData *xmlData=[[NSData alloc] initWithContentsOfURL:newsURL];
    NSXMLParser *parserTool=[[NSXMLParser alloc]initWithData:xmlData];
    parserTool.delegate=self;
    [parserTool parse];
    [newsURL release];
    [xmlData release];
    [parserTool release];
    
    self.containView.text=[self filterString:wanxingContain];
    //NSLog(@"%@",[self filterString:wanxingContain]);
    [self setScrollView];
    //NSLog(@"--%c--",answer[10][2]);
}
-(void)setScrollView
{
    for (int j=0; j<20; j++)
    {
        answer[j]='0';
    }
    for(UIView *view in [scrollView subviews])
    {
        [view removeFromSuperview];
    }
    for (int n=0; n<20; n++)
    {
        UILabel *num=[[UILabel alloc]initWithFrame:CGRectMake(5, 140*n+5, 25, 25)];
        num.text=[NSString stringWithFormat:@"%d.",n+1];
        [num setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:num];
        [num release];
        UILabel *ans=[[UILabel alloc]initWithFrame:CGRectMake(30, 140*n+5, 220, 25)];
        ans.text=@"请选择：";
        ans.tag=1+n;
        [ans setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:ans];
        [ans release];
        UIButton *tishi=[UIButton buttonWithType:UIButtonTypeCustom];
        tishi.frame=CGRectMake(250, 140*n+5, 60, 25);
        [tishi addTarget:self action:@selector(showTishi:) forControlEvents:UIControlEventTouchUpInside];
        [tishi setImage:[UIImage imageNamed:@"btn_prompt_pressed.png"] forState:UIControlStateNormal];
        tishi.tag=21+n;
        [scrollView addSubview:tishi];
        UIButton *selectA=[UIButton buttonWithType:UIButtonTypeCustom];
        selectA.frame=CGRectMake(20, 140*n+36, 20, 20);
        [selectA addTarget:self action:@selector(makeAns:) forControlEvents:UIControlEventTouchUpInside];
        [selectA setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        selectA.tag=110+n*10+1;
       // NSLog(@"%d",selectA.tag);
        [scrollView addSubview:selectA];
        UIButton *selectB=[UIButton buttonWithType:UIButtonTypeCustom];
        selectB.frame=CGRectMake(20, 140*n+62, 20, 20);
        [selectB addTarget:self action:@selector(makeAns:) forControlEvents:UIControlEventTouchUpInside];
        [selectB setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        selectB.tag=110+n*10+2;
        //NSLog(@"%d",selectB.tag);
        [scrollView addSubview:selectB];
        UIButton *selectC=[UIButton buttonWithType:UIButtonTypeCustom];
        selectC.frame=CGRectMake(20, 140*n+88, 20, 20);
        [selectC addTarget:self action:@selector(makeAns:) forControlEvents:UIControlEventTouchUpInside];
        [selectC setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        selectC.tag=110+n*10+3;
       // NSLog(@"%d",selectC.tag);
        [scrollView addSubview:selectC];
        UIButton *selectD=[UIButton buttonWithType:UIButtonTypeCustom];
        selectD.frame=CGRectMake(20, 140*n+114, 20, 20);
        [selectD addTarget:self action:@selector(makeAns:) forControlEvents:UIControlEventTouchUpInside];
        [selectD setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
        selectD.tag=110+n*10+4;
       // NSLog(@"%d",selectD.tag);
        [scrollView addSubview:selectD];
        
        WanXing *wan=[self.array objectAtIndex:n];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(50, 140*n+36, 260, 20)];
        [la setBackgroundColor:[UIColor clearColor]];
        la.text=[NSString stringWithFormat:@"A.  %@",wan.select1];
        [scrollView addSubview:la];
        [la release];
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(50, 140*n+62, 260, 20)];
        [lb setBackgroundColor:[UIColor clearColor]];
        lb.text=[NSString stringWithFormat:@"B.  %@",wan.select2];
        [scrollView addSubview:lb];
        [lb release];
        UILabel *lc=[[UILabel alloc]initWithFrame:CGRectMake(50, 140*n+88, 260, 20)];
        [lc setBackgroundColor:[UIColor clearColor]];
        lc.text=[NSString stringWithFormat:@"C.  %@",wan.select3];
        [scrollView addSubview:lc];
        [lc release];
        UILabel *ld=[[UILabel alloc]initWithFrame:CGRectMake(50, 140*n+114, 260, 20)];
        [ld setBackgroundColor:[UIColor clearColor]];
        ld.text=[NSString stringWithFormat:@"D.  %@",wan.select4];
        [scrollView addSubview:ld];
        [ld release];
    }
    UIButton *submitAn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitAn.frame=CGRectMake(105, 2810, 110, 42);
    [submitAn setImage:[UIImage imageNamed:@"btn_submit_pressed.png"] forState:UIControlStateNormal];
    [submitAn addTarget:self action:@selector(submitAns) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitAn];
}
-(void)submitAns
{
     NSLog(@"您选了%s",answer);
    for (int m=0; m<20; m++)
    {
        WanXing *wan=[self.array objectAtIndex:m];
        UILabel *label=(UILabel *)[scrollView viewWithTag:1+m];
        if ([[NSString stringWithFormat:@"%c",answer[m]] isEqualToString:wan.result])
            label.text=[NSString stringWithFormat:@" √ 您选了%c。回答正确！",answer[m]];
        else
            label.text=[NSString stringWithFormat:@" × 您选了%c，正确答案是%@。",answer[m],wan.result];
        //NSLog(@"%@",wan.result);
    }
}
-(void)showTishi:(UIButton *)sender
{
    int num=sender.tag-21;
    WanXing *wan=[self.array objectAtIndex:num];
    NSString *showString=[NSString stringWithFormat:@"%@\n%@\n%@",wan.hint1,wan.hint2,wan.hint3];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:[self filterString:showString] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
}
-(void)makeAns:(UIButton *)sender
{
    int x=((sender.tag-100)/10)-1;
    int y=sender.tag%10;
    UIButton *b1=(UIButton *)[scrollView viewWithTag:sender.tag/10*10+1];
    UIButton *b2=(UIButton *)[scrollView viewWithTag:sender.tag/10*10+2];
    UIButton *b3=(UIButton *)[scrollView viewWithTag:sender.tag/10*10+3];
    UIButton *b4=(UIButton *)[scrollView viewWithTag:sender.tag/10*10+4];
    switch (y)
    {
        case 1:
            answer[x]='A';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b4 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 2:
            answer[x]='B';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b4 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 3:
            answer[x]='C';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            [b4 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            break;
        case 4:
            answer[x]='D';
            [b1 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b2 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b3 setImage:[UIImage imageNamed:@"btn_radio_off.png"] forState:UIControlStateNormal];
            [b4 setImage:[UIImage imageNamed:@"btn_radio_on.png"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    NSLog(@"%d,%s",x,answer);
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
        wanxingContain=[NSString stringWithString:str];
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
    
   // WanXing *wan=[self.array objectAtIndex:0];
    //NSLog(@"%@",wan.result);
    //NSLog(@"%@",wanxingContain);
    //NSLog(@"%d",[self.array count]);
}

- (IBAction)downBut:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    if (isDown)
    {
        [sender setImage:[UIImage imageNamed:@"btn_foldup.png"] forState:UIControlStateNormal];
        isDown=NO;
        self.containView.frame=CGRectMake(0, 0, 320, self.containView.frame.size.height+150);
        self.downButton.frame=CGRectMake(self.downButton.frame.origin.x, self.downButton.frame.origin.y+150, self.downButton.frame.size.width, self.downButton.frame.size.height);
        self.nextBut.frame=CGRectMake(0, self.nextBut.frame.origin.y+150, self.nextBut.frame.size.width, self.nextBut.frame.size.height);
        scrollView.frame=CGRectMake(0, scrollView.frame.origin.y+150, scrollView.frame.size.width, scrollView.frame.size.height);
        imgView.frame=CGRectMake(0, imgView.frame.origin.y+150, imgView.frame.size.width, imgView.frame.size.height);
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"btn_folddown.png"] forState:UIControlStateNormal];
        isDown=YES;
        self.containView.frame=CGRectMake(0, 0, 320, self.containView.frame.size.height-150);
        self.downButton.frame=CGRectMake(self.downButton.frame.origin.x, self.downButton.frame.origin.y-150, self.downButton.frame.size.width, self.downButton.frame.size.height);
        self.nextBut.frame=CGRectMake(0, self.nextBut.frame.origin.y-150, self.nextBut.frame.size.width, self.nextBut.frame.size.height);
        scrollView.frame=CGRectMake(0, scrollView.frame.origin.y-150, scrollView.frame.size.width, scrollView.frame.size.height);
        imgView.frame=CGRectMake(0, imgView.frame.origin.y-150, imgView.frame.size.width, imgView.frame.size.height);
    }
    [UIView commitAnimations];
}

- (IBAction)nextButton:(UIButton *)sender
{
    if (i<[self.arr count]-1)
    {
        self.question=[self.arr objectAtIndex:++i];
    }
    [self setContain];
}

- (NSString *)filterString:(NSString *)string
{
    if (string!=nil)
    {
        NSMutableString *str1=[NSMutableString stringWithString:string];
        [str1 replaceOccurrencesOfString:@"&lt;U&gt;" withString:@"`" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;/U&gt;" withString:@"`" options:0 range:NSMakeRange(0, str1.length)]; 
        [str1 replaceOccurrencesOfString:@"&amp;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"nbsp;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;P&gt;" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;/P&gt;" withString:@"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&#xd;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;P style=&quot;TEXT-ALIGN: center&quot; align=center&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;" withString:@"  " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&apos;" withString:@"'" options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=\"text-align:left\" align=\"left\"&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        [str1 replaceOccurrencesOfString:@"&lt;p style=\"text-align:right\" align=\"right\"&gt;" withString:@" " options:0 range:NSMakeRange(0, str1.length)];
        
        return str1;
    }
    else
        return @"";
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
    [_containView release];
    [_downButton release];
    [_nextBut release];
    [super dealloc];
}
@end
