//
//  UIColor+ColorfulColor.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTBorderStyle;
@interface UIColor (ColorfulColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+(UIColor*)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;
+(UIColor*)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

+(UIColor*)colorWithHex:(NSUInteger)hex;
+(UIColor*)colorWithHex:(NSUInteger)hex WithAlpha:(CGFloat)a;

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;

+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent;

@end


@interface UIView (ColorfulColor)



/**默认线性角度为中线*/
-(void)createJianBianBackgroundColorWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor;

/**自行调整线性角度*/
-(void)createJianBianBackgroundColorWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**生成渐变图片,默认线性角度为中线*/
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor;
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor Size:(CGSize)size;
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor BorderStyle:(MTBorderStyle*)borderStyle;

/**生成渐变图片,自行调整线性角度*/
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Size:(CGSize)size;
-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint BorderStyle:(MTBorderStyle*)borderStyle;

@end
