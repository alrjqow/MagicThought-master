//
//  NSObject+HideKey.m
//  8kqw
//
//  Created by 八块钱网 on 2017/1/5.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSObject+HideKey.h"
#include <objc/runtime.h>

@implementation NSObject (HideKey)

+(void)getKeyName
{
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(self, &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        NSLog(@"variable name :%@", key);
        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        NSLog(@"variable type :%@\n", key);
    }
    free(vars);
}

@end



@implementation NSObject (Pasteboard)

-(instancetype)copyToPasteboard
{
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        
    if([self isKindOfClass:[NSString class]])
        [pasteboard setString:(NSString*)self];
    
    return self;
}

@end
