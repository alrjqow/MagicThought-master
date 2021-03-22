//
//  NSArray+Json.m
//  8kqw
//
//  Created by 王奕聪 on 2017/5/19.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "NSArray+Json.h"

@implementation NSArray (Json)

/**数组转json字符串*/
-(NSString *)json
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithJson:(NSString*)json
{
    if(![json isKindOfClass:[NSString class]])
        return @[];
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return array;
}

// 控制台输出
//-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
//{
//    NSMutableString *string = [NSMutableString string];
//    
//    // 开头有个{
//    [string appendString:@"[\n"];
//    
//    // 遍历所有的键值对
//    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [string appendFormat:@"\t"];        
//        if([obj isKindOfClass:[NSString class]])
//            [string appendFormat:@"\"%@\";\n", obj];
//        else if([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
//            [string appendFormat:@"%@;\n", [obj boolValue] ? @"Yes" : @"False"];
//        else if([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
//            [string appendFormat:@"@%@;\n", obj];
//        else
//            [string appendFormat:@"%@;\n", obj];
//    }];
//    
//    // 结尾有个}
//    [string appendString:@"]"];
//    
//    // 查找最后一个逗号
//    NSRange range = [string rangeOfString:@";" options:NSBackwardsSearch];
//    if (range.location != NSNotFound)
//        [string deleteCharactersInRange:range];
//    
//    return string;
//}

@end
