//
//  MTInteractiveNavigationDelegate.h
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MTNavigationTransitionController;
@interface MTInteractiveNavigationDelegate : UIPercentDrivenInteractiveTransition<UINavigationControllerDelegate>

@property (nonatomic, weak) MTNavigationTransitionController *navigationController;

@property (nonatomic,strong, readonly) id<UIViewControllerContextTransitioning> currentTransitionContext;

-(void)addPanGestureRecognizerWithController:(UIViewController*)viewController;

@end


