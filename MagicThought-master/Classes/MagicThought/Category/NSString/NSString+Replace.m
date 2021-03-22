//
//  NSString+Replace.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/22.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

-(NSString*)replaceSpecialChar
{
    NSString* str;
    
    str = [self stringByReplacingOccurrencesOfString:@"/" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@":" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    return str;
}

@end
