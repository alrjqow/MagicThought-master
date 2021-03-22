//
//  NSDictionary+Json.h
//  8kqw
//
//  Created by 王奕聪 on 2017/5/19.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)

/**字典转json字符串*/
-(NSString *)json;

/**json转成字典*/
+ (NSDictionary *)dictionaryWithJson:(NSString*)json;

/**json文件转成字典*/
+ (NSDictionary *)dictionaryWithMainBundleJsonFile:(NSString*)jsonFile;

@end
