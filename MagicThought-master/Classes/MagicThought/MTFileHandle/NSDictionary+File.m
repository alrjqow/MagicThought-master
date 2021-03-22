//
//  NSDictionary+File.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSDictionary+File.h"
#import "NSString+Exist.h"
#import "MTFileManager.h"

@implementation NSDictionary (File)

- (BOOL)writeToDirectory:(NSString *)directory File:(NSString*)file atomically:(BOOL)useAuxiliaryFile
{
    if(![file isExist]) return false;    
    if(![MTFileManager createDirectoryAtPath:directory])
        return false;
    
    return [self writeToFile:[directory stringByAppendingPathComponent:file] atomically:useAuxiliaryFile];
}

+(NSDictionary*)removeNullKeyBeforeSave:(NSDictionary*)d
{
    NSMutableDictionary* dict = [d mutableCopy];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull object, BOOL * _Nonnull stop) {
        
        if([object isKindOfClass:[NSNull class]])
            [dict removeObjectForKey:key];
        else if([object isKindOfClass:[NSDictionary class]])
            dict[key] = [self removeNullKeyBeforeSave:object];
    }];
    
    return [dict copy];
}

@end
