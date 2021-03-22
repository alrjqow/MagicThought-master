//
//  MTNavigationController.m
//  DaYiProject
//
//  Created by monda on 2018/8/1.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTNavigationController.h"
#import <objc/runtime.h>

@interface MTNavigationController ()<UIGestureRecognizerDelegate>

/*-----------------------------------全屏侧屏滑动-----------------------------------*/

/*!用来保存系统自带侧滑返回代理 */
@property (nonatomic,strong) id<UIGestureRecognizerDelegate>  interactivePopGestureRecognizerDelegate;

/*!用来保存系统全屏滑动手势*/
@property (nonatomic,strong) UIPanGestureRecognizer*  fullScreenPopGestureRecognizer;

@end

@implementation MTNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefault];
}

-(void)setupDefault
{
    [super setupDefault];
    
    if(![self.navigationBar valueForKey:@"ignoreTranslucentBarTintColor"])
        [self.navigationBar setValue:[UIColor whiteColor] forKey:@"ignoreTranslucentBarTintColor"];
    
    UIView* bottomLine = [self.navigationBar valueForKey:@"bottomLine"];
    bottomLine.backgroundColor = [UIColor blackColor];
    self.delegate = self;
}

#pragma mark - 成员方法

-(void)back
{
    if([self.topViewController isKindOfClass:NSClassFromString(@"MTViewController")])
    {
        [self.topViewController performSelector:@selector(goBack)];
        return;
    }
        
    if (self.presentingViewController && self.viewControllers.count == 1)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [self popViewControllerAnimated:YES];
}


#pragma mark - 初始化

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if(self = [super initWithRootViewController:rootViewController])
    {
        self.interactivePopGestureRecognizerDelegate = self.interactivePopGestureRecognizer.delegate;
        [self.view addGestureRecognizer:self.fullScreenPopGestureRecognizer];
    }
    return self;
}

#pragma mark - 重载

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController setValue:self.topViewController forKey:@"previousController"];    
    if(self.viewControllers.count > 0)
    {
        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if(!self.navigationBar.isHidden && self.childViewControllers.count > 0)
        [self setupNavigationItem:viewController];
    
    [super pushViewController:viewController animated:animated];
}

-(void)setupNavigationItem:(UIViewController*)viewController
{
    if(self.leftBtnImageName.length <= 0)
        return;
    UIImage* img = [UIImage imageNamed:self.leftBtnImageName];
    if(!img)
        return;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage: img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    //解决按钮不靠左 靠右的问题.
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    nagetiveSpacer.width = [[[UIDevice currentDevice] systemVersion] floatValue] >= 11 ? 16 : 9;//这个值可以根据自己需要调整

    viewController.navigationItem.leftBarButtonItems = @[nagetiveSpacer, [[UIBarButtonItem alloc] initWithCustomView:btn]];
}

#pragma mark - 懒加载

-(void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.interactivePopGestureRecognizer.enabled = (delegate == self && !self.isFullScreenPop && self.enableSlideBack);
    self.fullScreenPopGestureRecognizer.enabled = (delegate == self && self.isFullScreenPop);
    [super setDelegate:delegate];
}

-(void)setIsFullScreenPop:(BOOL)isFullScreenPop
{
    _isFullScreenPop = isFullScreenPop;
    
    self.interactivePopGestureRecognizer.enabled = !isFullScreenPop;
    self.fullScreenPopGestureRecognizer.enabled = isFullScreenPop;
}

-(UIPanGestureRecognizer *)fullScreenPopGestureRecognizer
{
    if(!_fullScreenPopGestureRecognizer)
    {
        _fullScreenPopGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizerDelegate action:@selector(handleNavigationTransition:)];
        _fullScreenPopGestureRecognizer.delegate = self;
        _fullScreenPopGestureRecognizer.enabled = false;
    }
    
    return _fullScreenPopGestureRecognizer;
}

- (void)setEnableSlideBack:(BOOL)enableSlideBack
{
    if(self.isFullScreenPop)
    {
        self.interactivePopGestureRecognizer.enabled = false;
        self.fullScreenPopGestureRecognizer.enabled = enableSlideBack;
    }
    else
    {
        self.interactivePopGestureRecognizer.enabled = enableSlideBack;
        self.fullScreenPopGestureRecognizer.enabled = false;
    }
}

-(BOOL)enableSlideBack
{
    return self.isFullScreenPop ? self.fullScreenPopGestureRecognizer.enabled : self.interactivePopGestureRecognizer.enabled;
}

#pragma mark - 手势代理

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.viewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(navigationController.viewControllers.count < 2)
        self.interactivePopGestureRecognizer.delegate = self.interactivePopGestureRecognizerDelegate;
}


@end

@implementation UINavigationController (Extern)

-(void)setEnableSlideBack:(BOOL)enableSlideBack
{
    self.interactivePopGestureRecognizer.enabled = enableSlideBack;
}

-(BOOL)enableSlideBack
{
    return self.interactivePopGestureRecognizer.enabled;
}


@end


@implementation UIViewController (NavigationRecord)

-(void)setPreviousController:(UIViewController *)previousController
{
    objc_setAssociatedObject(self, @selector(previousController), previousController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewController *)previousController
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

