//
//  MTAnimatedTransitioning.h
//  DaYiProject
//
//  Created by monda on 2019/1/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTInteractiveGestureTransitioningProtocol.h"

@interface MTAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning, MTInteractiveGestureTransitioningProtocol>

/**是否手势交互*/
@property (nonatomic, assign) BOOL isInteraction;


@end


@interface MTAnimatedTransitioningPush : MTAnimatedTransitioning

@end

@interface MTAnimatedTransitioningPop : MTAnimatedTransitioning

@end

