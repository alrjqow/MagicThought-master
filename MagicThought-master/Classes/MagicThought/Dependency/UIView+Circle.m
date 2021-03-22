//
//  UIView+Circle.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "UIView+Circle.h"
#import "MTConst.h"
#import "objc/runtime.h"

@implementation MTWeakLine

-(void)drawRect:(CGRect)rect
{
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, hex(0x666666).CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, 0, 0);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    
    if(!self.lineWidth)
        self.lineWidth = 2;
    if(!self.lineMargin)
        self.lineMargin = 2;
    CGFloat lengths[] = {self.lineWidth,self.lineMargin};
    
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect),0.0);
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
}

@end

@interface UIView()

@property (nonatomic,strong) CAShapeLayer* maskLayer;

@property (nonatomic,strong) CAShapeLayer* borderLayer;

@property (nonatomic,strong) MTBorderStyle* borderStyle;

@end

@implementation UIView (Circle)

-(void)setBorderLayer:(CAShapeLayer *)borderLayer
{
    objc_setAssociatedObject(self, @selector(borderLayer), borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *)borderLayer
{
    CAShapeLayer* borderLayer = objc_getAssociatedObject(self, _cmd);
    if(!borderLayer)
    {
        borderLayer = [CAShapeLayer layer];
        self.borderLayer = borderLayer;
    }
    return borderLayer;
}

-(void)setMaskLayer:(CAShapeLayer *)maskLayer
{
    objc_setAssociatedObject(self, @selector(maskLayer), maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *)maskLayer
{
    CAShapeLayer* maskLayer = objc_getAssociatedObject(self, _cmd);
    if(!maskLayer)
    {
        maskLayer = [CAShapeLayer layer];
        self.maskLayer = maskLayer;
    }
    return maskLayer;
}

-(void)setBorderStyle:(MTBorderStyle *)borderStyle
{
    objc_setAssociatedObject(self, @selector(borderStyle), borderStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MTBorderStyle *)borderStyle
{
    MTBorderStyle* borderStyle = objc_getAssociatedObject(self, _cmd);
    if(!borderStyle)
    {
        borderStyle = [MTBorderStyle new];
        self.borderStyle = borderStyle;
    }
    return borderStyle;
}

-(instancetype)becomeCircleWithBorder:(MTBorderStyle*) border
{
    if([self isKindOfClass:NSClassFromString(@"MTBaseHeaderFooterView")])
        return self;
    
    if((border.borderCorners == UIRectCornerAllCorners) && !border.borderWeak)
    {
        self.layer.cornerRadius = border.borderRadius;
        self.layer.borderColor = border.borderColor.CGColor;
        self.layer.borderWidth = border.borderWidth;
    }
    else
    {
        //                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
        
        //            maskLayer.lineCap = @"square";
        
        CGRect rect;
        if(border.borderViewSize.width &&  border.borderViewSize.height)
            rect = CGRectMake(0, 0, border.borderViewSize.width, border.borderViewSize.height);
        else
            rect = self.bounds;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners: border.borderCorners cornerRadii:CGSizeMake(border.borderRadius, border.borderRadius)];        
        self.maskLayer.frame = rect;
        self.maskLayer.fillColor = border.fillColor.CGColor;
        //        maskLayer.fillColor = [UIColor redColor].CGColor;
        //        maskLayer.strokeColor = [UIColor redColor].CGColor;
        //        maskLayer.lineWidth = 1;
        self.maskLayer.strokeColor = border.borderColor.CGColor;
        self.maskLayer.lineWidth = border.borderWidth;
        if(border.borderWeak)
        {
            self.maskLayer.lineCap = @"square";
            self.maskLayer.lineDashPattern = @[@4, @2];
        }
        
        self.maskLayer.path = maskPath.CGPath;
        
        if([self isKindOfClass:[UILabel class]])
            self.layer.mask = self.maskLayer;
        else
        {
            self.layer.backgroundColor = nil;
            self.backgroundColor = nil;
            [self.layer insertSublayer:self.maskLayer atIndex:0];
        }
    }
    
    if(border.borderMasksToBounds || [self isKindOfClass:[UIImageView class]])
        self.layer.masksToBounds = YES;
    
    return self;
}

-(instancetype)becomeShadow:(MTShadowStyle*)shadowStyle
{
    self.layer.shadowColor = shadowStyle.shadowColor.CGColor;
    self.layer.shadowOpacity = shadowStyle.shadowOpacity;
    self.layer.shadowOffset = shadowStyle.shadowOffset;
    self.layer.shadowRadius = shadowStyle.shadowRadius;
    
    return self;
}

@end

#import <Accelerate/Accelerate.h>

@implementation UIImage (Circle)

-(UIImage*)getImageWithBorder:(MTBorderStyle*)border
{
    CGSize size;
    if(border.borderViewSize.width > 0 && border.borderViewSize.height > 0)
        size = border.borderViewSize;
    else
        size = CGSizeMake(self.size.width + doubles(border.borderWidth), self.size.height + doubles(border.borderWidth));
    
    CGSize imageSize = CGSizeMake(size.width - doubles(border.borderWidth), size.height - doubles(border.borderWidth));
    
    UIImage* image;
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    
    UIBezierPath *path;
    if(border.borderWidth && border.borderColor)
    {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners: border.borderCorners cornerRadii:CGSizeMake(border.borderRadius, border.borderRadius)];
        [border.borderColor set];
        [path fill];
    }
    
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(border.borderWidth, border.borderWidth, imageSize.width, imageSize.height) byRoundingCorners: border.borderCorners cornerRadii:CGSizeMake(border.borderRadius, border.borderRadius)];
    [path addClip];
    
    [self drawInRect:CGRectMake(border.borderWidth, border.borderWidth, imageSize.width, imageSize.height)];
    
    //从上下文生成的图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)boxblurImageWithBlurNumber:(CGFloat)blur {
   if (blur < 0.f || blur > 1.f) {
      blur = 0.5f;
   }
   int boxSize = (int)(blur * 40);
   boxSize = boxSize - (boxSize % 2) + 1;
   CGImageRef img = self.CGImage;
   vImage_Buffer inBuffer, outBuffer;
   vImage_Error error;
   void *pixelBuffer;

//从CGImage中获取数据
   CGDataProviderRef inProvider = CGImageGetDataProvider(img);
   CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

//设置从CGImage获取对象的属性
   inBuffer.width = CGImageGetWidth(img);
   inBuffer.height = CGImageGetHeight(img);
   inBuffer.rowBytes = CGImageGetBytesPerRow(img);
   inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
   pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
   CGImageGetHeight(img));
   if(pixelBuffer == NULL)
   NSLog(@"No pixelbuffer");
   outBuffer.data = pixelBuffer;
   outBuffer.width = CGImageGetWidth(img);
   outBuffer.height = CGImageGetHeight(img);
   outBuffer.rowBytes = CGImageGetBytesPerRow(img);
   error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
   if (error) {
      NSLog(@"error from convolution %ld", error);
   }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
   CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
   UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

   CGContextRelease(ctx);
   CGColorSpaceRelease(colorSpace);
   free(pixelBuffer);
   CFRelease(inBitmapData);
   CGColorSpaceRelease(colorSpace);
   CGImageRelease(imageRef);
   return returnImage;
}

@end
