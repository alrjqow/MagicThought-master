//
//  MTPopView.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTPopView.h"
#import "MTWindow.h"
#import "UIView+MTBackground.h"
#import "MTPopViewConfig.h"

@implementation MTPopView

-(MTPopViewConfig *)config
{
    if(!_config)
    {
        _config = [MTPopViewConfig new];
    }
    
    return _config;
}

- (void)show
{
    if (!self.attachedView)
        self.attachedView = [MTWindow sharedWindow].attachView;
    
    [self.attachedView showBackground];    
    self.attachedView.mt_BackgroundView.backgroundColor = rgba(0, 0, 0, self.config.backgroundViewAlpha);
    
    [self alertShowAnimation];
}

- (void) hide
{
    if ( !self.attachedView )
    {
        self.attachedView = [MTWindow sharedWindow].attachView;
    }
    [self.attachedView hideBackground];
    
    [self alertHideAnimation];
}

- (void)alertShowAnimation
{
    if (!self.superview)
        [self.attachedView.mt_BackgroundView addSubview:self];    
    
    self.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6);
    self.alpha = 0;
    [UIView animateWithDuration:self.config.animationDuration
                          delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.layer.transform = CATransform3DIdentity;
        self.alpha = 1;
    } completion:nil];    
}

-(void)alertHideAnimation
{
    [UIView animateWithDuration:self.config.animationDuration delay:0 options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{

                        self.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6);
                         self.alpha = 0;
                     } completion:^(BOOL finished) {

                         if ( finished )
                             [self removeFromSuperview];
                     }];
}

@end
