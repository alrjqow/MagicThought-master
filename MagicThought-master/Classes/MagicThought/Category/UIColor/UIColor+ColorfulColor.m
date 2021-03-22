//
//  UIColor+ColorfulColor.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "UIColor+ColorfulColor.h"
#import "MTBorderStyle.h"
#import "MTConst.h"

@implementation UIColor (ColorfulColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

   if ([cString length] < 6) {
       return [UIColor colorWithHex:0x2e2e2e];
   }

   if ([cString hasPrefix:@"0X"])
       cString = [cString substringFromIndex:2];

   if ([cString hasPrefix:@"#"])
       cString = [cString substringFromIndex:1];

   if ([cString length] != 6)
       return [UIColor colorWithHex:0x2e2e2e];

   NSScanner *scanner = [NSScanner scannerWithString:cString];

   unsigned hexNum;
   if (![scanner scanHexInt:&hexNum]) return nil;
   
    return [UIColor colorWithHex:hexNum];
}

+(UIColor*)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue
{
    return [self colorWithR:red G:green B:blue A:1.0];
}


+(UIColor*)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [self colorWithRed: 1.0*(red)/255 green:1.0*(green)/255 blue:1.0*(blue)/255 alpha:alpha];
}

+(UIColor*)colorWithHex:(NSUInteger)hex
{
    return [self colorWithHex:hex WithAlpha:1.0];
}

+(UIColor*)colorWithHex:(NSUInteger)hex WithAlpha:(CGFloat)a
{
    return  [self colorWithRed:(((hex) & 0xFF0000) >> 16) / 255.0 green:(((hex) & 0xFF00) >> 8) / 255.0 blue:((hex) & 0xFF) / 255.0 alpha:a];
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}

+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end



@implementation UIView (ColorfulColor)

-(void)createJianBianBackgroundColorWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor
{    
    [self createJianBianBackgroundColorWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0,CGRectGetMidY(self.bounds)) endPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds))];
}


-(void)createJianBianBackgroundColorWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:startPoint endPoint:endPoint]];
    
    [self insertSubview:imgView atIndex:0];
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor
{
    return [self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0,CGRectGetMidY(self.bounds)) endPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds))];
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor Size:(CGSize)size
{
    return [self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0,half(size.height)) endPoint:CGPointMake(size.width,half(size.height)) Size:size];
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    return [self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:startPoint endPoint:endPoint Size:self.bounds.size];    
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Size:(CGSize)size
{
    return [self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:startPoint endPoint:endPoint BorderStyle:MTBorderStyle.new.viewSize(size.width, size.height)];    
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor BorderStyle:(MTBorderStyle*)borderStyle
{    
    return
    [self createJianBianImageWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0,half(borderStyle.borderViewSize.height)) endPoint:CGPointMake(borderStyle.borderViewSize.width,half(borderStyle.borderViewSize.height)) BorderStyle:borderStyle];
}

-(UIImage*)createJianBianImageWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint BorderStyle:(MTBorderStyle*)borderStyle
{
    CGSize size;
    if(borderStyle.borderViewSize.width && borderStyle.borderViewSize.height)
        size = borderStyle.borderViewSize;
    else
        size = self.bounds.size;
    
    //创建CGContextRef
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
        
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners: borderStyle.borderCorners cornerRadii:CGSizeMake(borderStyle.borderRadius, borderStyle.borderRadius)].CGPath;
    
    //创建CGMutablePathRef
//    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    CGPathAddRect(path, nil, rect);
    
    //警示：原来还有这种玩法
    //    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
//    CGPathCloseSubpath(path);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    //    CGRect pathRect = CGPathGetBoundingBox(path);
    
    
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    
    //注意释放CGMutablePathRef
//    CGPathRelease(path);
    
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end



