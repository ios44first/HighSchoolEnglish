//
//  NSString+Filter.m
//  HighSchoolEnglish
//
//  Created by Ibokan on 13-1-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "NSString+Filter.h"

@implementation NSString (Filter)
+ (NSString *)filterString:(NSString *)string
{
    if (string!=nil)
    {
        /*NSMutableString *str1=[NSMutableString stringWithString:string];
         NSDictionary * replacements = [NSDictionary dictionaryWithObjectsAndKeys:@"(", @"&lt;U&gt;", @")", @"&lt;/U&gt;", @" ", @"&amp;", @"'", @"&apos;", @"\"", @"&quot;",@" ",@"&nbsp;",@" ",@"nbsp;",@" ",@"&lt;P&gt;",@" ",@"&lt;/P&gt;",@" ",@"&#xd;",@" ",@"&lt;P style=&quot;TEXT-ALIGN: center&quot; align=center&gt;",@" ",@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;",@" ",@"&lt;p style=&quot;text-align:center&quot; align=&quot;center&quot;&gt;",@" ",@"&lt;p&gt;",@" ",@"&lt;/p&gt;",@" ",@"&lt;p style=\"text-align:left\" align=\"left\"&gt;",@" ",@"&lt;p style=\"text-align:right\" align=\"right\"&gt;",@" ",@"<P style=\"TEXT-INDENT: 2em\">",@" ",@"</P>",@" ",@"<P>",@" ",@"<STRONG>",@" ",@"</STRONG>",@" ",@"<U>",@" ",@"</U>",@" ",@"P style=\"TEXT-INDENT: 2em\"",@" ",@"IMG border=0 src=\"/ewebeditor/uploadfile/2011/12/29/20111229143522001.gif\"/",@" ",@"BR&gt;",@"",@"&#xd;",nil];
        for (NSString * htmlEntity in replacements)
        {
            [str1 replaceOccurrencesOfString:htmlEntity withString:[replacements objectForKey:htmlEntity] options:0 range:NSMakeRange(0, [str1 length])];
        }
        
        return [[[NSString alloc] initWithString:str1] autorelease];*/
        NSMutableString *htmlStr = [NSMutableString stringWithString:string];
        NSDictionary * replacements = [NSDictionary dictionaryWithObjectsAndKeys:@"<", @"&lt;", @">", @"&gt;", @"&", @"&amp;", @"'", @"&apos;", @"\"", @"&quot;",@" ",@"&nbsp;",nil];
        for (NSString * htmlEntity in replacements)
        {
            [htmlStr replaceOccurrencesOfString:htmlEntity withString:[replacements objectForKey:htmlEntity] options:0 range:NSMakeRange(0, [htmlStr length])];
        }
        [htmlStr replaceOccurrencesOfString:@"&nbsp;" withString:@" " options:0 range:NSMakeRange(0, [htmlStr length])];
        [htmlStr replaceOccurrencesOfString:@"&#xd;" withString:@" " options:0 range:NSMakeRange(0, [htmlStr length])];
        [htmlStr replaceOccurrencesOfString:@"\">" withString:@" " options:0 range:NSMakeRange(0, [htmlStr length])];
        [htmlStr replaceOccurrencesOfString:@"<P style=\"TEXT-INDENT: 2em " withString:@"" options:0 range:NSMakeRange(0, [htmlStr length])];
        
        NSString *s=[NSString stringWithString:htmlStr];
        NSScanner *theScanner;
        NSMutableString *text = nil;
        theScanner = [NSScanner scannerWithString:s];
        while ([theScanner isAtEnd] == NO)
        {
            [theScanner scanUpToString:@"<" intoString:NULL];
            [theScanner scanUpToString:@">" intoString:&text];
            s = [s stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
        }
        return [[[NSString alloc] initWithString:s] autorelease]
        ;
    }
    else
        return @"";
}
-(NSString *) genHtmlStr:(NSString *)newStr
{
    NSMutableString *htmlStr = [NSMutableString stringWithString:newStr];
    
    NSDictionary * replacements = [NSDictionary dictionaryWithObjectsAndKeys:@"<", @"&lt;", @">", @"&gt;", @"&", @"&amp;", @"'", @"&apos;", @"\"", @"&quot;",@" ",@"&nbsp;",nil];
    for (NSString * htmlEntity in replacements)
    {
        [htmlStr replaceOccurrencesOfString:htmlEntity withString:[replacements objectForKey:htmlEntity] options:0 range:NSMakeRange(0, [htmlStr length])];
    }
    
    return [[[NSString alloc] initWithString:htmlStr] autorelease];
}
-(NSString *)flattenHTML:(NSString *)htmlstr
{
    NSScanner *theScanner;
    NSMutableString *text = nil;
    theScanner = [NSScanner scannerWithString:htmlstr];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        htmlstr = [htmlstr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
    return [[[NSString alloc] initWithString:htmlstr] autorelease]
    ;
}

@end
