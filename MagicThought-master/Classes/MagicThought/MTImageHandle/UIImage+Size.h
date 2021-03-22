//
//  UIImage+Size.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

//改变图片尺寸
-(UIImage*)changeToSize:(CGSize)size;

/**根据尺寸修改宽度*/
-(UIImage*)changeSizeAccordingToWidth:(CGFloat)width;

/**根据尺寸修改宽度为屏幕宽度，若为横屏，则高度等于屏幕宽度*/
-(UIImage*)changeSizeAccordingToScreenWidth;

/**中间不拉伸，两边拉伸*/
- (UIImage *)changeToWidthWiithHorizontalStretchExceptCenter:(NSInteger)width;

@end
