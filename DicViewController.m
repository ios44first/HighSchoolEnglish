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
    word.titleType=[NSNumber numberWithInt:0];
    word.title=self.inputWord.text;
    word.result=self.translationView.text;
    word.createDate=[NSDate date];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"添加生词失败, %@, %@", error, [error userInfo]);
        abort();
    }
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"收藏生词成功！" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
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
- (IBAction)searchWord:(UIButton *)sender
{
    [self.inputWord resignFirstResponder];
    NSString *input=self.inputWord.text;
    if ([input length]==0)
    {
        return;
    }
    NSString *urlStr=nil;
    NSStringEncoding enCode=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    if (exChangeL)
    {
        urlStr=[[NSString stringWithFormat:@"http://api.liqwei.com/translate/?language=en|zh-CN&content=%@",input] stringByAddingPercentEscapesUsingEncoding:enCode];
    }
    else
    {
        urlStr=[[NSString stringWithFormat:@"http://api.liqwei.com/translate/?language=zh-CN|en&content=%@",input]stringByAddingPercentEscapesUsingEncoding:enCode];
    }
    NSURL *url=[NSURL URLWithString:urlStr];
    NSError *error=nil;
    NSString *resutStr=[NSString stringWithContentsOfURL:url encoding:enCode error:&error];
    self.translationView.text=resutStr;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchWord:nil];
    return YES;
}
@end
