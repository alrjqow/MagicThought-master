//
//  MTTextView.m
//  8kqw
//
//  Created by 王奕聪 on 2017/8/8.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTTextView.h"
#import "MTDelegateProtocol.h"
#import "UIView+Frame.h"
#import "NSString+TestString.h"
#import "NSString+Exist.h"

@interface MTTextView ()<UITextViewDelegate>

@property(nonatomic,weak) UILabel* placeholderLabel;

@end

@implementation MTTextView


-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if(self = [super initWithFrame:frame textContainer:textContainer])
    {        
        [self setupDefault];
    }

    return self;
}

-(void)setupDefault
{
    self.delegate = self;
    UILabel* label = [UILabel new];
    label.numberOfLines = 0;
    [self insertSubview:label atIndex:0];
    self.placeholderLabel = label;
    
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 1;
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.x = self.textContainerInset.left + self.font.pointSize * 0.5;
    self.placeholderLabel.y = self.textContainerInset.top;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return self.verifyModel ? self.verifyModel.shouldBeginEdit : YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    switch (self.verifyModel.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            if(self.text.length < 1 && ![text isEqualToString:@"1"])
                return false;
        }
        case MTTextFieldVerifyTypeVFCode:
        case MTTextFieldVerifyTypePassword:
        case MTTextFieldVerifyTypeNumberPassword:
        case MTTextFieldVerifyTypeCustom:
            return (self.text.length + text.length) <= self.verifyModel.maxChar.integerValue;
            
            
            
        case MTTextFieldVerifyTypeMoney:
        {
            //如果输入的是“.”  判断之前已经有"."或者字符串为空
            if ([text isEqualToString:@"."] && ([self.text rangeOfString:@"."].location != NSNotFound || [self.text isEqualToString:@""])) {
                return NO;
            }
            
            //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
            NSMutableString *str = [[NSMutableString alloc] initWithString:self.text];
            [str insertString:text atIndex:range.location];
            if (str.length > [str rangeOfString:@"."].location+3){
                return NO;
            }
            
            return YES;
        }
            
        default:
        {
            switch (self.keyboardType) {
                case UIKeyboardTypeNumberPad:
                    return [text testDecimalWithPlace:0] || ![text isExist];
                    
                default:
                {
                    if([self.mt_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
                        return [((NSObject<UITextViewDelegate>*)self.mt_delegate) textView:textView shouldChangeTextInRange:range replacementText:text];
                                
                    return YES;
                }
            }
        }
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = textView.text.length;
    self.verifyModel.content = textView.text;
    if([self.mt_delegate respondsToSelector:@selector(textViewDidChange:)])
       [self.mt_delegate performSelector:@selector(textViewDidChange:) withObject:textView];
//    if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
//        [self.mt_delegate doSomeThingForMe:self.verifyModel withOrder:@"MTTextValueChangeOrder"];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([self.mt_delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [self.mt_delegate performSelector:@selector(textViewDidEndEditing:) withObject:textView];
}

-(MTTextVerifyModel *)verifyModel
{
    if(!_verifyModel)
    {
        _verifyModel = [MTTextVerifyModel new];
    }
    
    return _verifyModel;
}

@end

