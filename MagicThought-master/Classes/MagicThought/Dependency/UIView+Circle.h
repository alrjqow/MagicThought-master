//
//  UIView+Circle.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBorderStyle.h"

@interface UIView (Circle)

-(instancetype)becomeCircleWithBorder:(MTBorderStyle*)border;

-(instancetype)becomeShadow:(MTShadowStyle*)shadowStyle;

@end

@interface UIImage (Circle)

-(UIImage*)getImageWithBorder:(MTBorderStyle*)border;

-(UIImage *)boxblurImageWithBlurNumber:(CGFloat)blur;

@end

@interface MTWeakLine : UIView

@property (nonatomic,strong) UIColor* lineColor;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,assign) CGFloat lineMargin;

@end

@interface UIView (GradientLayer)

-(void)fillGradientBackgroundColor_CenterTopBottom:(NSArray<UIColor*> *)colors Rect:(CGRect)rect;

-(void)fillGradientBackgroundColor_CenterLeftRight:(NSArray<UIColor*> *)colors Rect:(CGRect)rect;

@end


extern void kSetWeakLine(UIColor* lineColor, CGFloat lineWidth, CGFloat lineMargin, CGPoint startPoint, CGPoint endPoint);


