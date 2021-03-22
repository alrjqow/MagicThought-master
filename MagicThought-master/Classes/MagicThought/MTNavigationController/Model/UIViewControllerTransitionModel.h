//
//  UIViewControllerTransitionModel.h
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MTInteractiveGestureTransitioningProtocol;
@class MTAnimatedTransitioningPush;
@class MTAnimatedTransitioningPop;

@interface UIViewControllerTransitionModel : NSObject<MTInteractiveGestureTransitioningProtocol>

/**是否屏幕边缘手势*/
@property (nonatomic, assign) UIRectEdge edges;

@property (nonatomic,strong) MTAnimatedTransitioningPush* pushTransition;

@property (nonatomic,strong) MTAnimatedTransitioningPop* popTransition;

@end





























@interface UIViewController(TransitionModel)

@property (nonatomic,strong) UIViewControllerTransitionModel* mt_transitionModel;

@property (nonatomic,strong) UIPanGestureRecognizer* mt_transitionGestureRecognizer;


@end

