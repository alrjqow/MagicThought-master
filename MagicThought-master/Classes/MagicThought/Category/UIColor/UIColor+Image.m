//
//  UIColor+Image.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)

- (UIImage *) changeToImage
{
    return  [self changeToImageWithSize:CGSizeMake(4.0f, 4.0f)];
}

- (UIImage *) changeToImageWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [self stretchedImage:image];
}


- (UIImage *) stretchedImage:(UIImage*)image
{
    CGSize size = image.size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    
    return [image resizableImageWithCapInsets:insets];
}


@end
