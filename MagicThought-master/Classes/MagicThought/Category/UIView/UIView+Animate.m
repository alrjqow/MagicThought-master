//
//  UIView+Animate.m
//  手势解锁
//
//  Created by monda on 2018/3/27.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "UIView+Animate.h"

@implementation UIView (Animate)

/**摇动*/
-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 5;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = 0.3f;
    
    //重复
    kfa.repeatCount = 2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self.layer addAnimation:kfa forKey:@"shake"];
}




@end



