//
//  NSString+Exist.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "NSString+Exist.h"

@implementation NSString (Exist)

+(BOOL) isEmpty:(NSString*)str
{
    if ([str isEqual:[NSNull null]]) {
        return true;
    }else if ([str isKindOfClass:[NSNull class]]){
        return true;
    }else if (str == nil) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}



-(BOOL) isExist
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
    if ([trimedString length] == 0) {
        return false;
    } else {
        return true;
    }
}

-(OrderAppend)orderAppend
{
        __weak __typeof(self) weakSelf = self;
    OrderAppend orderAppend = ^(NSString* str){
        
        return [NSString stringWithFormat:@"%@_%@", weakSelf, str];
    };
    
    return orderAppend;
}

@end

@implementation NSArray (OrderAppend)

-(OrderArrayAppend)orderArrayAppend
{
    __weak __typeof(self) weakSelf = self;
    OrderArrayAppend orderArrayAppend = ^(NSString* str){
        
        NSMutableArray* arr = [NSMutableArray array];
        for (NSString* string in weakSelf) {
            if([string isKindOfClass:[NSString class]])
               [arr addObject:string.orderAppend(str)];
        }
        
        return [arr copy];
    };
    
    return orderArrayAppend;
}

@end
