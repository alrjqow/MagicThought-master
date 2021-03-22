//
//  MTInteractiveGestureTransitioningProtocol.h
//  DaYiProject
//
//  Created by monda on 2019/1/23.
//  Copyright © 2019 monda. All rights reserved.
//

@class MTInteractiveNavigationDelegate;
@protocol MTInteractiveGestureTransitioningProtocol <NSObject>

- (void)panAction:(UIPanGestureRecognizer *)gesture InteractiveNavigationDelegate:(MTInteractiveNavigationDelegate*)delegate;

@optional
-(void)cancelInteractiveTransition:(MTInteractiveNavigationDelegate*)delegate;

-(void)finishInteractiveTransition:(MTInteractiveNavigationDelegate*)delegate;


@end
