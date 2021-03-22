//
//  NSString+WordHeight.h
//  8kqw
//
//  Created by 王奕聪 on 2016/12/9.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (WordHeight)

-(CGFloat)calculateHeightWithWidth:(CGFloat)width andSystemFontSize:(CGFloat)fontSize;
-(CGFloat)calculateWidthWithHeight:(CGFloat)height andSystemFontSize:(CGFloat)fontSize;

-(CGFloat)calculateHeightWithWidth:(CGFloat)width andAttribute:(NSDictionary*)dict;
-(CGFloat)calculateWidthWithHeight:(CGFloat)height andAttribute:(NSDictionary*)dict;

@end
