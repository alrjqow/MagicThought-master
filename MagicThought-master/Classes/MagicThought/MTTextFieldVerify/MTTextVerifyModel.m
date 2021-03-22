//
//  MTTextVerifyModel.m
//  MDKit
//
//  Created by monda on 2019/5/16.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTTextVerifyModel.h"
#import "NSString+TestString.h"
#import "NSString+Exist.h"
#import "MJExtension.h"

@interface MTTextVerifyModel ()
{
    NSString * _content;
    MTTextFieldEventType _event;
}

@property (nonatomic,assign) MTTextFieldEventType preEvent;

@property (nonatomic,assign) BOOL firstFill;

/**------------------------------------------------------------------*/

@property (nonatomic,assign) BOOL isNoMatchVerifyType;

@property (nonatomic,assign) BOOL isNoMatchMaxChar;


@end

@implementation MTTextVerifyModel

-(void)setEvent:(MTTextFieldEventType)event
{
    _event = event == self.preEvent ? MTTextFieldEventTypeDefault : event;
    self.preEvent = event;
}

-(MTTextFieldEventType)event
{
    return self.verifyType.integerValue == MTTextFieldVerifyTypeNone ? MTTextFieldEventTypeDefault : _event;
}

-(BOOL)verifyResult
{
    if(self.verifyType.integerValue == MTTextFieldVerifyTypeNone)
        return YES;
    if(self.testFormat)
        return [self.content testWithFormat:self.testFormat];
    
    switch (self.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
            return [self.content testPhoneNumber];
            
        case MTTextFieldVerifyTypeVFCode:
            return [self.content testVFCode];
            
        case MTTextFieldVerifyTypeMoney:
            return [self.content testMoney];
            
        case MTTextFieldVerifyTypeNumberPassword:
            return [self.content testPayPassword];
            
        case MTTextFieldVerifyTypePassword:
        case MTTextFieldVerifyTypeCustom:
            return [self.content testWithFormat:self.testFormat];
            
        default:
            return YES;
    }
}

-(void)setContent:(NSString *)content
{
    _content = content;
    
    switch (self.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        case MTTextFieldVerifyTypeVFCode:
        case MTTextFieldVerifyTypePassword:
        case MTTextFieldVerifyTypeNumberPassword:
        case MTTextFieldVerifyTypeCustom:
        {
            if(self.content.length >= self.minChar)
            {
                self.event = MTTextFieldEventTypePositive;
                self.firstFill = YES;
            }
            else
                self.event = self.firstFill ? MTTextFieldEventTypeNegative : MTTextFieldEventTypeDefault;
            
            break;
        }
            
        default:
            self.event = [content isExist] ? MTTextFieldEventTypePositive : MTTextFieldEventTypeNegative;
            break;
    }
}

-(NSInteger)minChar
{
    switch (self.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            if(_minChar <= 0)
                return 11;
        }
        case MTTextFieldVerifyTypeNumberPassword:
        case MTTextFieldVerifyTypeVFCode:
        {
            if(_minChar <= 0)
                return 6;
        }
            
        default:
            return _minChar;
    }
}

-(NSNumber*)maxChar
{
    switch (self.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            if(_maxChar <= 0)
                return @(11);
        }
        case MTTextFieldVerifyTypeNumberPassword:
        case MTTextFieldVerifyTypeVFCode:
        {
            if(_maxChar <= 0)
                return @(6);
        }
            
        default:
            return _maxChar;
    }
}

-(NSString *)content
{
    NSString* content;
    switch (self.verifyType.integerValue) {
        case MTTextFieldVerifyTypePhone:
        {
            content = [_content stringByReplacingOccurrencesOfString:@" " withString:@""];
            break;
        }
            
            
        case MTTextFieldVerifyTypeMoney:
        {
            content = [[_content stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@".00" withString:@""];
            break;
        }
            
        default:
            content = _content;
    }
    
    return [content isExist] ? content : @"";
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.shouldBeginEdit = YES;
}

-(BOOL)mt_result
{
    return self.verifyResult;
}

@end


NSString* kVerifyType = @"verifyType";
NSString* kMinChar = @"minChar";
NSString* kMaxChar = @"maxChar";
NSString* kTestFormat = @"testFormat";
NSString* kShouldBeginEdit = @"shouldBeginEdit";

NSObject* _Nonnull mt_verifyType(NSInteger verifyType)
{return mt_reuse(@(verifyType)).bindKey(@"verifyType");}

NSObject* _Nonnull mt_maxChar(NSInteger maxChar)
{return mt_reuse(@(maxChar)).bindKey(@"maxChar");}


@implementation MTTextVerifyModel(MJExtension)

+(NSArray *)mj_ignoredPropertyNames
{
    return @[
        @"viewHeight", @"isNoMatchHidden", @"isNoMatchBackgroundColor", @"isNoMatchText", @"isNoMatchWordStyle", @"isNoMatchBorderStyle", @"isNoMatchShadowStyle", @"isNoMatchTextColor", @"isNoMatchUserInteractionEnabled", @"isNoMatchMargin", @"isNoMatchKeyboardType", @"isNoMatchPadding", @"isNoMatchImage", @"isNoMatchPlaceholderImage", @"isNoMatchBackgroundImage", @"isNoMatchVerticalAlignment", @"isNoMatchHorizontalAlignment", @"isNoMatchClearButtonMode", @"finalModel", @"superModel", @"superOriginModel", @"isPlaceholder", @"associatedDefaultModel", @"associatedModel", @"matchHighlighted", @"matchDisabled", @"matchSelected", @"matchPlaceholder",@"isNoMatchReturnKeyType"
        ,@"isNoMatchNoHighLight", @"isNoMatchVerifyType", @"isNoMatchMaxChar"
    ];
}


@end
