//
//  UIImage+MTLockNodeImage.h
//  修改图片边框
//
//  Created by 王奕聪 on 2016/11/21.
//  Copyright © 2016年 王奕聪. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MTBorderStyle;
//用来处理图片圆角
@interface UIImage (MTLockNodeImage)

-(UIImage*)roundCornerimageWithBorderStyle:(MTBorderStyle*)border WithSpacing:(NSInteger)spacing;

-(UIImage*)roundCornerimageWithBorderStyle:(MTBorderStyle*)border;


@end
