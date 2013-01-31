//
//  DicViewController.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "DicViewController.h"

@interface DicViewController ()

@end

@implementation DicViewController

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
    self.navigationItem.title=@"英语词霸";
    self.inputWord.delegate=self;

    UIImage* image= [UIImage imageNamed:@"HY.png"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    backButton= [[UIButton alloc] initWithFrame:frame_1];
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(changeType) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* back= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:back];
    [back release];
    [backButton release];
    
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
-(void)addQuestion
{
    id delegate=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext=[delegate managedObjectContext];
    NewWord *word=[NSEntityDescription insertNewObjectForEntityForName:@"NewWord" inManagedObjectContext:managedObjectContext];
    word.titleType=[NSString stringWithFormat:@"%d",0];
    word.title=self.inputWord.text;
    word.result=self.translationView.text;
    word.createDate=[NSDate date];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"添加生词失败, %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self drawRect];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeImageView) userInfo:nil repeats:NO];
}
-(void)removeImageView
{
     [imgV removeFromSuperview];
}
- (void)drawRect
{   //截图
    UIGraphicsBeginImageContext(CGSizeMake(320, 330));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    imgV=[[UIImageView alloc]initWithImage:viewImage];
    imgV.frame=CGRectMake(0, 0, 320, 330);
    [self.view addSubview:imgV];
//逐渐缩小的动画效果
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];//制定操作的属性名
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.toValue=[NSNumber numberWithFloat:0.0f];
    [animation setDuration:1.0f];
    [animation setDelegate:self];
    [imgV.layer addAnimation:animation forKey:@"animation"];
//逐渐右移的动画效果
    CAKeyframeAnimation *animationPosition=[CAKeyframeAnimation animationWithKeyPath:@"position"];//制定操作的属性名
    NSArray *values=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(160, 155)],[NSValue valueWithCGPoint:CGPointMake(300, -20)], nil];
    [animationPosition setValues:values];
    [animationPosition setDuration:1.0f];
    [animationPosition setDelegate:self];
    [imgV.layer addAnimation:animationPosition forKey:@"img-position"];
}

-(void)changeType
{
    if (exChangeL)
    {
        exChangeL=NO;
        [backButton setImage:[UIImage imageNamed:@"HY.png"] forState:UIControlStateNormal];
    }
    else
    {
        exChangeL=YES;
        [backButton setImage:[UIImage imageNamed:@"YH.png"] forState:UIControlStateNormal];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.inputWord isExclusiveTouch])
    {
        [self.inputWord resignFirstResponder];
    }
}

- (IBAction)searchWord:(UIButton *)sender
{
    [self.inputWord resignFirstResponder];
    NSString *input=self.inputWord.text;
    if ([input length]==0)
    {
        return;
    }
    //NSStringEncoding enCode=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    /*NSString *urlStr=nil;
    if (exChangeL)
    {
        urlStr=[[NSString stringWithFormat:@"http://api.liqwei.com/translate/?language=en|zh-CN&content=%@",input] stringByAddingPercentEscapesUsingEncoding:enCode];
    }
    else
    {
        urlStr=[[NSString stringWithFormat:@"http://api.liqwei.com/translate/?language=zh-CN|en&content=%@",input]stringByAddingPercentEscapesUsingEncoding:enCode];
    }*/
//由接口得到URL
    NSString *urlStr=[[NSString stringWithFormat:@"http://dict.qq.com/dict?q=%@",input]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSError *error=nil;
    NSString *resutStr=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//返回的数据通过Json解析，返回一个字典
    NSDictionary *dic=[resutStr JSONValue];
    NSArray *array=nil;
    if ([[dic allKeys] containsObject:@"local"])
    {
        array = [dic valueForKey:@"local"];
    }
    if (array!=nil)
    {
        NSDictionary *one=[array objectAtIndex:0];
        if ([[one allKeys] containsObject:@"pho"])  //带有音标的
        {
            NSArray *yin=[one valueForKey:@"pho"];
            //NSDictionary *d=[arr objectAtIndex:0];
            NSArray *arr=[NSArray array];
            NSMutableString *result=[[NSMutableString alloc]init];
            if ([[one allKeys] containsObject:@"des2"])  //描述，词语的解释
            {
                arr=[one valueForKey:@"des2"];
            }
            else
            {
                result=[[NSMutableString alloc]initWithFormat:@"[%@]\n",[yin objectAtIndex:0]];
                arr=[one valueForKey:@"des"];
            }
            for (NSDictionary *des in arr)
            {
                if ([[des allKeys] containsObject:@"p"])
                {
                    [result appendFormat:@"%@  ",[des valueForKey:@"p"]];
                }
                if ([[des allKeys] containsObject:@"d"])
                {
                    [result appendFormat:@"%@\n",[des valueForKey:@"d"]];
                }
                if ([[des allKeys] containsObject:@"word"])
                {
                    [result appendFormat:@"※%@\n  ",[des valueForKey:@"word"]];
                }
                if ([[des allKeys] containsObject:@"pho"])
                {
                    [result appendFormat:@"   [%@]\n",[NSString Unicode10:[[des valueForKey:@"pho"] objectAtIndex:0]]];
                }
                if ([[des allKeys] containsObject:@"des"])
                {
                    NSArray *a=[des valueForKey:@"des"];
                    for (NSDictionary *d in a)
                    {
                        if ([[d allKeys] containsObject:@"p"])
                        {
                            [result appendFormat:@"%@  ",[d valueForKey:@"p"]];
                        }
                        if ([[d allKeys] containsObject:@"d"])
                        {
                            [result appendFormat:@"%@\n",[d valueForKey:@"d"]];
                        }
                    }
                }
                [result appendFormat:@"\n"];
            }
            if ([result length]==0)
            {
                NSArray *shortA=[one valueForKey:@"des"];
                NSDictionary *dicOne=[shortA objectAtIndex:0];
                [result appendString:[dicOne valueForKey:@"d"]];
            }
            self.translationView.text=[NSString Unicode10:result];
            [result release];
        }
        else   //没有音标的
        {
            NSArray *des2=[one valueForKey:@"des2"];
            //NSLog(@"%@",des2);
            NSMutableString *result=[[NSMutableString alloc]init];
            for (NSDictionary *des in des2)
            {
                if ([[des allKeys] containsObject:@"word"])
                {
                    [result appendFormat:@"※%@\n",[des valueForKey:@"word"]];
                }
                if ([[des allKeys] containsObject:@"pho"])
                {
                    [result appendFormat:@"   [%@]\n",[NSString Unicode10:[[des valueForKey:@"pho"] objectAtIndex:0]]];
                }
                if ([[des allKeys] containsObject:@"des"])
                {
                    for (NSDictionary *d in [des valueForKey:@"des"])
                    {
                        [result appendFormat:@"   %@  %@\n",[d valueForKey:@"p"],[d valueForKey:@"d"]];
                    }
                }
                [result appendFormat:@"\n"];
            }
            if ([result length]==0)
            {
                NSArray *shortA=[one valueForKey:@"des"];
                NSDictionary *dicOne=[shortA objectAtIndex:0];
                [result appendString:[dicOne valueForKey:@"d"]];
            }
             self.translationView.text=[NSString Unicode10:[NSString filterString:result]];
            [result release];
        }
    }
    else if([[dic allKeys] containsObject:@"netdes"])
    { //既没有音标有没有描述的（句子，短语）
        NSArray *one=[dic valueForKey:@"netdes"];
        NSDictionary *word=[one objectAtIndex:0];
        NSArray *shortArray=[word valueForKey:@"des"];
        NSDictionary *oneWord=[shortArray objectAtIndex:0];
        NSString *re=[oneWord valueForKey:@"d"];
        self.translationView.text=[NSString Unicode10:[NSString filterString:re]];
    }
    else
    {
        self.translationView.text=@"Sorry 暂无结果。。。";
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchWord:nil];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_inputWord release];
    [_translationView release];
    [super dealloc];
}

@end
