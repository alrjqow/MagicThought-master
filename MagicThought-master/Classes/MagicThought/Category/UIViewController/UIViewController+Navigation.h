//
//  UIViewController+Navigation.h
//  MDKit
//
//  Created by monda on 2019/5/27.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Navigation)

-(void)push:(UIViewController*)controller RemoveControllersClass:(NSArray<NSString*>*)viewControllersClass;
-(void)pushWithAnimate:(UIViewController*)controller RemoveControllersClass:(NSArray<NSString*>*)viewControllersClass;


-(void)push;
-(void)pushWithAnimate;

-(void)pop;
-(void)popWithAnimate;

-(void)popToRoot:(NSString*)controllerClass;
-(void)popToRootWithAnimate:(NSString*)controllerClass;

-(void)popSelf;
-(void)popSelfWithAnimate;

-(void)popToRoot;
-(void)popToRootWithAnimate;

-(void)popSelfToRoot;
-(void)popSelfToRootWithAnimate;

- (void)presentFullScreenViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;

- (void)presentCanAlphaViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;

@end

