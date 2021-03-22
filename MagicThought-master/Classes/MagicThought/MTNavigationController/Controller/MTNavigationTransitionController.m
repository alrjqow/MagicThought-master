//
//  MTNavigationTransitionController.m
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTNavigationTransitionController.h"

/**转场*/
#import "UIViewControllerTransitionModel.h"
#import "MTInteractiveNavigationDelegate.h"

@interface MTNavigationTransitionController ()

/**转场*/
@property (nonatomic,strong) MTInteractiveNavigationDelegate* interactiveDelegate;

@end

@implementation MTNavigationTransitionController


#pragma mark - 代理

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{        
    [self configPushTransitionWithViewController:viewController];
    
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super navigationController:navigationController didShowViewController:viewController animated:animated];
    
    [self configPushTransitionWithViewController:viewController];
    
    if(!viewController.mt_transitionModel.pushTransition && viewController.mt_transitionModel.popTransition)
        self.delegate = self.interactiveDelegate;
    else if(self.visibleViewController.mt_transitionModel.pushTransition && !self.visibleViewController.mt_transitionModel.popTransition)
    {
        self.delegate = self;
        self.isFullScreenPop = false;
        viewController.mt_transitionGestureRecognizer.enabled = false;
    }
}


-(void)configPushTransitionWithViewController:(UIViewController*)viewController
{
    if(!viewController.mt_transitionModel.pushTransition && !viewController.mt_transitionModel.popTransition)
    {
        self.delegate = self;
        if(viewController.mt_transitionModel)
            self.isFullScreenPop = viewController.mt_transitionModel.edges == UIRectEdgeNone;
    }
    else
    {
        self.delegate = (!viewController.mt_transitionModel.pushTransition && viewController.mt_transitionModel.popTransition) ? self : self.interactiveDelegate;
        [self.interactiveDelegate addPanGestureRecognizerWithController:viewController];
    }
}


#pragma mark - 懒加载

-(MTInteractiveNavigationDelegate *)interactiveDelegate
{
    if(!_interactiveDelegate)
    {
        _interactiveDelegate = [MTInteractiveNavigationDelegate new];
        _interactiveDelegate.navigationController = self;
    }
    
    return _interactiveDelegate;
}

@end
