//
//  VKBorderLeftStyle.m
//  VKCssProtocolDemo
//
//  Created by Awhisper on 2016/10/31.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKBorderLeftStyle.h"
#import "UIView+VKAddion.h"
@implementation VKBorderLeftStyle

VK_REGISTE_ATTRIBUTE()

+ (NSString *)styleName{
    return @"border-left";
}

+ (void)setTarget:(id)target styleValue:(id)value{
    
    NSString *borderStr = [value VKIdToString];
    NSArray *strArr = [borderStr componentsSeparatedByString:@" "];
    
    NSNumber *width = nil;
    UIColor *color = nil;
    for (NSString *str in strArr) {
        if ([str rangeOfString:@"px"].location != NSNotFound) {
            width = [NSNumber numberWithFloat:[str VKIdToCGFloat]];
        }else{
            color = [str VKIdToColor];
        }
    }
    
    if ([target isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)target;
        if (color && width) {
            view.cssLeftBorderWidth = width;
            view.cssLeftBorderColor = color;
            NSInteger currentBorderInt = [view.cssClipBorder integerValue];
            currentBorderInt = currentBorderInt | 0x0001;
            view.cssClipBorder = [NSNumber numberWithInteger:currentBorderInt];
        }
    }
}
@end
