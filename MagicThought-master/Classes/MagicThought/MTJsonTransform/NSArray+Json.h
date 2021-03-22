//
//  NSArray+Json.h
//  8kqw
//
//  Created by 王奕聪 on 2017/5/19.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Json)

/**数组转json字符串*/
-(NSString *)json;

/**json转成数组*/
+ (NSArray *)arrayWithJson:(NSString*)json;

@end
