//
//  MTBorderStyle.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/9.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTBorderStyle;
typedef MTBorderStyle* (^Corners)(UIRectCorner borderCorners);
typedef MTBorderStyle* (^Weak)(BOOL borderWeak);
typedef MTBorderStyle* (^Fill)(UIColor* fillColor);
typedef MTBorderStyle* (^MasksToBounds)(void);
typedef MTBorderStyle* (^ViewSize)(CGFloat viewWidth, CGFloat viewHeight);

@interface MTBorderStyle : NSObject

@property(nonatomic,assign) CGFloat borderWidth;
@property(nonatomic,assign) CGFloat borderRadius;
@property(nonatomic,strong) UIColor* borderColor;
@property(nonatomic,strong) UIColor* fillColor;
@property (nonatomic,assign) BOOL borderWeak;
@property(nonatomic,assign) UIRectCorner borderCorners;
@property(nonatomic,assign) BOOL borderMasksToBounds;
@property(nonatomic,assign) CGSize borderViewSize;

@property (nonatomic,copy,readonly)  Corners corners;
@property (nonatomic,copy,readonly)  Weak weak;
@property (nonatomic,copy,readonly)  Fill fill;
@property (nonatomic,copy,readonly)  MasksToBounds masksToBounds;
@property (nonatomic,copy,readonly)  ViewSize viewSize;


@end

CG_EXTERN MTBorderStyle* mt_BorderStyleMake(CGFloat borderWidth, CGFloat borderRadius,UIColor* borderColor);


@interface MTShadowStyle : NSObject

@property(nonatomic,strong) UIColor* shadowColor;

@property(nonatomic,assign) CGFloat shadowOpacity;

@property(nonatomic,assign) CGSize shadowOffset;

@property(nonatomic,assign) CGFloat shadowRadius;

@end

CG_EXTERN MTShadowStyle* mt_ShadowStyleMake(CGFloat shadowOpacity, CGFloat shadowRadius, UIColor* shadowColor, CGSize shadowOffset);


@interface MTJianBianStyle : NSObject

@property(nonatomic,assign) CGSize viewSize;

@property(nonatomic,strong) UIColor* startColor;
@property(nonatomic,strong) UIColor* endColor;

@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic,assign) CGPoint endPoint;


-(void)setBackgroundColor:(UIView*)view;

@end

CG_EXTERN MTJianBianStyle* mt_jianBianStyleMake(UIColor* startColor, UIColor* endColor, CGPoint startPoint, CGPoint endPoint, CGSize viewSize);
