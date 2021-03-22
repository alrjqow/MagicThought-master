//
//  MTTextVerifyModel.h
//  MDKit
//
//  Created by monda on 2019/5/16.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseViewContentModel.h"

typedef NS_ENUM(NSInteger, MTTextFieldEventType)
{
    MTTextFieldEventTypeDefault = 0,
    MTTextFieldEventTypePositive = 1,
    MTTextFieldEventTypeNegative = -1
};

typedef NS_ENUM(NSInteger, MTTextFieldVerifyType)
{
    MTTextFieldVerifyTypeDefault,
    MTTextFieldVerifyTypeNone,
    MTTextFieldVerifyTypePhone,
    MTTextFieldVerifyTypeVFCode,
    MTTextFieldVerifyTypePassword,
    MTTextFieldVerifyTypeNumberPassword,
    MTTextFieldVerifyTypeMoney,
    MTTextFieldVerifyTypeCustom,
};

@interface MTTextVerifyModel : MTBaseViewContentStateModel

#pragma mark - 被动调用

/**文本框显示的内容*/
@property (nonatomic,strong) NSString* content;

/**用于标识输入是否达到标准，当且仅当首次达标或不达标才返回提示，其余均为默认值*/
@property (nonatomic,assign) MTTextFieldEventType event;

/**输入的验证结果*/
@property (nonatomic,assign, readonly) BOOL verifyResult;

#pragma mark - 主动调用
//MTTextFieldVerifyType
@property (nonatomic,strong) NSNumber* verifyType;

#pragma mark - 自定义验证

/**至少需要的字符*/
@property (nonatomic,assign) NSInteger minChar;

/**至多需要的字符*/
@property (nonatomic,strong) NSNumber* maxChar;

/**请输入想要检验的正则表达式*/
@property (nonatomic,strong) NSString* testFormat;

/**给外面用的标识*/
@property (nonatomic,strong) NSString* tag;

/**是否可编辑*/
@property(nonatomic,assign) BOOL shouldBeginEdit;

@end


CG_EXTERN NSString* kVerifyType;
CG_EXTERN NSString* kMinChar;
CG_EXTERN NSString* kMaxChar;
CG_EXTERN NSString* kTestFormat;
CG_EXTERN NSString* kShouldBeginEdit;


CG_EXTERN NSObject* _Nonnull mt_verifyType(NSInteger verifyType);
CG_EXTERN NSObject* _Nonnull mt_maxChar(NSInteger maxChar);
