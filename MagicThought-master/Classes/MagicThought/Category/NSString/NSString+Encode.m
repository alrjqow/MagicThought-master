//
//  NSString+Encode.m
//  8kqw
//
//  Created by 王奕聪 on 2017/6/30.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

-(NSString*)utf8String
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
