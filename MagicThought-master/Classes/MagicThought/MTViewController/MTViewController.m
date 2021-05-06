//
//  MTViewController.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/28.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTViewController.h"
#import "UIView+MBHud.h"
#import "MBProgressHUD.h"
#import "MTCloud.h"
#import "MJRefresh.h"

#import "UIViewController+Navigation.h"

@interface MTViewController ()

@end

@implementation MTViewController

#pragma mark - 生命周期

- (void)whenDealloc
{
    [super whenDealloc];
    NSLog(@"%@销毁", NSStringFromClass(self.class));
}

-(instancetype)init
{
    if(self = [super init])
    {
        [self initProperty];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.isVisible = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isVisible = false;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isVisible = YES;
    
    if([self.view.superview isKindOfClass:NSClassFromString(@"MTTenScrollContentCell")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTBaseAlertController")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTPhotoBrowserController")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTPageScrollListController")] && [self.view.superview.superview isKindOfClass:[UIScrollView class]])
        return;
        
    if(self.isNotCurrentController)
        return;
    
    if(self.navigationController)
        [MTCloud shareCloud].currentViewController = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isVisible = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefault];
    [self setupTabBarItem];
    [self setupNavigationItem];
    [self setupSubview];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _isViewDidLoad = YES;
    
    if(!self.navigationBarHidden)
        [self.view bringSubviewToFront:self.navigationBar];
    [self.view bringSubviewToFront:[MBProgressHUD HUDForView:self.view]];
}

/**缺省加载圈*/
-(instancetype)showNoMsg
{
    return [self showMsg:nil];
}

#pragma mark - 重载方法

-(void)initProperty{}

/**初始化属性*/
-(void)setupDefault
{
    self.view.backgroundColor = [UIColor whiteColor];
}

/**初始化tabBar的item*/
-(void)setupTabBarItem{}

/**初始化导航栏item*/
-(void)setupNavigationItem{}

- (void)setupSubview{
    
    if(self.navigationBarHidden)
        return;
    self.title = self.title;
    
    if(![self isKindOfClass:NSClassFromString(@"MTAlertBigImageController")])
        [self.view addSubview:self.navigationBar];
}

-(void)navigationBarRightBtnClick{}

/**加载数据*/
-(void)loadData{}

/**请求数据*/
-(void)startRequest{}

#pragma mark - 点击事件


#pragma mark - 成员方法

-(void)goBack
{
    if (self.presentingViewController && !self.navigationController)
        [self dismissViewControllerAnimated:YES completion:nil];
    else if (self.navigationController.presentingViewController && self.navigationController.viewControllers.count == 1)
        [self dismissViewControllerAnimated:YES completion:nil];
    else if(self.popToController)
        [self.navigationController popToViewController:self.popToController animated:YES];
    else if(self.isPopToRoot)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else
        [self popWithAnimate];
}

#pragma mark - WKScriptMessageHandler代理

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    id scriptDelegate = [[MTCloud shareCloud] objectForKey:self];
    
    if([scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)])
        [scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}


#pragma mark - 懒加载

-(MTNavigationBar *)navigationBar
{
    MTNavigationBar* _navigationBar = objc_getAssociatedObject(self, _cmd);
    if(!_navigationBar)
    {
        Class c = NSClassFromString(self.navigationBarClassName);
                
        if(![c isSubclassOfClass:[MTNavigationBar class]])
            return nil;
                
        _navigationBar = (MTNavigationBar*)c.new;
        __weak __typeof(self) weakSelf = self;
        _navigationBar.button.bindClick(^(NSString *order) {
            [weakSelf goBack];
        });
        
        _navigationBar.button2.bindClick(^(NSString *order) {
            [weakSelf navigationBarRightBtnClick];
        });
        
        objc_setAssociatedObject(self, _cmd, _navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _navigationBar;
}

-(NSString *)navigationBarClassName
{
    return @"MTNavigationBar";
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];

    self.navigationBar.textLabel.text = title;
    [self.navigationBar.textLabel sizeToFit];
}


@end
