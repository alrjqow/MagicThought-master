//
//  UIViewControllerTransitionModel.m
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIViewControllerTransitionModel.h"
#import "MTInteractiveGestureTransitioningProtocol.h"
#import "MTAnimatedTransitioning.h"
#import "objc/runtime.h"

@implementation UIViewControllerTransitionModel



- (void)panAction:(UIPanGestureRecognizer *)gesture InteractiveNavigationDelegate:(MTInteractiveNavigationDelegate*)delegate
{
    [self.popTransition panAction:gesture InteractiveNavigationDelegate:delegate];
}




@end




































@implementation UIViewController(TransitionModel)

static const void *mtUIViewControllerTransitionModelKey = @"mtUIViewControllerTransitionModel";
static const void *mtUIViewControllerTransitionGestureRecognizerKey = @"mtUIViewControllerTransitionGestureRecognizerKey";


-(void)setMt_transitionModel:(UIViewControllerTransitionModel *)mt_transitionModel
{
    objc_setAssociatedObject(self, mtUIViewControllerTransitionModelKey, mt_transitionModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewControllerTransitionModel *)mt_transitionModel
{
    return objc_getAssociatedObject(self, mtUIViewControllerTransitionModelKey);
}

-(void)setMt_transitionGestureRecognizer:(UIPanGestureRecognizer *)mt_transitionGestureRecognizer
{
    objc_setAssociatedObject(self, mtUIViewControllerTransitionGestureRecognizerKey, mt_transitionGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIPanGestureRecognizer *)mt_transitionGestureRecognizer
{
    return objc_getAssociatedObject(self, mtUIViewControllerTransitionGestureRecognizerKey);
}


@end
