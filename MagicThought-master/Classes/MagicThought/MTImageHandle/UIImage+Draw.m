//
//  UIImage+Draw.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/17.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "UIImage+Draw.h"
#import "MTConst.h"

@implementation UIImage (Draw)

-(UIImage*)drawFullScreenInRect:(CGRect)rect
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGSize imgSize = CGSizeMake(mt_ScreenW(), mt_ScreenW() * self.size.height / self.size.width);
    
//    NSLog(@"%@----%@",NSStringFromCGSize(size),NSStringFromCGSize(self.size));
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        
    [self drawInRect:CGRectMake(0, (size.height - imgSize.height) * 0.5, imgSize.width, imgSize.height)];
    
    //从上下文生成的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
