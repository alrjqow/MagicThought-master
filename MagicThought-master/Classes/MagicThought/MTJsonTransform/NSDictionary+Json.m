//
//  NSDictionary+Json.m
//  8kqw
//
//  Created by 王奕聪 on 2017/5/19.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

/**字典转json字符串*/
-(NSString *)json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


/**json转成字典*/
+ (NSDictionary *)dictionaryWithJson:(NSString*)json
{
    if(![json isKindOfClass:[NSString class]])
        return @{};
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dictionary;
}

/**json文件转成字典*/
+ (NSDictionary *)dictionaryWithMainBundleJsonFile:(NSString*)jsonFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonFile ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    // 对数据进行JSON格式化并返回字典形式
     return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

// 控制台输出
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];

    // 开头有个{
    [string appendString:@"{\n"];

    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@%@", [obj isKindOfClass:[NSDictionary class]] ? @"字典 : " : @"", key];
        [string appendString:@" = "];
        if([obj isKindOfClass:[NSString class]])
            [string appendFormat:@"\"%@\";\n", obj];
        else if([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
            [string appendFormat:@"%@;\n", [obj boolValue] ? @"Yes" : @"False"];
        else if([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
            [string appendFormat:@"@%@;\n", obj];
        else
            [string appendFormat:@"%@;\n", obj];
    }];

    // 结尾有个}
    [string appendString:@"}"];

    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@";" options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];

    return string;
}


@end
