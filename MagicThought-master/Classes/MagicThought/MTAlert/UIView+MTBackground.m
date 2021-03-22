//
//  UIView+MTBackground.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "UIView+MTBackground.h"
#import <objc/runtime.h>
#import "MTConst.h"
#import "MTWindow.h"
#import "NSObject+ReuseIdentifier.h"

@interface UIView (ReferenceCount)

@property (nonatomic, assign, readwrite) NSInteger mt_dimReferenceCount;

@end

@implementation UIView (ReferenceCount)

-(NSInteger)mt_dimReferenceCount{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
-(void)setMt_dimReferenceCount:(NSInteger)mt_dimReferenceCount
{
    objc_setAssociatedObject(self, @selector(mt_dimReferenceCount), @(mt_dimReferenceCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIView (MTBackground)

- (void) showBackground
{
    ++self.mt_dimReferenceCount;
    
    if ( self.mt_dimReferenceCount > 1 )
    {
        return;
    }
    
    self.mt_BackgroundView.hidden = NO;
    self.mt_BackgroundAnimating = YES;
    
    if ( self == [MTWindow sharedWindow].attachView )
    {
        [MTWindow sharedWindow].hidden = NO;
        [[MTWindow sharedWindow] makeKeyAndVisible];
    }
    else if ( [self isKindOfClass:[UIWindow class]] )
    {
        self.hidden = NO;
        [(UIWindow*)self makeKeyAndVisible];
    }
    else
    {
        [self bringSubviewToFront:self.mt_BackgroundView];
    }
    
    [UIView animateWithDuration:self.mt_AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut |UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.mt_BackgroundView.alpha = 1.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         if ( finished )
                         {
                             self.mt_BackgroundAnimating = NO;
                         }
                         
                     }];
}

- (void) hideBackground
{
    --self.mt_dimReferenceCount;
    
    if ( self.mt_dimReferenceCount > 0 )
    {
        return;
    }
    
    self.mt_BackgroundAnimating = YES;
    [UIView animateWithDuration:self.mt_AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
                         
                         self.mt_BackgroundView.alpha = 0.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         if ( finished )
                         {
                             self.mt_BackgroundAnimating = NO;
                             
                             if ( self == [MTWindow sharedWindow].attachView )
                             {
                                 [MTWindow sharedWindow].hidden = YES;
                                 [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
                             }
                             else if ( self == [MTWindow sharedWindow] )
                             {
                                 self.hidden = YES;
                                 [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
                             }
                         }
                     }];
}

-(UIView *)mt_BackgroundView
{
    UIView *dimView = objc_getAssociatedObject(self, _cmd);
    
    if ( !dimView )
    {
        dimView = [UIView new];
        [self addSubview:dimView];
        dimView.frame = self.bounds;
        dimView.alpha = 0.0f;
        dimView.backgroundColor = rgba(0, 0, 0, 0.48);
        dimView.layer.zPosition = FLT_MAX;
        
        UITapGestureRecognizer* tap = [UITapGestureRecognizer new];
        [tap addTarget:self action:@selector(tapClick:)];
        [dimView addGestureRecognizer:tap];
        self.mt_AnimationDuration = 0.3f;
        
        objc_setAssociatedObject(self, _cmd, dimView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dimView;
}
-(void)tapClick:(UITapGestureRecognizer*)tap
{
    if(self.mt_BackgroundView.mt_click)
        self.mt_BackgroundView.mt_click(tap);
}

-(void)setMt_AnimationDuration:(NSTimeInterval)mt_AnimationDuration
{
     objc_setAssociatedObject(self, @selector(mt_AnimationDuration), @(mt_AnimationDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSTimeInterval)mt_AnimationDuration
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}


-(void)setMt_BackgroundAnimating:(BOOL)mt_BackgroundAnimating
{
    objc_setAssociatedObject(self, @selector(mt_BackgroundAnimating), @(mt_BackgroundAnimating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)mt_BackgroundAnimating
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
