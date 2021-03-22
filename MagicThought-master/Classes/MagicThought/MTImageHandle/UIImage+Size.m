//
//  UIImage+Size.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "UIImage+Size.h"
#import "MTConst.h"

@implementation UIImage (Size)

-(UIImage*)changeSizeAccordingToWidth:(CGFloat)width
{
    NSInteger w = width;
    NSInteger h;
    
    CGSize size = self.size;
    
    if(size.width > size.height)
        w = size.width * w / size.height;
    
    
    h = size.height * w / size.width;
    
    return [self changeToSize:CGSizeMake(w, h)];
}

/**修改尺寸为宽度等于屏幕宽度，若为横屏，则高度等于屏幕宽度*/
-(UIImage*)changeSizeAccordingToScreenWidth
{
    return [self changeSizeAccordingToWidth:mt_ScreenW()];
}

-(UIImage*)changeToSize:(CGSize)size
{
    UIGraphicsBeginImageContext (size);
    
    [self drawInRect : CGRectMake (0, 0, size.width, size.height)];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return [newImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)changeToWidthWiithHorizontalStretchExceptCenter:(NSInteger)width {
            
    UIImage *image = [self resizableImageWithCapInsets:UIEdgeInsetsMake(0, (NSInteger)(self.size.width * 0.7), 0, (NSInteger)(self.size.width * 0.2))];
    
    NSInteger tempWidth = self.size.width + (width - self.size.width)/2;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, (NSInteger)self.size.height), NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, tempWidth, self.size.height)];
        
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, (NSInteger)(image.size.width * 0.2), 0, (NSInteger)(image.size.width * 0.7))];

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, (NSInteger)self.size.height), NO, [UIScreen mainScreen].scale);

    [image drawInRect:CGRectMake(0, 0, width, self.size.height)];

    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    return image;
}

@end
