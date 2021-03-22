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
