//
//  MTLoadingView.m
//  SimpleProject
//
//  Created by monda on 2019/5/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTLoadingView.h"

@interface MTLoadingView ()

@property (nonatomic,strong) CABasicAnimation* animation;

@end

@implementation MTLoadingView

-(void)setupDefault
{
    [super setupDefault];
    
    [self.imageView.layer addAnimation:self.animation forKey:@"loading"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    self.imageView.centerX = self.centerX;
    
    [self.textLabel sizeToFit];
    self.textLabel.centerX = self.imageView.centerX;
    
    CGFloat totalHeight = self.imageView.height  + self.textLabel.height + 18;
    CGFloat halfHeight = totalHeight * 0.5;
    
    CGFloat centerY = self.centerLayoutY ? self.centerLayoutY : self.centerY;
    
    self.imageView.y = centerY - halfHeight;
    self.textLabel.centerY = self.imageView.maxY + 18 + self.textLabel.halfHeight;
}

-(CABasicAnimation *)animation
{
    if(!_animation)
    {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        //逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  @(M_PI*2);
        animation.duration  = 0.8;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //一直自旋转
        animation.removedOnCompletion = NO;
        
        _animation = animation;
    }
    
    return _animation;
}


@end
