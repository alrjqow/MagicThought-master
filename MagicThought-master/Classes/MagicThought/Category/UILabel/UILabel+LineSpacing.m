//
//  UILabel+LineSpacing.m
//  8kqw
//
//  Created by 王奕聪 on 16/10/8.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import "UILabel+LineSpacing.h"
#import "NSString+Exist.h"

@implementation UILabel (LineSpacing)

-(void)setAttrLineSpacing:(CGFloat)space
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    [self setAttributedText:attributedString];
}

-(void)setLineSpacingFloat:(CGFloat)space
{
    if(![self.text isExist])
        return;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineSpacing = space;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    [self setAttributedText:attributedString];
}

-(void)setLineSpacing:(CGFloat)space WithWordSpacing:(CGFloat)fontSpacing
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = space; //设置行间距
 
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{ NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(fontSpacing)
                           };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
    [self setAttributedText:attributeStr];
}


@end
