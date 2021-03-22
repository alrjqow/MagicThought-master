//
//  VKFontSizeStyle.m
//  CSSKitDemo
//
//  Created by Awhisper on 2016/10/11.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKFontSizeStyle.h"

@implementation VKFontSizeStyle

VK_REGISTE_ATTRIBUTE()

+ (NSString *)styleName{
    return @"font-size";
}

+ (void)setTarget:(id)target styleValue:(id)value{
    CGFloat fontsize = [value VKIdToCGFloat];
    
    if (fontsize <= 0) {
        return;
    }
    
    if ([target isKindOfClass:[UILabel class]])
    {
        UILabel* label = (UILabel*)target;
        label.font = [UIFont fontWithName:label.font.fontName size:fontsize];
        [label sizeToFit];
    }
    
    if ([target isKindOfClass:[UIButton class]])
    {
        UIButton* btn = (UIButton*)target;
        btn.titleLabel.font = [UIFont fontWithName:btn.titleLabel.font.fontName size:fontsize];
        [btn sizeToFit];
    }
    
    if ([target isKindOfClass:[UITextField class]])
    {
        UITextField* textField = (UITextField*)target;        
        textField.font = [UIFont fontWithName:textField.font.fontName size:fontsize];
        [textField sizeToFit];
    }
    
    if ([target isKindOfClass:[UITextView class]])
    {        
        UITextView* textView = (UITextView*)target;
        textView.font = [UIFont fontWithName:textView.font.fontName size:fontsize];
        [textView sizeToFit];
    }
}

@end
