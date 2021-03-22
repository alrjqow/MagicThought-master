//
//  NSString+Base64.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/22.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)

-(NSString*)Base64Encode
{
    return  [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

-(NSString*)Base64Decode
{
    return  [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:self options:0] encoding:NSUTF8StringEncoding];
}

@end
