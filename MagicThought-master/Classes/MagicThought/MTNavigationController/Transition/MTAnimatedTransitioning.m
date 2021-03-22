//
//  MTAnimatedTransitioning.m
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTAnimatedTransitioning.h"
#import "MTInteractiveNavigationDelegate.h"

@implementation MTAnimatedTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

-(void)panAction:(UIPanGestureRecognizer *)gesture InteractiveNavigationDelegate:(MTInteractiveNavigationDelegate *)delegate
{
    
}

-(void)cancelInteractiveTransition:(MTInteractiveNavigationDelegate *)delegate
{
    [delegate cancelInteractiveTransition];
}

-(void)finishInteractiveTransition:(MTInteractiveNavigationDelegate *)delegate
{
    [delegate finishInteractiveTransition];
}

@end

@implementation MTAnimatedTransitioningPush



@end

@implementation MTAnimatedTransitioningPop


@end
