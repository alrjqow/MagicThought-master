//
//  MTManager.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/18.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"

@interface MTManager ()


@end

@implementation MTManager

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"这是个单例"
                                   reason:[NSString stringWithFormat:@"请调用 [%@ manager]",NSStringFromClass([self class])]
                                 userInfo:nil];
    return nil;
}

//实现自己真正的私有初始化方法
- (instancetype)initPrivate
{
    self  = [super init];
    return self;
}

static NSMutableDictionary* dict = nil;
+(instancetype)manager
{
    if(!dict)
    {
        dict = [NSMutableDictionary dictionary];
    }
    
    NSString* key = NSStringFromClass([self class]);
    if(dict[key] == nil)
    {
        [dict setValue:[[self alloc] initPrivate] forKey:key];
    }
    
    return dict[key];
}

+(void)clear
{
    NSString* key = NSStringFromClass([self class]);
    [dict removeObjectForKey:key];
    
    if([dict allKeys].count > 0) return;
    
    dict = nil;
}

@end
