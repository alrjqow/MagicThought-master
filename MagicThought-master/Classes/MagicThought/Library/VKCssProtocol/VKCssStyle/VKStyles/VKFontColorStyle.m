//
//  VKFontColorStyle.m
//  CSSKitDemo
//
//  Created by Awhisper on 2016/10/11.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKFontColorStyle.h"
#import "UIColor+VKUtlities.h"

@implementation VKFontColorStyle

VK_REGISTE_ATTRIBUTE()

+ (NSString *)styleName{
    return @"color";
}

+ (void)setTarget:(id)target styleValue:(id)value{
    UIColor *fontColor = [value VKIdToColor];
    
    if (!fontColor) {
        return;
    }
    
    if ([target isKindOfClass:[UILabel class]])
    {
        UILabel* label = (UILabel*)target;
        label.textColor = fontColor;
    }
    
    if ([target isKindOfClass:[UIButton class]])
    {
        UIButton* btn = (UIButton*)target;
        [btn setTitleColor:fontColor forState:UIControlStateNormal];
    }
    
    if ([target isKindOfClass:[UITextField class]])
    {
        UITextField* textField = (UITextField*)target;
        textField.textColor = fontColor;
    }
    
    if ([target isKindOfClass:[UITextView class]])
    {
        UITextView* textView = (UITextView*)target;\
        textView.textColor = fontColor;
    }
}


@end
