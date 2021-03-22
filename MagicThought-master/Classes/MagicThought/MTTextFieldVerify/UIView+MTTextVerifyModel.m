//
//  UIView+MTTextVerifyModel.m
//  QXProject
//
//  Created by 王奕聪 on 2020/8/29.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UIView+MTTextVerifyModel.h"
#import "MTTextVerifyModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "MTTextView.h"
#import "MTTextField.h"

@implementation UIView (MTTextVerifyModel)

-(void)findVerifyTypeModel:(MTTextVerifyModel*)textVerifyModel
{
    if(![textVerifyModel isKindOfClass:[MTTextVerifyModel class]])
        return;
        
    [self findBaseViewContentModel:textVerifyModel Key:@"isNoMatchVerifyType" For:^BOOL(MTBaseViewContentModel *model) {
        
        MTTextVerifyModel* tModel = (MTTextVerifyModel*)model;
        if(![tModel isKindOfClass:[MTTextVerifyModel class]])
            return false;
        
        if(!textVerifyModel.verifyType && tModel.verifyType)
            textVerifyModel.verifyType = tModel.verifyType;
        return tModel.verifyType != nil;
    }];
}

-(void)findMaxCharModel:(MTTextVerifyModel*)textVerifyModel
{
    if(![textVerifyModel isKindOfClass:[MTTextVerifyModel class]])
        return;
        
    [self findBaseViewContentModel:textVerifyModel Key:@"isNoMatchMaxChar" For:^BOOL(MTBaseViewContentModel *model) {
        
        MTTextVerifyModel* tModel = (MTTextVerifyModel*)model;
        if(![tModel isKindOfClass:[MTTextVerifyModel class]])
            return false;
        
        if(!textVerifyModel.maxChar && tModel.maxChar)
            textVerifyModel.maxChar = tModel.maxChar;
        return tModel.maxChar != nil;
    }];
}


@end

@implementation MTTextView(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    [super setBaseContentModel:baseContentModel];
    
    if(![baseContentModel isKindOfClass:[MTTextVerifyModel class]])
        return;
    
    MTTextVerifyModel* textVerifyModel = (MTTextVerifyModel*)baseContentModel;
    textVerifyModel.content = textVerifyModel.wordStyle.wordName;
    
    //验证类型
    [self findVerifyTypeModel:textVerifyModel];
    
    //最大字符
    [self findMaxCharModel:textVerifyModel];
    
    self.verifyModel = textVerifyModel;
}


@end


@implementation MTTextField(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    [super setBaseContentModel:baseContentModel];
    
    if(![baseContentModel isKindOfClass:[MTTextVerifyModel class]])
        return;
        
    MTTextVerifyModel* textVerifyModel = (MTTextVerifyModel*)baseContentModel;
    textVerifyModel.content = textVerifyModel.wordStyle.wordName;
    
    //验证类型
    [self findVerifyTypeModel:textVerifyModel];
    
    //最大字符
    [self findMaxCharModel:textVerifyModel];
    
    self.verifyModel = textVerifyModel;
}


@end
