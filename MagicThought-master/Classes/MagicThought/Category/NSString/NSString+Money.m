//
//  NSString+Money.m
//  MyTool
//
//  Created by 王奕聪 on 2017/3/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "NSString+Money.h"
#import "NSString+Exist.h"

@implementation NSString (Money)

+(NSString*)stringWithMoneyHidePoint:(CGFloat)floatValue
{
    if(floatValue - (NSInteger)floatValue > 0)
        return [NSString stringWithFormat:@"%.2lf", floatValue];
    else
        return [NSString stringWithFormat:@"%.0lf", floatValue];
}

-(NSString*)money
{
    if(self.floatValue <= 0) return @"0.00";
    
    NSString* s;
    NSString* _s;
    
    NSRange range = [self rangeOfString:@"."];
    
    if(range.location != NSNotFound && range.location != self.length - 1)
    {
        NSArray* a = [self componentsSeparatedByString:@"."];
        s = a[0];
        _s = a[1];
    }
    else
        s = self;
    
    NSInteger length = s.length;
    
    
    
    for(int i =0; i <  length; i++)
    {
        NSRange range = [s rangeOfString:@"0"];
        
        if(range.location == NSNotFound || range.location != 0) break;
        
        s = [s substringFromIndex:range.location + 1];
    }
    
    NSMutableString* s1 = [[NSMutableString alloc] initWithString:s];
    
    NSInteger count = 0;
    length = s.length;
    
    while(true)
    {
        length -= 3;
        if(length > 0)
            count++;
        else
            break;
    }
    
    length = s.length;
    for(int i = 0; i < count; i++)
        [s1 insertString:@"," atIndex:(length - 3 - 3 * i)];
    
    s = [s1 copy];
    
    if(_s.length > 2)
        _s = [_s substringToIndex:2];
    
    if(![s isExist])
        s = @"0";
    
    if(![_s isExist])
        s = [NSString stringWithFormat:@"%@.00",s];
    else if(_s.length == 1)
        s = [NSString stringWithFormat:@"%@.%@0",s,_s];
    else
        s = [NSString stringWithFormat:@"%@.%@",s,_s];
    
    
    
    return s;
}

-(NSString*)floatMoney
{
    if(self.floatValue <= 0) return @"0.00";
    
    NSString* s;
    NSString* _s;
    
    NSRange range = [self rangeOfString:@"."];
    
    if(range.location != NSNotFound && range.location != self.length - 1)
    {
        NSArray* a = [self componentsSeparatedByString:@"."];
        s = a[0];
        _s = a[1];
    }
    else
        s = self;
    
    NSInteger length = s.length;
    
    for(int i =0; i <  length; i++)
    {
        NSRange range = [s rangeOfString:@"0"];
        
        if(range.location == NSNotFound || range.location != 0) break;
        
        s = [s substringFromIndex:range.location + 1];
    }
    
    NSMutableString* s1 = [[NSMutableString alloc] initWithString:s];
    
    NSInteger count = 0;
    length = s.length;
    
    while(true)
    {
        length -= 3;
        if(length > 0)
            count++;
        else
            break;
    }
    
//    length = s.length;
//    for(int i = 0; i < count; i++)
//        [s1 insertString:@"," atIndex:(length - 3 - 3 * i)];
    
    s = [s1 copy];
    
    if(_s.length > 2)
        _s = [_s substringToIndex:2];
    
    if(![s isExist])
        s = @"0";
    
    if(![_s isExist])
        s = [NSString stringWithFormat:@"%@.00",s];
    else if(_s.length == 1)
        s = [NSString stringWithFormat:@"%@.%@0",s,_s];
    else
        s = [NSString stringWithFormat:@"%@.%@",s,_s];
    
    
    
    return s;
}

-(NSString*)deleteFloatAllZero
{
    NSArray * arrStr=[self componentsSeparatedByString:@"."];
    NSString *str=arrStr.firstObject;
    NSString *str1=arrStr.lastObject;
    while ([str1 hasSuffix:@"0"]) {
        str1=[str1 substringToIndex:(str1.length-1)];
    }
    return (str1.length>0)?[NSString stringWithFormat:@"%@.%@",str,str1]:str;
}


@end


NSString* deleteFloatMoneyAllZero(CGFloat floatValue)
{
    return [[NSString stringWithFormat:@"%.2lf", floatValue] deleteFloatAllZero];
}
