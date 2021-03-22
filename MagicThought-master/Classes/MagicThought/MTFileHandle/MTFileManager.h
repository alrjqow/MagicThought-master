//
//  MTFileManager.h
//  Yoosee
//
//  Created by 王奕聪 on 16/9/18.
//  Copyright © 2016年 guojunyi. All rights reserved.
//

#import "MTManager.h"

@interface MTFileManager : MTManager

/**
 *  获取文件夹尺寸,以B为单位
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getDirectorySize:(NSString *)directoryPath;


/*!
    获取文件夹尺寸，返回字符串，带单位
 */
+ (NSString*)getDirectoryCapacityWithSize:(NSInteger)size;


/**
 *  删除文件夹下所有文件
 *
 *  @param directoryPath 文件夹全路径
 */
+ (BOOL)removeDirectoryPath:(NSString *)directoryPath;

/**
 *  删除文件夹下某个文件或文件夹;
 *
 *  @param directoryPath 文件夹全路径
 */
+ (BOOL)removeItem:(NSString*)itemName InDirectoryPath:(NSString *)directoryPath;

/**创建文件夹*/
+(BOOL)createDirectoryAtPath:(NSString*)directoryPath;

/**判断是否存在文件夹*/
+(BOOL)isExistDirectoryAtPath:(NSString*)directoryPath;

@end
