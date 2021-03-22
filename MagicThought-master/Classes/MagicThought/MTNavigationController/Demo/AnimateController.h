//
//  AnimateController.h
//  DaYiProject
//
//  Created by monda on 2019/1/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnimateNavigationController : UINavigationController

@end

@interface AnimateNavigationDelegate : UIPercentDrivenInteractiveTransition<UINavigationControllerDelegate>

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UINavigationController *navigation;

@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, assign) BOOL isInteraction;

@end

@interface AnimateNavigationTransitioningPush : NSObject<UIViewControllerAnimatedTransitioning>

@end
@interface AnimateNavigationTransitioningPop : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isInteraction;

@end


@interface AnimateController : UIViewController

@end


