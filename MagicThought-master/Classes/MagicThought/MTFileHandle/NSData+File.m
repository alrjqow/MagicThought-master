//
//  NSData+File.m
//  8kqw
//
//  Created by 王奕聪 on 2017/4/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSData+File.h"
#import "NSString+Exist.h"
#import "MTFileManager.h"

@implementation NSData (File)

- (BOOL)writeToDirectory:(NSString *)directory File:(NSString*)file atomically:(BOOL)useAuxiliaryFile
{
    if(![file isExist]) return false;
    if(![MTFileManager createDirectoryAtPath:directory])
        return false;
    
    return [self writeToFile:[directory stringByAppendingPathComponent:file] atomically:useAuxiliaryFile];
}

@end
