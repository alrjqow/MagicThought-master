//
//  NSString+Exist.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^OrderAppend) (NSString* str);

@interface NSString (Exist)

@property (nonatomic,copy,readonly) OrderAppend orderAppend;

/*!
 判断字符串是否为空(空格、空字符也算空),若为空，返回false；不为空，返回Yes
 */
-(BOOL) isExist;

+(BOOL) isEmpty:(NSString*)str;

@end

typedef NSArray* (^OrderArrayAppend) (NSString* str);

@interface NSArray (OrderAppend)

@property (nonatomic,copy,readonly) OrderArrayAppend orderArrayAppend;

@end
