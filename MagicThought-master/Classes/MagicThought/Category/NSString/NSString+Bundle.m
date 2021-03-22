//
//  NSString+Bundle.m
//  MyTool
//
//  Created by 王奕聪 on 2017/3/6.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "NSString+Bundle.h"

@implementation NSString (Bundle)

-(NSString*)pathForPngResource:(NSString*)name
{
    return  [self pathForResource:name ofType:@"png"];
}

- (nullable NSString *)pathForResource:(nullable NSString *)name ofType:(nullable NSString *)ext
{
    return  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:self ofType:@"bundle"]] pathForResource:name ofType:ext];
}




@end
