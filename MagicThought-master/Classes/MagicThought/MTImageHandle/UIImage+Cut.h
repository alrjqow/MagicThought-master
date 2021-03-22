//
//  UIImage+Cut.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/17.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)

-(UIImage*)cutImageWithSaveRect:(CGRect)rect;

/**解决图片旋转的问题*/
- (UIImage *)fixOrientation;

/** 按指定方向旋转图片 */
- (UIImage *)fixOrientationWithOrientation:(UIImageOrientation)orientation;

@end
