//
//  CyhImageCutview.h
//  CyhHImageCut
//
//  Created by 陈海哥 on 2017/8/23.
//  Copyright © 2017年 陈海哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyhImageCutview : UIView

@property (nonatomic,assign) CGFloat whScale;

- (instancetype)setView_cutViewWithImage:(UIImage *)Oimage addSuperclassView:(UIView *)Spview PinScale:(CGFloat)PinScale complet:(void (^)(UIImage * Cutimage))resultComplet;

- (void)sureCutImage;

@end
