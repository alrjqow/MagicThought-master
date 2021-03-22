//
//  NSString+WordHeight.m
//  8kqw
//
//  Created by 王奕聪 on 2016/12/9.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import "NSString+WordHeight.h"

@implementation NSString (WordHeight)

-(CGFloat)calculateHeightWithWidth:(CGFloat)width andSystemFontSize:(CGFloat)fontSize
{
    return  [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                          options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}
                       context:nil].size.height;
}

-(CGFloat)calculateHeightWithWidth:(CGFloat)width andAttribute:(NSDictionary*)dict
{
    return  [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:dict  context:nil].size.height;
}


-(CGFloat)calculateWidthWithHeight:(CGFloat)height andSystemFontSize:(CGFloat)fontSize
{
    return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}
                               context:nil].size.width;
}

-(CGFloat)calculateWidthWithHeight:(CGFloat)height andAttribute:(NSDictionary*)dict
{
    return  [self boundingRectWithSize:CGSizeMake(height, MAXFLOAT)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:dict  context:nil].size.height;
}

@end
