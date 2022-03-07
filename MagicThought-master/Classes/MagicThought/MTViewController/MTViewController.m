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
#import "MTNotificationConst.h"

#import "UIViewController+Navigation.h"

@interface MTViewController ()

@end

@implementation MTViewController

#pragma mark - 生命周期

- (void)whenDealloc
{
    [super whenDealloc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationDidUserLoginSuccess_mt object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationDidUserLoginTimeOut_mt object:nil];
    
    NSLog(@"%@销毁", NSStringFromClass(self.class));
}

-(instancetype)init
{
    if(self = [super init])
    {
        [self setValue:NSMutableArray.new forKey:@"modelArray"];
        [self initProperty];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.isVisible = YES;
    
    if([self isKindOfClass:NSClassFromString(@"MTPageScrollListController")] && [self valueForKey:@"pageControllModel"])
        return;    
    
    [self loadStatusBarStyle];
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
    self.isDidAppear = YES;
    
    if([self.view.superview isKindOfClass:NSClassFromString(@"MTTenScrollContentCell")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTBaseAlertController")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTPhotoBrowserController")])
        return;
    if([self isKindOfClass:NSClassFromString(@"MTPageScrollListController")])
    {
        UIViewController* pageSumController = [self valueForKey:@"pageSumController"];
        if([pageSumController isKindOfClass:UIViewController.class] && pageSumController.navigationController)
        {
            [MTCloud shareCloud].currentViewController = pageSumController;
            return;
        }
    }
        
    if(self.isNotCurrentController)
        return;
    
    if(self.navigationController)
        [MTCloud shareCloud].currentViewController = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isVisible = false;
    self.isDidAppear = false;
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

-(instancetype)showNoMsgResult
{
    return self.isLoadResult ? self : self.showNoMsg;
}

#pragma mark - 重载方法

-(void)initProperty{}

/**初始化属性*/
-(void)setupDefault
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLoginSuccess:) name:kNotificationDidUserLoginSuccess_mt object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLoginTimeOut:) name:kNotificationDidUserLoginTimeOut_mt object:nil];
}

/**初始化tabBar的item*/
-(void)setupTabBarItem{}

/**初始化导航栏item*/
-(void)setupNavigationItem{}

- (void)setupSubview{
    
    if([self isKindOfClass:NSClassFromString(@"MTAlertBigImageController")])
        return;
    
    if(!self.emptyLoadingViewInitHidden && self.emptyLoadingView)
    {        
        self.emptyLoadingView.frame = self.view.bounds;
        [self.view addSubview:self.emptyLoadingView];
    }
    
    if(!self.navigationBarHidden)
    {
        self.title = self.title;
        [self.view addSubview:self.navigationBar];
    }
}

-(void)navigationBarRightBtnClick{}

/**加载数据*/
-(void)loadData{}

/**请求数据*/
-(void)startRequest{}

/**状态栏颜色*/
-(void)loadStatusBarStyle
{
    if(!self.isVisible)
        return;
    if(self.isLoadStatusBarLightContent)
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    else
    {
        if (@available(iOS 13.0, *))
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
        else
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
}

#pragma mark - 通知

-(void)didReceiveLoginSuccess:(NSNotification*)notification
{
    [self didReceiveLogin:notification lsLogin:YES];
}

-(void)didReceiveLoginTimeOut:(NSNotification*)notification
{
    [self didReceiveLogin:notification lsLogin:false];
}

-(void)didReceiveLogin:(NSNotification*)notification lsLogin:(BOOL)isLogin
{
    if(notification.object == self)
        return;
            
    [self didReceiveLogin:isLogin];
}

-(void)didReceiveLogin:(BOOL)isLogin
{
    [self startRequest];
}


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

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [viewControllerToPresent setValue:self forKey:@"previousController"];
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
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

-(UIView *)emptyLoadingView
{
    if(_emptyLoadingViewClassName.length <= 0)
        return nil;
    
    if(!_emptyLoadingView)
    {
        Class c = NSClassFromString(self.emptyLoadingViewClassName);
        
        if(![c isSubclassOfClass:[UIView class]])
        {
            _emptyLoadingViewClassName = nil;
            return nil;
        }
            
        _emptyLoadingView = (UIView*)c.new;
    }
    
    return _emptyLoadingView;
}


-(void)setTitle:(NSString *)title
{
    [super setTitle:title];

    if(title.length)
    {
        self.navigationBar.textLabel.text = title;
        [self.navigationBar.textLabel sizeToFit];
    }    
}

-(NSMutableArray *)modelArrayAlias
{
    return [self valueForKey:@"modelArray"];    
}

@end
