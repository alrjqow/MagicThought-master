//
//  MTInteractiveNavigationDelegate.m
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTInteractiveNavigationDelegate.h"
#import "MTNavigationTransitionController.h"

#import "UIViewControllerTransitionModel.h"
#import "MTAnimatedTransitioning.h"
#import "MTInteractiveGestureTransitioningProtocol.h"

@interface MTInteractiveNavigationDelegate ()

@property (nonatomic, assign) BOOL isInteraction;

@property (nonatomic, assign) BOOL isPop;



@end

@implementation MTInteractiveNavigationDelegate

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _currentTransitionContext = transitionContext;
    
    [super startInteractiveTransition:transitionContext];
}

-(void)cancelInteractiveTransition
{
    _currentTransitionContext = nil;
    [super cancelInteractiveTransition];
}

- (void)finishInteractiveTransition
{
    _currentTransitionContext = nil;
    [super finishInteractiveTransition];
}

#pragma mark - 手势
- (void)panAction:(UIPanGestureRecognizer *)gesture
{
    self.isInteraction = gesture.state == UIGestureRecognizerStateBegan;

    if(self.navigationController.delegate != self)
        return;
    
    [self.navigationController.topViewController.mt_transitionModel panAction:gesture InteractiveNavigationDelegate:self];
}

-(void)addPanGestureRecognizerWithController:(UIViewController*)viewController
{
    if(viewController.mt_transitionModel.edges != UIRectEdgeNone)
    {
        if([viewController.mt_transitionGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
        {
            viewController.mt_transitionGestureRecognizer.enabled = YES;
            return;
        }
        
        
        UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"panAction:")];
        edgePan.edges = viewController.mt_transitionModel.edges;
        [viewController.view addGestureRecognizer:edgePan];
        
        viewController.mt_transitionGestureRecognizer = edgePan;
    }
    else
    {
        if([viewController.mt_transitionGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
        {
            viewController.mt_transitionGestureRecognizer.enabled = YES;
            return;
        }
            
        UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self   action:NSSelectorFromString(@"panAction:")];
        [viewController.view addGestureRecognizer:edgePan];
        
        viewController.mt_transitionGestureRecognizer = edgePan;
    }
}

#pragma mark - 代理

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.isPop = operation == UINavigationControllerOperationPop;

    MTAnimatedTransitioning* transitioning;
    if(operation == UINavigationControllerOperationPush)
        transitioning = toVC.mt_transitionModel.pushTransition;
    else if(operation == UINavigationControllerOperationPop)
        transitioning = toVC.mt_transitionModel.popTransition;

    transitioning.isInteraction = self.isInteraction;



    return transitioning;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return  _isInteraction ? self : nil;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController navigationController:navigationController didShowViewController:viewController animated:animated];
}

@end
