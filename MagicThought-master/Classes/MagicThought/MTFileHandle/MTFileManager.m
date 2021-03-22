//
//  MTFileManager.m
//  Yoosee
//
//  Created by 王奕聪 on 16/9/18.
//  Copyright © 2016年 guojunyi. All rights reserved.
//

#import "MTFileManager.h"

@implementation MTFileManager

+(BOOL)isExistDirectoryAtPath:(NSString*)directoryPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = false;
    BOOL isDirExist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
        
    return isDirExist && isDir;
}

+ (BOOL)removeItem:(NSString*)itemName InDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:itemName];
    BOOL isExist = [mgr fileExistsAtPath:directoryPath];
    if(!isExist)
        return isExist;
    
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        return false;
//        // 报错:抛异常
//        NSException *excp = [NSException exceptionWithName:@"filePathError" reason:@"传错,必须传文件夹路径" userInfo:nil];
//        
//        [excp raise];
    }
    
    NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subpaths) {
        
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    return YES;
}

// 获取文件夹尺寸
+ (NSInteger)getDirectorySize:(NSString *)directoryPath
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 报错:抛异常
        NSException *excp = [NSException exceptionWithName:@"filePathError" reason:@"笨蛋,传错,必须传文件夹路径" userInfo:nil];
        
        [excp raise];
        
    }
    
    
    /*
     获取这个文件夹中所有文件路径,然后累加 = 文件夹的尺寸
     */
    
    
    // 获取文件夹下所有的文件
    NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0;
    
    for (NSString *subpath in subpaths) {
        
        // 拼接文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
        
        // 排除文件夹
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        // 指定路径获取这个路径的属性
        // attributesOfItemAtPath:只能获取文件属性
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        NSInteger size = [attr fileSize];
        
        totalSize += size;
    }
    
    return totalSize;
    
}

+ (NSString*)getDirectoryCapacityWithSize:(NSInteger)size
{    
    NSString *str = @"";
    if (size > 1000 * 1000) { // MB
        CGFloat totalSizeF = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@%.1fMB",str,totalSizeF];
    } else if (size > 1000) { // KB
        CGFloat totalSizeF = size / 1000.0;
        str = [NSString stringWithFormat:@"%@%.1fKB",str,totalSizeF];
    } else if (size > 0) { // B
        str = [NSString stringWithFormat:@"%@%ldB",str,size];
    }
    
    return str;
}

+(BOOL)createDirectoryAtPath:(NSString*)directoryPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
        return  [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return YES;
}

@end
