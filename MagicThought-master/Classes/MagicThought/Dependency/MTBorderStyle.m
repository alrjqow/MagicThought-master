//
//  MTBorderStyle.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/9.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTBorderStyle.h"
#import "MJExtension.h"


@implementation MTBorderStyle

+(NSArray *)mj_ignoredPropertyNames
{
    return @[@"corners", @"weak", @"fill", @"masksToBounds", @"viewSize"];
}

-(ViewSize)viewSize
{
    __weak __typeof(self) weakSelf = self;
       ViewSize viewSize = ^(CGFloat viewWidth, CGFloat viewHeight){
                      
           weakSelf.borderViewSize = CGSizeMake(viewWidth, viewHeight);
           return weakSelf;
       };
       
       return viewSize;
}

-(Corners)corners
{
    __weak __typeof(self) weakSelf = self;
    Corners corners = ^(UIRectCorner borderCorners){
        
        weakSelf.borderCorners = borderCorners;
        return weakSelf;
    };
    
    return corners;
}

-(Weak)weak
{
    __weak __typeof(self) weakSelf = self;
    Weak weak = ^(BOOL borderWeak){
        
        weakSelf.borderWeak = borderWeak;
        return weakSelf;
    };
    
    return weak;
}

-(Fill)fill
{
    __weak __typeof(self) weakSelf = self;
    Fill fill = ^(UIColor* fillColor){
        
        weakSelf.fillColor = fillColor;
        return weakSelf;
    };
    
    return fill;
}

-(MasksToBounds)masksToBounds
{
    __weak __typeof(self) weakSelf = self;
      MasksToBounds masksToBounds = ^{
          
          weakSelf.borderMasksToBounds = YES;
          return weakSelf;
      };
      
      return masksToBounds;
}

-(instancetype)init
{
    if(self = [super init])
    {
        self.borderCorners = UIRectCornerAllCorners;        
    }
    
    return self;
}

MTBorderStyle* mt_BorderStyleMake(CGFloat borderWidth, CGFloat borderRadius,UIColor* borderColor)
{
    MTBorderStyle* border = [MTBorderStyle new];
    border.borderWidth = borderWidth;
    border.borderRadius = borderRadius;
    border.borderColor = borderColor;
    
    return border;
}

@end


@implementation MTShadowStyle

MTShadowStyle* mt_ShadowStyleMake(CGFloat shadowOpacity, CGFloat shadowRadius, UIColor* shadowColor, CGSize shadowOffset)
{
    MTShadowStyle* shadowStyle = [MTShadowStyle new];
    shadowStyle.shadowOpacity = shadowOpacity;
    shadowStyle.shadowRadius = shadowRadius;
    shadowStyle.shadowColor = shadowColor;
    shadowStyle.shadowOffset = shadowOffset;
    
    return shadowStyle;
}

@end



@implementation MTJianBianStyle

-(void)setBackgroundColor:(UIView *)view
{
    if(!self.startColor && !self.endColor)
        return;
    
    CGSize size;
     if(self.viewSize.width && self.viewSize.height)
         size = self.viewSize;
     else
         size = view.bounds.size;
    
    if(!size.width || !size.height)
        return;
            
    CGPoint startPoint = self.startPoint;
    CGPoint endPoint = self.endPoint;
    if(CGPointEqualToPoint(startPoint, endPoint))
        return;
        
    // 防止重复添加
    CALayer *tempLayer = view.layer.sublayers.firstObject;
    if ([tempLayer isMemberOfClass:[CAGradientLayer class]]) {
        [tempLayer removeFromSuperlayer];
    }

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)(self.startColor ? self.startColor.CGColor : self.endColor.CGColor),
                            (id)(self.endColor ? self.endColor.CGColor :  self.startColor.CGColor),
                          nil];

    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
     
    gradientLayer.locations = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0f],
                             [NSNumber numberWithFloat:1.0f],
                             nil];

    [view.layer insertSublayer:gradientLayer atIndex:0];
}


MTJianBianStyle* mt_jianBianStyleMake(UIColor* startColor, UIColor* endColor, CGPoint startPoint, CGPoint endPoint, CGSize viewSize)
{
    MTJianBianStyle* jianBianStyle = MTJianBianStyle.new;
    jianBianStyle.startColor = startColor;
    jianBianStyle.endColor = endColor;
    jianBianStyle.startPoint = startPoint;
    jianBianStyle.endPoint = endPoint;
    jianBianStyle.viewSize = viewSize;
    
    return jianBianStyle;
}

@end
