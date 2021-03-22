//
//  MTTextField.m
//  DaYiProject
//
//  Created by monda on 2018/8/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTTextField.h"
#import "NSString+TestString.h"
#import "NSString+Exist.h"
#import "NSString+Money.h"
#import "MTDelegateProtocol.h"
#import "UIView+MTBaseViewContentModel.h"

@interface MTTextField ()<MTTextFieldDelegate>

@end

@implementation MTTextField

#pragma mark - 生命周期

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupDefault];
    }
    
    return self;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.delegate = self;
    [self addTarget:self action:@selector(didTextValueChange:) forControlEvents:UIControlEventEditingChanged];
}


-(CGRect)textRectForBounds:(CGRect)bounds
{
    return [self rectForBounds:bounds];
}

//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    return [self rectForBounds:bounds];
//}

-(CGRect)rectForBounds:(CGRect)bounds
{
    if(!self.baseContentModel.padding)
          return bounds;
    
      UIEdgeInsets padding = self.baseContentModel.padding.UIEdgeInsetsValue;
      
      CGFloat x = padding.left;
      CGFloat y = padding.top;
      CGFloat w = bounds.size.width - padding.right - x;
      CGFloat h = bounds.size.height - padding.bottom - y;
      
      return CGRectMake(x, y, w, h);
}

#pragma mark - 代理与数据源

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (self.verifyModel.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            if(self.text.length < 1 && ![string isEqualToString:@"1"])
                return false;
        }
        case MTTextFieldVerifyTypeVFCode:
        case MTTextFieldVerifyTypePassword:
        case MTTextFieldVerifyTypeNumberPassword:
        case MTTextFieldVerifyTypeCustom:
            return (self.text.length + string.length) <= self.verifyModel.maxChar.integerValue;
            
        case MTTextFieldVerifyTypeMoney:
        {
            //如果输入的是“.”  判断之前已经有"."或者字符串为空
            if ([string isEqualToString:@"."] && ([self.text rangeOfString:@"."].location != NSNotFound || [self.text isEqualToString:@""])) {
                return NO;
            }
            
            //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
            NSMutableString *str = [[NSMutableString alloc] initWithString:self.text];
            [str insertString:string atIndex:range.location];
            if (str.length > [str rangeOfString:@"."].location+3){
                return NO;
            }
            
            return YES;
        }
            
        default:
        {
            switch (self.keyboardType) {
                case UIKeyboardTypeNumberPad:
                    return [string testDecimalWithPlace:0] || ![string isExist];
                    
                default:
                {
                    if([self.mt_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
                    return [((NSObject<MTTextFieldDelegate>*)self.mt_delegate) textField:textField shouldChangeCharactersInRange:range replacementString:string];
                    return YES;
                }                    
            }
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (self.verifyModel.verifyType.integerValue) {
            
        case MTTextFieldVerifyTypePhone:
        {
            self.text = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            break;
        }
            
        case MTTextFieldVerifyTypeMoney:
        {
            self.text = [[self.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@".00" withString:@""];
            break;
        }
            
            
        default:
            break;
    }
    
    if([self.mt_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [self.mt_delegate performSelector:@selector(textFieldDidBeginEditing:) withObject:self];
}

- (void)didEndEditing
{
    switch (self.verifyModel.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            if(![self.text isExist])
                break;
            
            if(self.text.length < 11)
                break;
            
            NSMutableString* text = [self.text mutableCopy];
            
            [text insertString:@" " atIndex:3];
            [text insertString:@" " atIndex:8];
            
            
            self.text = [text copy];
            break;
        }
            
        case MTTextFieldVerifyTypeMoney:
        {
            if([self.text isExist])
                self.text = [self.text money];
            break;
        }
            
        default:
            break;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self didEndEditing];
    
    if([self.mt_delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [self.mt_delegate performSelector:@selector(textFieldDidEndEditing:) withObject:self];
}

-(void)didTextValueChange:(UITextField *)textField
{
    self.verifyModel.content = [super text];
    if([self.mt_delegate respondsToSelector:@selector(didTextValueChange:)])
        [self.mt_delegate performSelector:@selector(didTextValueChange:) withObject:self];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return self.verifyModel ? self.verifyModel.shouldBeginEdit : YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.mt_delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        [self.mt_delegate performSelector:@selector(textFieldShouldReturn:) withObject:self];
    
    return false;
}

#pragma mark - 懒加载

-(void)setVerifyModel:(MTTextVerifyModel *)verifyModel
{    
    _verifyModel = verifyModel;
    
    switch (self.verifyModel.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        case MTTextFieldVerifyTypeVFCode:
        case MTTextFieldVerifyTypeNumberPassword:
        {
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
            
        case MTTextFieldVerifyTypeMoney:
        {
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        }
            
        default:
        {
            if(verifyModel.keyboardType)
                self.keyboardType = verifyModel.keyboardType.integerValue;
            else
                self.keyboardType = UIKeyboardTypeDefault;
        }
            
    }
    
    self.secureTextEntry = (self.verifyModel.verifyType.integerValue == MTTextFieldVerifyTypePassword) || (self.verifyModel.verifyType.integerValue == MTTextFieldVerifyTypeNumberPassword);
    self.text = verifyModel.content;
    
    [self didEndEditing];    
}

-(NSString *)text
{
    NSString* text;
    if(self.verifyModel)
        text = (NSString*)self.verifyModel.content.bindResult(self.verifyModel.mt_result);
    else
        text = (NSString*)[super text].bindResult(YES);

    return text;
}

@end

