//
//  UIViewController+Navigation.m
//  MDKit
//
//  Created by monda on 2019/5/27.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import "MTCloud.h"

@implementation UIViewController (Navigation)

-(void)push:(UIViewController*)controller RemoveControllersClass:(NSArray<NSString*>*)viewControllersClass
{
    [self pushViewController:controller RemoveControllersClass:viewControllersClass isAnimate:false];
}

-(void)pushWithAnimate:(UIViewController*)controller RemoveControllersClass:(NSArray<NSString*>*)viewControllersClass
{
    [self pushViewController:controller RemoveControllersClass:viewControllersClass isAnimate:YES];
}

-(void)pushViewController:(UIViewController*)controller RemoveControllersClass:(NSArray<NSString*>*)viewControllersClass isAnimate:(BOOL)isAnimate
{
    if(!self.navigationController)
        return;
    
    NSMutableArray* array = [self.navigationController.viewControllers mutableCopy];
    
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        for (NSString* className in viewControllersClass) {
            if([viewController isKindOfClass:NSClassFromString(className)])
            {
                [array removeObject:viewController];
                break;
            }
        }
    }
    
    [array addObject:controller];
    
    [self.navigationController setViewControllers:array animated:isAnimate];
}

-(void)push
{
    [[MTCloud shareCloud].currentViewController.navigationController pushViewController:self animated:false];
}
-(void)pushWithAnimate
{
    [[MTCloud shareCloud].currentViewController.navigationController pushViewController:self animated:YES];
}

-(void)pop
{
    [[MTCloud shareCloud].currentViewController.navigationController popViewControllerAnimated:false];
}
-(void)popWithAnimate
{
    [[MTCloud shareCloud].currentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)popSelf
{
     [self.navigationController popViewControllerAnimated:false];
}

-(void)popSelfWithAnimate
{
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToRoot
{
    if([self isKindOfClass:[UINavigationController class]])
       [((UINavigationController*)self) popToRootViewControllerAnimated:false];
    else
        [[MTCloud shareCloud].currentViewController.navigationController popToRootViewControllerAnimated:false];
}

-(void)popToRootWithAnimate
{
    if([self isKindOfClass:[UINavigationController class]])
       [((UINavigationController*)self) popToRootViewControllerAnimated:YES];
    else
        [[MTCloud shareCloud].currentViewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popSelfToRoot
{
    if([self isKindOfClass:[UINavigationController class]])
       [((UINavigationController*)self) popToRootViewControllerAnimated:false];
    else
        [self.navigationController popToRootViewControllerAnimated:false];
}

-(void)popSelfToRootWithAnimate
{
    if([self isKindOfClass:[UINavigationController class]])
       [((UINavigationController*)self) popToRootViewControllerAnimated:YES];
    else
        [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
