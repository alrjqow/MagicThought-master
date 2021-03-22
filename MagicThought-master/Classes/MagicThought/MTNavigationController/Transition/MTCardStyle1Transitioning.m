//
//  MTCardStyle1Transitioning.m
//  DaYiProject
//
//  Created by monda on 2019/1/23.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTCardStyle1Transitioning.h"
#import "MTInteractiveNavigationDelegate.h"

#import "MTNavigationTransitionController.h"

@implementation MTCardStyle1TransitioningPush

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 1.5);
    [transitionContext.containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [UIView animateWithDuration:0.3 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end












@interface MTCardStyle1TransitioningPop ()

@property (nonatomic,assign) BOOL isLeft;

@end

@implementation MTCardStyle1TransitioningPop

-(void)panAction:(UIPanGestureRecognizer *)gesture InteractiveNavigationDelegate:(MTInteractiveNavigationDelegate *)delegate
{
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [delegate.navigationController popViewControllerAnimated:YES];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            //            NSLog(@"%lf",rate);
            UIView *fromView = [delegate.currentTransitionContext viewForKey:UITransitionContextFromViewKey];
            self.isLeft = (0.5 + rate) < 0.5;
            [delegate updateInteractiveTransition: 0.5 + rate * 0.5];

            fromView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateEnded:
            
            if ((self.isLeft && rate <= -0.2f) || (!self.isLeft && rate >= 0.2f))
                [self finishInteractiveTransition:delegate];
            else
                if ((self.isLeft && velocity < -1000) || (!self.isLeft && velocity > 1000))
                    [self finishInteractiveTransition:delegate];
                else
                    [self cancelInteractiveTransition:delegate];
            break;
            
        default:
            [self cancelInteractiveTransition:delegate];
            break;
    }
}

-(void)cancelInteractiveTransition:(MTInteractiveNavigationDelegate *)delegate
{
    [delegate updateInteractiveTransition: 0.5];

    UIView *fromView = [delegate.currentTransitionContext viewForKey:UITransitionContextFromViewKey];
    fromView.hidden = false;

    for(UIView* subview in delegate.currentTransitionContext.containerView.subviews)
    {
        if([subview isKindOfClass:NSClassFromString(@"_UIReplicantView")])
        {
            [delegate.currentTransitionContext.containerView bringSubviewToFront:fromView];
            subview.hidden = YES;
            break;
        }
    }
    [delegate cancelInteractiveTransition];
}

-(void)finishInteractiveTransition:(MTInteractiveNavigationDelegate *)delegate
{
    if(self.isLeft)
    {
        [delegate updateInteractiveTransition: 0];

        for(UIView* subview in delegate.currentTransitionContext.containerView.subviews)
        {
            if([subview isKindOfClass:NSClassFromString(@"_UIReplicantView")])
            {
                subview.hidden = YES;
                break;
            }
        }
    }
    
    [delegate finishInteractiveTransition];
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    [transitionContext.containerView addSubview:snapShot];
    [transitionContext.containerView insertSubview:toView atIndex:0];
    
 
    snapShot.frame = transitionContext.containerView.bounds;
    snapShot.layer.anchorPoint = CGPointMake(0.5, 1.5);
    snapShot.layer.position = CGPointMake(snapShot.bounds.size.width * 0.5, snapShot.bounds.size.height * 1.5);
    
    snapShot.transform = self.isInteraction ? CGAffineTransformMakeRotation(-M_PI_2) : CGAffineTransformIdentity;
    
    fromView.hidden = !self.isInteraction;
    [UIView animateWithDuration:0.3 animations:^{
        
        snapShot.transform = CGAffineTransformMakeRotation(self.isInteraction ? M_PI_2 : M_PI_4);
    } completion:^(BOOL finished) {
        
        fromView.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
