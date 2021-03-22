//
//  VKFontFamiltyStyle.m
//  VKCssProtocolDemo
//
//  Created by Awhisper on 2016/10/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKFontFamiltyStyle.h"

@implementation VKFontFamiltyStyle
VK_REGISTE_ATTRIBUTE()

+ (NSString *)styleName{
    return @"font-family";
}

+ (void)setTarget:(id)target styleValue:(id)value{
    NSString *fontName = [value VKIdToString];
    
    if (!fontName) {
        return;
    }
    

    id view;
    CGFloat fontsize = 0;
    if ([target isKindOfClass:[UILabel class]])
      {
          view = target;
          UILabel* label = (UILabel*)target;
          label.font = nil;
          fontsize = label.font.pointSize;
      }
      
      if ([target isKindOfClass:[UIButton class]])
      {
          view = target;
          UIButton* btn = (UIButton*)target;
          fontsize = btn.titleLabel.font.pointSize;
      }
      
      if ([target isKindOfClass:[UITextField class]])
      {
          view = target;
          UITextField* textField = (UITextField*)target;
          fontsize = textField.font.pointSize;
      }
      
      if ([target isKindOfClass:[UITextView class]])
      {
          view = target;
          UITextView* textView = (UITextView*)target;
          fontsize = textView.font.pointSize;
      }
    
    if(!view)
        return;
        
    UIFont* font;
    if ([fontName isEqualToString:@"systemFont"])
        font = [UIFont systemFontOfSize:fontsize];
    
    if ([fontName isEqualToString:@"boldSystemFont"])
        font = [UIFont boldSystemFontOfSize:fontsize];
    
    if ([fontName isEqualToString:@"italicSystemFont"])
        font = [UIFont italicSystemFontOfSize:fontsize];
    
    if(!font)
        font = [UIFont fontWithName:fontName size:fontsize];
    
    [view setFont:font];
    [view sizeToFit];
}
@end
