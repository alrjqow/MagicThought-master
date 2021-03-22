//
//  UIImage+MTCircleImage.m
//  修改图片边框
//
//  Created by 王奕聪 on 2016/11/21.
//  Copyright © 2016年 王奕聪. All rights reserved.
//

#import "UIImage+MTCircleImage.h"
#import "MTBorderStyle.h"

@implementation UIImage (MTCircleImage)

-(UIImage*)roundCornerimageWithBorderStyle:(MTBorderStyle*)border
{
    return  [self roundCornerimageWithBorderStyle:border WithSpacing:0];
}

//基本：设置边框的线宽，边框颜色，以及边框圆角大小
-(UIImage*)roundCornerimageWithBorderStyle:(MTBorderStyle*)border WithSpacing:(NSInteger)spacing
{
    if(!border) return self;
    UIImage* image;
    
    
    CGSize size = CGSizeMake(self.size.width + 2 * border.borderWidth + spacing, self.size.height + 2 * border.borderWidth + spacing);
    
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    
    //画圆角矩形(边框)
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(spacing, spacing, size.width - 2 * spacing, size.height - 2 * spacing) cornerRadius:border.borderRadius];
    [border.borderColor set];
    [path fill];
    
    //裁剪区域
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(spacing + border.borderWidth, spacing + border.borderWidth, self.size.width - spacing, self.size.height - spacing) cornerRadius:border.borderRadius];
    [path addClip];
    
    [self drawAtPoint:CGPointMake(spacing * 0.5, spacing * 0.5) blendMode:kCGBlendModeNormal alpha:1];
    
    //从上下文生成的图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
