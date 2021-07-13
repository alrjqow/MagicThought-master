//
//  UIView+MTBaseViewContentModel.m
//  QXProject
//
//  Created by monda on 2019/12/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIView+MTBaseViewContentModel.h"
#import "MTBaseViewContentModel.h"
#import "MTContentModelPropertyConst.h"
#import "objc/runtime.h"

#import "NSString+Exist.h"
#import "NSString+TestString.h"
#import "UIView+Circle.h"
#import "UILabel+Word.h"
#import "UIButton+Word.h"
#import "UITextField+Word.h"
#import "UITextView+Word.h"

#import "UIView+Frame.h"
#import "UIView+Delegate.h"

#import "UIView+Dependency.h"

#import "SDWebImageManager.h"

@interface UIView ()

/**目的是保存一个默认模型，防止由于cell重用时样式不为默认的情况发生*/
@property (nonatomic,strong) MTBaseViewContentModel* defaultBaseContentModel;

@end

@implementation UIView (MTBaseViewContentModel_Find)

-(void)associatedDefaultModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentStateModel* defaultBaseViewContentStateModel;
        
    if([[baseViewContentModel valueForKey:@"associatedDefaultModel"] isKindOfClass:[MTBaseViewContentStateModel class]])
        defaultBaseViewContentStateModel = [baseViewContentModel valueForKey:@"associatedDefaultModel"];
        
    MTBaseViewContentModel* baseContentModel;
    switch (defaultBaseViewContentStateModel.viewState) {
        case kHighlighted:
        {
            baseContentModel = defaultBaseViewContentStateModel.highlighted;
            [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            break;
        }
            
        case kDisabled:
        {
            baseContentModel = defaultBaseViewContentStateModel.disabled;
            [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            break;
        }
            
        case kSelected:
        case kSelectedForever:
        {
            baseContentModel = defaultBaseViewContentStateModel.selected;
            [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            
            break;
        }
            
        case kHeader:
        {
            baseContentModel = defaultBaseViewContentStateModel.header;
            [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
                
            break;
        }
            
        case kFooter:
        {
            baseContentModel = defaultBaseViewContentStateModel.footer;
            [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            break;
        }
            
        default:
            break;
    }
    
    if(baseContentModel)
        self.baseContentModel = baseContentModel;
    else
    {
        [[baseViewContentModel valueForKey:@"associatedDefaultModel"] setValue:@(kDefault) forKey:@"viewState"];
        self.baseContentModel = baseViewContentModel;
    }
}


-(MTBaseViewContentModel*)associatedModel:(MTBaseViewContentModel*)baseViewContentModel State:(NSInteger)viewState
{
    MTBaseViewContentStateModel* baseViewContentStateModel;
    if([baseViewContentModel isKindOfClass:[MTBaseViewContentStateModel class]])
        baseViewContentStateModel = (MTBaseViewContentStateModel*)baseViewContentModel;
    
    MTBaseViewContentStateModel* defaultBaseViewContentStateModel;
    if([[baseViewContentModel valueForKey:@"associatedDefaultModel"] isKindOfClass:[MTBaseViewContentStateModel class]])
        defaultBaseViewContentStateModel = [baseViewContentModel valueForKey:@"associatedDefaultModel"];
        
    MTBaseViewContentModel* baseContentModel;
    switch (viewState) {
        case kHighlighted:
        {
            if(baseViewContentStateModel.highlighted)
            {
                baseContentModel = baseViewContentStateModel.highlighted;
                [baseContentModel setValue:defaultBaseViewContentStateModel.highlighted forKey:@"associatedDefaultModel"];
            }
            else
            {
                baseContentModel = defaultBaseViewContentStateModel.highlighted;
                [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            }
            break;
        }
            
        case kDisabled:
        {
            if(baseViewContentStateModel.disabled)
            {
                baseContentModel = baseViewContentStateModel.disabled;
                [baseContentModel setValue:defaultBaseViewContentStateModel.disabled forKey:@"associatedDefaultModel"];
            }
            else
            {
                baseContentModel = defaultBaseViewContentStateModel.disabled;
                [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            }
            break;
        }
            
        case kSelected:
        case kSelectedForever:
        {
            if(baseViewContentStateModel.selected)
            {
                baseContentModel = baseViewContentStateModel.selected;
                [baseContentModel setValue:defaultBaseViewContentStateModel.selected forKey:@"associatedDefaultModel"];
            }
            else
            {
                baseContentModel = defaultBaseViewContentStateModel.selected;
                [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            }
            break;
        }
            
        case kHeader:
        {
            if(baseViewContentStateModel.header)
            {
                baseContentModel = baseViewContentStateModel.header;
                [baseContentModel setValue:defaultBaseViewContentStateModel.header forKey:@"associatedDefaultModel"];
            }
            else
            {
                baseContentModel = defaultBaseViewContentStateModel.header;
                [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            }
            break;
        }
            
        case kFooter:
        {
            if(baseViewContentStateModel.footer)
            {
                baseContentModel = baseViewContentStateModel.footer;
                [baseContentModel setValue:defaultBaseViewContentStateModel.footer forKey:@"associatedDefaultModel"];
            }
            else
            {
                baseContentModel = defaultBaseViewContentStateModel.footer;
                [baseContentModel setValue:baseViewContentModel forKey:@"associatedModel"];
            }
            break;
        }
            
        case kPlaceholder:
        {
            if(baseViewContentStateModel.placeholder)
            {
                baseContentModel = baseViewContentStateModel.placeholder;
                [baseContentModel setValue:defaultBaseViewContentStateModel.placeholder forKey:@"associatedDefaultModel"];
            }
            else
                baseContentModel = defaultBaseViewContentStateModel.placeholder;
            break;
        }
            
        default:
            break;
    }
    
    return baseContentModel;
}

-(void)setViewStateForModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* baseContentModel = [self associatedModel:baseViewContentModel State:baseViewContentModel.viewState];
    
    if(baseContentModel)
        self.baseContentModel = baseContentModel;
    else
    {
        baseViewContentModel.viewState = kDefault;
        self.baseContentModel = baseViewContentModel;
    }    
}

-(BOOL)checkBaseViewContentModel:(MTBaseViewContentModel*)baseContentModel
{
    if(![baseContentModel isKindOfClass:[MTBaseViewContentModel class]])
        return YES;
        
    MTBaseViewContentModel* finalModel;
//    if(baseContentModel == self.defaultBaseContentModel || baseContentModel == self.baseContentModel)
//    {
//        finalModel = [baseContentModel valueForKey:@"finalModel"];
//        if(finalModel && finalModel != baseContentModel)
//        {
//            self.baseContentModel = finalModel;
//            return YES;
//        }
//    }
    
    if(baseContentModel.beDefault && !baseContentModel.beDefault.mt_tag)
    {
        self.defaultBaseContentModel = baseContentModel;
        objc_setAssociatedObject(self, @selector(baseContentModel), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    else if(![baseContentModel valueForKey:@"superModel"] && ![baseContentModel valueForKey:@"superOriginModel"])
    {
        objc_setAssociatedObject(self, @selector(baseContentModel), baseContentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [baseContentModel setValue:self.defaultBaseContentModel forKey:@"associatedDefaultModel"];
        [self.defaultBaseContentModel setValue:nil forKey:@"finalModel"];
    }
            
    finalModel = [self.baseContentModel valueForKey:@"finalModel"];
    if(!finalModel)
        finalModel = [self.defaultBaseContentModel valueForKey:@"finalModel"];
    
    if(![self isKindOfClass:[UIButton class]] && !finalModel)
    {
        if(baseContentModel.viewState != kDefault)
        {
            [self setViewStateForModel:baseContentModel];
            return YES;
        }
        else if([baseContentModel valueForKey:@"associatedDefaultModel"] == self.defaultBaseContentModel && self.defaultBaseContentModel.viewState !=kDefault)
        {
            [self associatedDefaultModel:baseContentModel];
            return YES;
        }
    }
       
    if(!finalModel)
    {
        finalModel = baseContentModel;
        [self.baseContentModel setValue:finalModel forKey:@"finalModel"];
        [self.defaultBaseContentModel setValue:finalModel forKey:@"finalModel"];
    }
    
    if(![self isKindOfClass:[UILabel class]])
        return [self findHiddenModel:finalModel For:nil];
    
    return false;
}

-(void)setBaseStyleWithBaseViewContentModel:(MTBaseViewContentModel*)baseContentModel
{
    //外边距
    [self findMarginModel:baseContentModel];
    
    //用户交互性
    [self findUserInteractionEnabledModel:baseContentModel];
    
    //背景 与 边框
    [self findBackgroundColorAndBorderModel:baseContentModel];
    
    //阴影
    [self findShadowStyleModel:baseContentModel];
}

-(void)getWordStyleWithBaseViewContentModel:(MTBaseViewContentModel*)baseContentModel Completion:(void (^) (MTWordStyle* wordStyle))completion
{
    MTBaseViewContentModel* wordStyleContentModel = [self findWordStyleModel:baseContentModel];
    BOOL isMatch = [baseContentModel valueForKey:@"isPlaceholder"] == [wordStyleContentModel valueForKey:@"isPlaceholder"];
    MTWordStyle* wordStyle = isMatch ? wordStyleContentModel.wordStyle : baseContentModel.wordStyle;
    NSString* beginText = wordStyle.wordName;
    UIColor* beginColor = wordStyle.wordColor;
  
    [self findTextModel:baseContentModel For:^(NSString *text) {
        wordStyle.wordName = text;
    }];
    
    [self findTextColorModel:baseContentModel For:^(UIColor *textColor) {
        wordStyle.wordColor = textColor;
    }];
    
    if(wordStyle && completion)
        completion(wordStyle);
    
    wordStyle.wordName = beginText;
    wordStyle.wordColor = beginColor;
}

#pragma mark - FindModel

//是否隐藏
-(BOOL)findHiddenModel:(MTBaseViewContentModel*)baseViewContentModel For:(void (^)(BOOL isHidden))completion
{
    MTBaseViewContentModel* hiddenModel =
    [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchHidden" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.isHidden && model.isHidden)
            baseViewContentModel.isHidden = model.isHidden;
        return model.isHidden != nil;
    }];
    
    BOOL isHidden;
    if(hiddenModel.isHidden)
          isHidden = hiddenModel.isHidden.boolValue;
      else
          isHidden = false;
    
    self.hidden = isHidden;
    if(completion)
        completion(hiddenModel.isHidden != nil);
    
    return isHidden;
}

//背景颜色
-(MTBaseViewContentModel*)findBackgroundColorModel:(MTBaseViewContentModel*)baseViewContentModel
{
    return
    [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchBackgroundColor" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.backgroundColor && model.backgroundColor)
            baseViewContentModel.backgroundColor = model.backgroundColor;
        return model.backgroundColor != nil;
    }];
}

-(void)findBackgroundColorAndBorderModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* backgroundColorModel = [self findBackgroundColorModel:baseViewContentModel];
        
    MTBaseViewContentModel* borderStyleModel = [self findBorderStyleModel:baseViewContentModel];
    
    MTBaseViewContentModel* jianBianModel = [self findJianBianStyleModel:baseViewContentModel];
    
    if(backgroundColorModel)
    {
        if([self isKindOfClass:[UITableViewCell class]])
            self.backgroundColor = backgroundColorModel.backgroundColor;
        else
            self.layer.backgroundColor = backgroundColorModel.backgroundColor.CGColor;
    }
         
    MTBorderStyle* borderStyle = borderStyleModel.borderStyle;
    if(borderStyle)
    {
        if(!borderStyle.fillColor)
            borderStyle.fillColor = backgroundColorModel.backgroundColor;
        [self becomeCircleWithBorder:borderStyle];
    }
    else
    {
        self.layer.cornerRadius = self.layer.borderWidth = 0;
        self.layer.borderColor = nil;
        if([self isKindOfClass:[UILabel class]])
            self.layer.mask = nil;
        else
        {
            for (CALayer* layer in self.layer.sublayers)
            {
                if([layer isKindOfClass:[CAShapeLayer class]])
                    [layer removeFromSuperlayer];
            }
        }
    }
    
    MTJianBianStyle* jianBianStyle = jianBianModel.jianBianStyle;
    [jianBianStyle setBackgroundColor:self];
}

//纯文本
-(void)findTextModel:(MTBaseViewContentModel*)baseViewContentModel For:(void (^)(NSString* text))completion
{
    MTBaseViewContentModel* textModel =
    [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchText" For:^BOOL(MTBaseViewContentModel *model) {
        BOOL isMatch = [baseViewContentModel valueForKey:@"isPlaceholder"] == [model valueForKey:@"isPlaceholder"];
        if(isMatch && !baseViewContentModel.text && model.text && !baseViewContentModel.isDefaultOriginModel)
            baseViewContentModel.text = model.text;
        
        return isMatch && model.text != nil;
    }];
    
    BOOL isMatch = [textModel valueForKey:@"isPlaceholder"] == [baseViewContentModel valueForKey:@"isPlaceholder"];
    if(isMatch && textModel.text && completion)
        completion(textModel.text);
}

//文本样式
-(MTBaseViewContentModel*)findWordStyleModel:(MTBaseViewContentModel*)baseViewContentModel
{
    return
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchWordStyle" For:^BOOL(MTBaseViewContentModel *model) {
           BOOL isMatch = [baseViewContentModel valueForKey:@"isPlaceholder"] == [model valueForKey:@"isPlaceholder"];
                   
           if(!baseViewContentModel.wordStyle.isMake && model.wordStyle.isMake && isMatch && !baseViewContentModel.textColor)
               baseViewContentModel.wordStyle = model.wordStyle;
           
           return isMatch && model.wordStyle.isMake;
       }];
}

//边框样式
-(MTBaseViewContentModel*)findBorderStyleModel:(MTBaseViewContentModel*)baseViewContentModel
{
    return
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchBorderStyle" For:^BOOL(MTBaseViewContentModel *model) {
           if(!baseViewContentModel.borderStyle && model.borderStyle)
               baseViewContentModel.borderStyle = model.borderStyle;
           return model.borderStyle != nil;
       }];
}

//渐变样式
-(MTBaseViewContentModel*)findJianBianStyleModel:(MTBaseViewContentModel*)baseViewContentModel
{
    return
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchJianBianStyle" For:^BOOL(MTBaseViewContentModel *model) {
           if(!baseViewContentModel.jianBianStyle && model.jianBianStyle)
               baseViewContentModel.jianBianStyle = model.jianBianStyle;
           return model.jianBianStyle != nil;
       }];
}

//阴影样式
-(void)findShadowStyleModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* shadowStyleModel =
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchShadowStyle" For:^BOOL(MTBaseViewContentModel *model) {
           if(!baseViewContentModel.shadowStyle && model.shadowStyle)
               baseViewContentModel.shadowStyle = model.shadowStyle;
           return model.shadowStyle != nil;
       }];
        
    if(shadowStyleModel.shadowStyle)
        [self becomeShadow:shadowStyleModel.shadowStyle];
    else
    {
        self.layer.shadowColor = nil;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 0;
    }
}

//纯文本颜色
-(void)findTextColorModel:(MTBaseViewContentModel*)baseViewContentModel For:(void (^)(UIColor* textColor))completion
{
    MTBaseViewContentModel* textColorModel =
    [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchTextColor" For:^BOOL(MTBaseViewContentModel *model) {
        BOOL isMatch = [baseViewContentModel valueForKey:@"isPlaceholder"] == [model valueForKey:@"isPlaceholder"];
        if(isMatch && !baseViewContentModel.textColor && model.textColor)
            baseViewContentModel.textColor = model.textColor;
        
        return isMatch && model.textColor != nil;
    }];
    
    BOOL isMatch = [textColorModel valueForKey:@"isPlaceholder"] == [baseViewContentModel valueForKey:@"isPlaceholder"];
    
    if(isMatch && textColorModel.textColor && completion)
        completion(textColorModel.textColor);
}

//用户交互性
-(void)findUserInteractionEnabledModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* userInteractionEnabledModel =
    [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchUserInteractionEnabled" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.userInteractionEnabled && model.userInteractionEnabled)
            baseViewContentModel.userInteractionEnabled = model.userInteractionEnabled;
        return model.userInteractionEnabled != nil;
    }];
    
    NSNumber* userInteractionEnabled = userInteractionEnabledModel.userInteractionEnabled;
    if(userInteractionEnabled)
        self.userInteractionEnabled = userInteractionEnabled.boolValue;
}

//外边距
-(void)findMarginModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* marginModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchMargin" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.margin && model.margin)
            baseViewContentModel.margin = model.margin;
        return model.margin != nil;
    }];
    
    NSValue* margin = marginModel.margin;
    UIEdgeInsets viewMargin = self.margin;
    if(margin && !UIEdgeInsetsEqualToEdgeInsets(margin.UIEdgeInsetsValue, viewMargin))
        self.margin = margin.UIEdgeInsetsValue;
}

//内边距
-(void)findPaddingModel:(MTBaseViewContentModel*)baseViewContentModel For:(void(^)(UIEdgeInsets contentEdgeInsets))completion
{
    MTBaseViewContentModel* paddingModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchPadding" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.padding && model.padding)
            baseViewContentModel.padding = model.padding;
        return model.padding != nil;
    }];
    
    if(paddingModel.padding && completion)
        completion(paddingModel.padding.UIEdgeInsetsValue);
}

// 键盘类型
-(void)findKeyboardTypeModel:(MTBaseViewContentModel*)baseViewContentModel For:(void(^)(UIKeyboardType keyboardType))completion
{
    MTBaseViewContentModel* keyboardTypeModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchKeyboardType" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.keyboardType && model.keyboardType)
            baseViewContentModel.keyboardType = model.keyboardType;
        return model.keyboardType != nil;
    }];
    
    if(keyboardTypeModel.keyboardType && completion)
        completion(keyboardTypeModel.keyboardType.integerValue);
}

-(void)findReturnKeyTypeModel:(MTBaseViewContentModel*)baseViewContentModel For:(void(^)(UIReturnKeyType returnKeyType))completion
{
    MTBaseViewContentModel* returnKeyTypeModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchReturnKeyType" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.returnKeyType && model.returnKeyType)
            baseViewContentModel.returnKeyType = model.returnKeyType;
        return model.returnKeyType != nil;
    }];
    
    if(returnKeyTypeModel.returnKeyType && completion)
        completion(returnKeyTypeModel.returnKeyType.integerValue);
}

//图片
-(void)findImageModel:(MTBaseViewContentModel*)baseViewContentModel For:(void(^)(UIImage* image))completion
{
    MTBaseViewContentModel* imageModel =
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchImage" For:^BOOL(MTBaseViewContentModel *model) {
           return model.image || [model.imageURL isExist] || ([model.placeholderImage isKindOfClass:[NSString class]] && [model.placeholderImage isExist]) || [model.placeholderImage isKindOfClass:[UIImage class]];
       }];
    
        
      if(imageModel.image && completion)
          completion(imageModel.image);
      else if([imageModel.imageURL isExist])
      {
          UIImage* image;
          if([imageModel.imageURL isExist])
              image = [UIImage imageNamed:imageModel.imageURL];
          if(image && completion)
              completion(image);
          else if([imageModel.imageURL testStartWith:@"http"])
          {
              [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:imageModel.imageURL] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                    
                  if(!image)
                  {
                      MTBaseViewContentModel* placeholderImageModel =
                      [self findPlaceholderImageModel:baseViewContentModel];
                      if(placeholderImageModel.image)
                          image = placeholderImageModel.image;
                      else
                      {
                          if([placeholderImageModel.placeholderImage isKindOfClass:[UIImage class]])
                              image = placeholderImageModel.placeholderImage;
                          else if([placeholderImageModel.placeholderImage isKindOfClass:[NSString class]] && [(NSString*)placeholderImageModel.placeholderImage isExist])
                              image = [UIImage imageNamed:placeholderImageModel.placeholderImage];
                          
                          placeholderImageModel.image = image;
                      }
                  }
                                        
                  if(!image)
                      return;
                  
                  if(completion)
                      completion(image);
                  
                  if([imageModel.mt_order isEqualToString:@"MTBigimageCellOrder"])
                  {
                      UIView* superView = self.superview;
                      while (YES) {
                          if(!superView || [superView isKindOfClass:NSClassFromString(@"MTImageShowCell_Big")])
                          {
                              [superView layoutSubviews];
                              break;
                          }
                          superView = superView.superview;
                      }
                  }
              }];
          }
      }
    else if([imageModel.placeholderImage isKindOfClass:[NSString class]] && [imageModel.placeholderImage isExist] && completion)
        completion([UIImage imageNamed:imageModel.placeholderImage]);
    else if([imageModel.placeholderImage isKindOfClass:[UIImage class]] && completion)
        completion(imageModel.placeholderImage);
}

-(MTBaseViewContentModel*)findPlaceholderImageModel:(MTBaseViewContentModel*)baseViewContentModel
{
    return
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchPlaceholderImage" For:^BOOL(MTBaseViewContentModel *model) {
           return  ([model.placeholderImage isKindOfClass:[NSString class]] && [model.placeholderImage isExist]) || [model.placeholderImage isKindOfClass:[UIImage class]];
       }];
}

// allState
-(MTBaseViewContentModel*)whenGetViewState:(NSInteger)viewState ForModel:(MTBaseViewContentModel*)baseViewContentModel
{
    NSString* key;
    switch (viewState) {
        case kHighlighted:
        {
            key = @"matchHighlighted";
            break;
        }
        case kDisabled:
        {
            key = @"matchDisabled";
            break;
        }
        case kSelected:
        case kSelectedForever:
        {
            key = @"matchSelected";
            break;
        }
            
        case kPlaceholder:
        {
            key = @"matchPlaceholder";
            break;
        }
            
        default:
            break;
    }
    
    MTBaseViewContentModel* baseContentModel;
    if([key isExist])
        baseContentModel = [baseViewContentModel valueForKey:key];
    
    if(baseContentModel)
        return baseContentModel;
    
    baseContentModel = [self getViewState:viewState ForModel:baseViewContentModel];
    if(baseContentModel && [key isExist] && [baseViewContentModel isKindOfClass:[MTBaseViewContentStateModel class]])
       [baseViewContentModel setValue:baseContentModel forKey:key];
        
    return baseContentModel;
}

-(MTBaseViewContentModel*)getViewState:(NSInteger)viewState ForModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* baseContentModel = [self associatedModel:baseViewContentModel State:viewState];
    
    if(baseContentModel)
        return [self getViewState:viewState ForModel:baseContentModel];
    else
        return baseViewContentModel;
}


//背景图片
-(void)findBackgroundImageModel:(MTBaseViewContentModel*)baseViewContentModel For:(void(^)(UIImage* image))completion
{
    MTBaseViewContentModel* backgroundImageModel =
       [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchBackgroundImage" For:^BOOL(MTBaseViewContentModel *model) {
           return  model.image_bg != nil;
       }];
    
    if(backgroundImageModel.image_bg && completion)
        completion(backgroundImageModel.image_bg);
}

-(MTBaseViewContentModel*)findBaseViewContentModel:(MTBaseViewContentModel*)baseViewContentModel Key:(NSString*)key For:(BOOL (^)(MTBaseViewContentModel* model))check
{
    if(!check)
        return nil;
                
    if([[baseViewContentModel valueForKey:key] boolValue])
        return self.defaultBaseContentModel ? self.defaultBaseContentModel : baseViewContentModel;
        
    if(check(baseViewContentModel))
        return baseViewContentModel;
        
    MTBaseViewContentModel* associatedModel = [baseViewContentModel valueForKey:@"associatedModel"];
    if([baseViewContentModel valueForKey:@"superOriginModel"] == self.defaultBaseContentModel && associatedModel)
    {
        while (associatedModel) {
              
              if(check(associatedModel))
                  return associatedModel;
              
              associatedModel = [associatedModel valueForKey:@"associatedModel"];
          }
    }
    
    MTBaseViewContentModel* superModel = [baseViewContentModel valueForKey:@"superModel"];
    while (superModel) {
        
        if(check(superModel))
            return superModel;
        
        superModel = [superModel valueForKey:@"superModel"];
    }
    
    if(!baseViewContentModel.isDefaultOriginModel)
        [baseViewContentModel setValue:@(YES) forKey:key];
        
    if(self.defaultBaseContentModel)
    {
        check(self.defaultBaseContentModel);
        return self.defaultBaseContentModel;
    }

    return baseViewContentModel;
}

@end

@implementation UIView (MTBaseViewContentModel)

-(void)setBaseModelConfig:(MTBaseViewContentModel*)baseContentModel{}

-(void)viewEventWithView:(UIView*)view Data:(NSObject*)data
{
    if(view == self)
        [self clickWithClearData:data];
    else
    {
        [view clickWithNotClearData:data];
        [self clickWithClearData:data];        
    }
}

/**IsClearOrder = Yes*/
-(void)clickWithClearData:(NSObject*)data
{
    [self eventWithData:data IsClear:YES];
}

/**IsClearOrder = False*/
-(void)clickWithNotClearData:(NSObject*)data
{
    [self eventWithData:data IsClear:false];
}

-(void)eventWithData:(NSObject*)data IsClear:(BOOL)isClear
{
    if(!data)
        return;
    if(![data.mt_order isExist])
    {
        if([self.baseContentModel.mt_order isExist])
            data.bindOrder(self.baseContentModel.mt_order);
        else if([self.mt_order isExist])
            data.bindOrder(self.mt_order);
        else if([data.mt_reuseIdentifier isExist])
            data.bindOrder(data.mt_reuseIdentifier);
        else
            data.mt_order = [NSString stringWithFormat:@""];
                    
        data.mt_order.bindEnum(self.mt_tag);
        if(self.mt_tagIdentifier)
            data.mt_order.bindTagText(self.mt_tagIdentifier);
        else
            data.mt_order.mt_tagIdentifier = @"";
    }
    
    if([data.mt_order containsString:@"MTBanClickOrder"])
        return;
            
    if(self.mt_click)
        self.mt_click(data);
    if([self.mt_delegate isKindOfClass:NSClassFromString(@"MTBaseAlertController")])
        ((NSObject*)self.mt_delegate).mt_order = self.baseContentModel.mt_order;
    if(self.baseContentModel.mt_click && (self.mt_click != self.baseContentModel.mt_click))
        self.baseContentModel.mt_click(data);
    else if(self.defaultBaseContentModel.mt_click && (self.mt_click != self.defaultBaseContentModel.mt_click))
        self.defaultBaseContentModel.mt_click(data);
    else if(data.mt_click && (self.mt_click != data.mt_click))
        data.mt_click(data);
        
    if(isClear)
       [data clearBind];
}

-(instancetype)setWithObject:(NSObject *)obj
{
    [super setWithObject:obj];
    
    MTBaseViewContentModel* model;
    if([obj isKindOfClass:[MTBaseViewContentModel class]])
        model = (MTBaseViewContentModel*)obj;
    else if([obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
    {
        if([self.classOfResponseObject isSubclassOfClass:[MTBaseViewContentModel class]])
            model = self.classOfResponseObject.new;
        else
            model = MTBaseViewContentModel.new;
        
        model.setObjects(obj);
    }
    if(model)
    {
        if([model isKindOfClass:self.classOfResponseObject])
           [self whenGetResponseObject:model];
        else
            self.baseContentModel = model;
    }
    
    return self;
}

-(void)setViewState:(NSUInteger)viewState
{
    MTBaseViewContentStateModel* baseViewContentStateModel;
    if([self.baseContentModel isKindOfClass:[MTBaseViewContentStateModel class]])
        baseViewContentStateModel = (MTBaseViewContentStateModel*)self.baseContentModel;
    
    MTBaseViewContentStateModel* defaultBaseViewContentStateModel;
    if([self.defaultBaseContentModel isKindOfClass:[MTBaseViewContentStateModel class]])
        defaultBaseViewContentStateModel = (MTBaseViewContentStateModel*)self.defaultBaseContentModel;
        
    MTBaseViewContentModel* baseContentModel;
    switch (viewState) {
        case kHighlighted:
        {
            baseContentModel = baseViewContentStateModel.highlighted ? baseViewContentStateModel.highlighted : defaultBaseViewContentStateModel.highlighted;
            break;
        }
        case kDisabled:
        {
            baseContentModel = baseViewContentStateModel.disabled ? baseViewContentStateModel.disabled : defaultBaseViewContentStateModel.disabled;
            break;
        }
        case kSelected:
        case kSelectedForever:
        {
            baseContentModel = baseViewContentStateModel.selected ? baseViewContentStateModel.selected : defaultBaseViewContentStateModel.selected;
            break;
        }
        case kHeader:
        {
            baseContentModel = baseViewContentStateModel.header ? baseViewContentStateModel.header : defaultBaseViewContentStateModel.header;
            break;
        }
        case kFooter:
        {
            baseContentModel = baseViewContentStateModel.footer ? baseViewContentStateModel.footer : defaultBaseViewContentStateModel.footer;
            break;
        }
        default:
            break;
    }
    
    if(baseContentModel)
        self.baseContentModel = baseContentModel;
    else if(baseViewContentStateModel)
    {
        baseViewContentStateModel.viewState = kDefault;
        self.baseContentModel = baseViewContentStateModel;
    }
    else
    {
        defaultBaseViewContentStateModel.viewState = kDefault;
        self.baseContentModel = defaultBaseViewContentStateModel;
    }
}

-(NSUInteger)viewState
{
    return self.baseContentModel.viewState;
}

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
        return;
    
    //基本样式
    [self setBaseStyleWithBaseViewContentModel:baseContentModel];
}

-(void)setDefaultBaseContentModel:(MTBaseViewContentModel *)defaultBaseContentModel{objc_setAssociatedObject(self, @selector(defaultBaseContentModel), defaultBaseContentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
-(MTBaseViewContentModel *)defaultBaseContentModel{return objc_getAssociatedObject(self, _cmd);}
-(MTBaseViewContentModel *)baseContentModel
{
    MTBaseViewContentModel * baseContentModel = objc_getAssociatedObject(self, _cmd);
    if(baseContentModel.beDefault)
        return nil;
    return baseContentModel;
}
-(MTBaseViewContentModel*)viewContent{return self.baseContentModel;}
-(MTBaseViewContentModel*)viewStateContent{return self.baseContentModel;}
-(MTBaseViewContentModel*)cellContent{return self.baseContentModel;}
-(MTBaseViewContentModel *)viewVerifyContent{return self.baseContentModel;}

-(MTBaseViewContentModel*)defaultViewContent{return self.defaultBaseContentModel;}
-(MTBaseViewContentModel*)defaultViewStateContent{return self.defaultBaseContentModel;}
-(MTBaseViewContentModel*)defaultCellContent{return self.defaultBaseContentModel;}
-(MTBaseViewContentModel*)defaultViewVerifyContent{return self.defaultBaseContentModel;}

@end

@implementation UILabel (MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
            return;
    
    __block BOOL isModelHidden = false;
    if([self findHiddenModel:baseContentModel For:^(BOOL isHidden) {
        isModelHidden = isHidden;
    }])
        return;
    
    //基本样式
    [self setBaseStyleWithBaseViewContentModel:baseContentModel];
    
    //文字
    [self getWordStyleWithBaseViewContentModel:baseContentModel Completion:^(MTWordStyle *wordStyle) {
        [self setWordWithStyle:wordStyle];
        if(!isModelHidden && ![wordStyle.wordName isExist])
            self.hidden = YES;
    }];
}

@end

@implementation UIImageView(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if([baseContentModel isKindOfClass:NSClassFromString(@"MTImageShowViewContentModel")] && [baseContentModel respondsToSelector:@selector(configImageView:)])
    {
        [baseContentModel performSelector:@selector(configImageView:) withObject:self];
        return;
    }
#pragma clang diagnostic pop
    
    
    [self setBaseModelConfig:baseContentModel];
}

-(void)setBaseModelConfig:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
           return;
       
       [self setBaseStyleWithBaseViewContentModel:baseContentModel];
       
       //图片
        [self findImageModel:baseContentModel For:^(UIImage *image) {
//            if(!baseContentModel.image && image)
//                baseContentModel.image = image;
            self.image = image;
        }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if([self.baseContentModel isKindOfClass:NSClassFromString(@"MTImageShowViewContentModel")] && [self.baseContentModel respondsToSelector:@selector(imageViewTouchesEnded:)])
    {
        [self.baseContentModel performSelector:@selector(imageViewTouchesEnded:) withObject:self];
        return;
    }
#pragma clang diagnostic pop
}

@end


@implementation UIButton(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
        return;
    
    //设置当前的状态
    NSInteger viewState = kDefault;
    if(baseContentModel.viewState != kDefault)
        viewState = baseContentModel.viewState;
    else if([baseContentModel valueForKey:@"associatedDefaultModel"] == self.defaultBaseContentModel && self.defaultBaseContentModel.viewState != kDefault)
        viewState = self.defaultBaseContentModel.viewState;
        
//    if([self.superview isKindOfClass:NSClassFromString(@"QXOrderTwoButtonView")])
//        NSLog(@"asdasd");
    
    MTBaseViewContentModel* highlightedModel = [self whenGetViewState:kHighlighted ForModel:baseContentModel];
    MTBaseViewContentModel* disabledModel = [self whenGetViewState:kDisabled ForModel:baseContentModel];
    MTBaseViewContentModel* selectedModel = [self whenGetViewState:kSelected ForModel:baseContentModel];
    
    MTBaseViewContentModel* currentModel;
    switch (viewState) {
        case kHighlighted:
        {
            currentModel = highlightedModel;
            break;
        }
        case kDisabled:
        {
            currentModel = disabledModel;
            break;
        }
        case kSelected:
        case kSelectedForever:
        {
            currentModel = selectedModel;
            break;
        }
            
        default:
            break;
    }
    if(!currentModel)
        currentModel = baseContentModel;
    
    //基本样式
    [self setBaseStyleWithBaseViewContentModel:currentModel];
    
    //内边距
    [self findPaddingModel:currentModel For:^(UIEdgeInsets contentEdgeInsets) {
        self.contentEdgeInsets = contentEdgeInsets;
    }];
    
    //垂直对齐
    [self findVerticalAlignmentModel:currentModel];
    
    //水平对齐
    [self findHorizontalAlignmentModel:currentModel];
    
    //取消高亮
    [self findNoHighLightModel:currentModel];
    
    //设置各种状态
    UIControlState state = UIControlStateNormal;
    if(currentModel != baseContentModel)
        [self setButtonState:UIControlStateNormal forModel:baseContentModel];
    else
        state = UIControlStateNormal;
    
    if(highlightedModel && highlightedModel != baseContentModel)
    {
        if(currentModel != highlightedModel)
            [self setButtonState:UIControlStateHighlighted forModel:highlightedModel];
        else
            state = UIControlStateHighlighted;
    }
            
    if(disabledModel && disabledModel != baseContentModel)
    {
        if(currentModel != disabledModel)
            [self setButtonState:UIControlStateDisabled forModel:disabledModel];
        else
            state = UIControlStateDisabled;
    }
        
    if(selectedModel && selectedModel != baseContentModel)
    {
        if(currentModel != selectedModel)
            [self setButtonState:UIControlStateSelected forModel:selectedModel];
        else
            state = UIControlStateSelected;
    }
        
    [self setButtonState:state forModel:currentModel];
        
    self.viewState = viewState;
}

-(void)setButtonState:(UIControlState)state forModel:(MTBaseViewContentModel*)model
{
    [self findImageModel:model For:^(UIImage *image) {
        if(!model.image && image && !model.beDefault)        
            model.image = image;
          [self  setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:state];
    }];
         
    [self findBackgroundImageModel:model For:^(UIImage *image) {
        if(!model.image_bg && image)
            model.image_bg = image;
        [self  setBackgroundImage:image  forState:state];
    }];
     
    [self getWordStyleWithBaseViewContentModel:model Completion:^(MTWordStyle *wordStyle) {
       
        [self setWordWithStyle:wordStyle State:state];
    }];
}

//垂直对齐方式
-(void)findVerticalAlignmentModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* verticalAlignmentModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchVerticalAlignment" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.verticalAlignment && model.verticalAlignment)
            baseViewContentModel.verticalAlignment = model.verticalAlignment;
        return model.verticalAlignment != nil;
    }];
    
    if(verticalAlignmentModel.verticalAlignment)
        self.contentVerticalAlignment = verticalAlignmentModel.verticalAlignment.integerValue;
}

//水平对齐方式
-(void)findHorizontalAlignmentModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* horizontalAlignmentModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchHorizontalAlignment" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.horizontalAlignment && model.horizontalAlignment)
            baseViewContentModel.horizontalAlignment = model.horizontalAlignment;
        return model.horizontalAlignment != nil;
    }];
    
    if(horizontalAlignmentModel.horizontalAlignment)
        self.contentHorizontalAlignment = horizontalAlignmentModel.horizontalAlignment.integerValue;
}

//是否高亮
-(void)findNoHighLightModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* noHighLightModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchNoHighLight" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.noHighLight && model.noHighLight)
            baseViewContentModel.noHighLight = model.noHighLight;
        return model.noHighLight != nil;
    }];
    
    if(noHighLightModel.noHighLight.boolValue)
       [self noHighLight];
}



-(void)setViewState:(NSUInteger)viewState
{
    self.bindEnum(viewState);
}

-(void)setMt_tag:(NSInteger)mt_tag
{
    [super setMt_tag:mt_tag];
            
    self.selected = mt_tag == kSelected || mt_tag == kSelectedForever;
    self.highlighted = mt_tag == kHighlighted;
    self.enabled = mt_tag != kDisabled;
}

@end


@implementation UITextField(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
        return;
    
    //基本样式
    [self setBaseStyleWithBaseViewContentModel:baseContentModel];
        
    // 文字
    [self getWordStyleWithBaseViewContentModel:baseContentModel Completion:^(MTWordStyle *wordStyle) {
        [self setWordWithStyle:wordStyle];
    }];
    
    // clearButtonModel
    [self findClearButtonModel:baseContentModel];
    
    // 键盘类型
    [self findKeyboardTypeModel:baseContentModel For:^(UIKeyboardType keyboardType) {
        self.keyboardType = keyboardType;
    }];
       
    //确定按钮类型
    [self findReturnKeyTypeModel:baseContentModel For:^(UIReturnKeyType returnKeyType) {
        self.returnKeyType = returnKeyType;
    }];
    
    // 设置 placeholder
    [self setPlaceholderForModel:baseContentModel];
}

//清除按钮模式
-(void)findClearButtonModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* clearButtonModel = [self findBaseViewContentModel:baseViewContentModel Key:@"isNoMatchClearButtonMode" For:^BOOL(MTBaseViewContentModel *model) {
        if(!baseViewContentModel.clearButtonMode && model.clearButtonMode)
            baseViewContentModel.clearButtonMode = model.clearButtonMode;
        return model.clearButtonMode != nil;
    }];
    
    if(clearButtonModel.clearButtonMode)
        self.clearButtonMode = clearButtonModel.clearButtonMode.integerValue;
}

// setPlaceholder
-(void)setPlaceholderForModel:(MTBaseViewContentModel*)baseViewContentModel
{
    MTBaseViewContentModel* placeholderModel = [self whenGetViewState:kPlaceholder ForModel:baseViewContentModel];
    if(placeholderModel == baseViewContentModel)
        return;
        
    [self getWordStyleWithBaseViewContentModel:placeholderModel Completion:^(MTWordStyle *wordStyle) {
        
        if(wordStyle.isMake)
            self.attributedPlaceholder = wordStyle.attributedWordName;
        else
            self.placeholder = wordStyle.wordName;
    }];
}

@end


@implementation UITextView(MTBaseViewContentModel)

-(void)setBaseContentModel:(MTBaseViewContentModel *)baseContentModel
{
    if([self checkBaseViewContentModel:baseContentModel])
        return;
        
    //基本样式
    [self setBaseStyleWithBaseViewContentModel:baseContentModel];
    
    //文字
    [self getWordStyleWithBaseViewContentModel:baseContentModel Completion:^(MTWordStyle *wordStyle) {
        [self setWordWithStyle:wordStyle];
    }];
    
    //内边距
    [self findPaddingModel:baseContentModel For:^(UIEdgeInsets contentEdgeInsets) {
        self.textContainerInset = contentEdgeInsets;
    }];
    
    // 键盘类型
    [self findKeyboardTypeModel:baseContentModel For:^(UIKeyboardType keyboardType) {
        self.keyboardType = keyboardType;
    }];
        
    //确定按钮类型
    [self findReturnKeyTypeModel:baseContentModel For:^(UIReturnKeyType returnKeyType) {
        self.returnKeyType = returnKeyType;
    }];
    
    // 设置 placeholder
    [self setPlaceholderForModel:baseContentModel];
}

// setPlaceholder
-(void)setPlaceholderForModel:(MTBaseViewContentModel*)baseViewContentModel
{
    if(![self isKindOfClass:NSClassFromString(@"MTTextView")])
        return;
    UILabel* placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    MTBaseViewContentModel* placeholderModel = [self whenGetViewState:kPlaceholder ForModel:baseViewContentModel];
    if(placeholderModel == baseViewContentModel)
    {
        placeholderLabel.hidden = [self.text isExist];
        return;
    }
                
    [self getWordStyleWithBaseViewContentModel:placeholderModel Completion:^(MTWordStyle *wordStyle) {
        [placeholderLabel setWordWithStyle:wordStyle];
        placeholderLabel.hidden = [self.text isExist];
    }];
}

@end
