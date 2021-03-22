//
//  UIView+MTBackground.h
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTBackground)

@property (nonatomic, strong, readonly ) UIView *mt_BackgroundView;
@property (nonatomic, assign, readonly ) BOOL mt_BackgroundAnimating;
@property (nonatomic, assign) NSTimeInterval mt_AnimationDuration;

- (void) showBackground;

- (void) hideBackground;

@end
