//
//  MTCloud.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/24.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTCloud.h"

@interface MTCloud ()

@property(nonatomic,strong) NSMutableDictionary* dict;

@end

@implementation MTCloud

-(NSMutableDictionary *)dict
{
    if(!_dict)
    {
        _dict = [NSMutableDictionary dictionary];
        [self.dict setObject:@"" forKey:@""];
    }
    return _dict;
}


+(MTCloud*)shareCloud
{
    return  [super manager];
}

- (void)removeObjectForKey:(id)key
{
    [self.dict removeObjectForKey:key];
}

- (void)setBool:(BOOL)value forKey:(id)key
{
    [self.dict setObject:@(value) forKey:key];
}

- (void)setInteger:(NSInteger)value forKey:(id)key
{
    [self.dict setObject:@(value) forKey:key];
}

- (void)setFloat:(CGFloat)value forKey:(id)key
{
    [self.dict setObject:@(value) forKey:key];
}

- (void)setString:(NSString*)str forKey:(id)key
{
    [self.dict setObject:str forKey:key];
}

- (void)setObject:(id)obj forKey:(id)key
{
    [self.dict setObject:obj forKey:key];
}

- (BOOL)boolForKey:(id)key
{
    return  ((NSNumber*)[self.dict objectForKey:key]).boolValue;
}

- (NSInteger)integerForKey:(id)key
{
    return  ((NSNumber*)[self.dict objectForKey:key]).integerValue;
}

- (CGFloat)floatForKey:(id)key
{
    return  ((NSNumber*)[self.dict objectForKey:key]).floatValue;
}

- (NSString*)stringForKey:(id)key
{
    return  (NSString*)[self.dict objectForKey:key];
}

- (instancetype)objectForKey:(id)key
{
    return  [self.dict objectForKey:key];
}

@end
