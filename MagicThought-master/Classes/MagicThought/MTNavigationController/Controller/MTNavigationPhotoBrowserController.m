//
//  MTNavigationPhotoBrowserController.m
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTNavigationPhotoBrowserController.h"
#import "UIView+Frame.h"
#import "UIDevice+DeviceInfo.h"

@interface MTNavigationPhotoBrowserController ()

@property (nonatomic, strong) UIView * statusBar;

@property (nonatomic, weak) UIView * statusBarSuperView;

@property (nonatomic,assign) BOOL setupStatusBar;

@property (nonatomic,assign) BOOL isShow;

@end

@implementation MTNavigationPhotoBrowserController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    [self addStatusBarToDefault:@(YES)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addStatusBarToDefault:@(false)];
}

-(void)addStatusBarToDefault:(NSNumber*)isDefault
{
    if(!self.setupStatusBar)
        return;
    if(isDefault.boolValue)
    {
        self.statusBar.y = 0;
        [self.statusBarSuperView addSubview:self.statusBar];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:false];
        
        return;
    }
    
    self.statusBar.y = [UIDevice isHairScreen] ? -44 : -20;
    [self.navigationBar addSubview:self.statusBar];
}

#pragma mark - 代理

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0)
        self.isShow = YES;    
    
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super navigationController:navigationController didShowViewController:viewController animated:animated];
    
    if(self.isShow && viewController == self.viewControllers[0])
    {
        self.isShow = false;
        
        if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
        {
            [self.mt_delegate doSomeThingForMe:self withOrder:@"MTNavigationControllerDidShowRootViewControllerOrder"];
            return;
        }
    }
    
    if([viewController isKindOfClass:NSClassFromString(@"PhotoDetailController")] || [viewController isKindOfClass:NSClassFromString(@"MTPhotoBrowserController")])
    {
        if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
        {
            [self.mt_delegate doSomeThingForMe:self withOrder:@"MTNavigationControllerDidShowPhotoBrowserControllerOrder"];
            return;
        }
    }
}

#pragma mark - 懒加载

-(void)setSetupStatusBar:(BOOL)setupStatusBar
{
    _setupStatusBar = setupStatusBar;
    
    if(!setupStatusBar)
        return;
    
    // 将状态栏添加到自定义的导航栏上
    self.statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    self.statusBarSuperView = self.statusBar.superview;
}

@end
