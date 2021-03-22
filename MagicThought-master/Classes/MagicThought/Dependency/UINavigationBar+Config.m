////
////  UINavigationBar+Config.m
////  test
////
////  Created by monda on 2018/3/29.
////  Copyright © 2018年 monda. All rights reserved.
////
//
//#import "UINavigationBar+Config.h"
//#import "MTConst.h"
//#import "UIDevice+DeviceInfo.h"
//#import "objc/runtime.h"
//
//static const void *mtNavConfigBottomLineKey = @"mtNavConfigBottomLineKey";
//static const void *mtNavConfigBackgroundViewKey = @"mtNavConfigBackgroundViewKey";
//static const void *mtNavConfigGlobalAlphaKey = @"mtNavConfigGlobalAlphaKey";
//static const void *mtNavConfigBackgroundAlphaKey = @"mtNavConfigBackgroundAlphaKey";
//static const void *mtTransitionConfigPushToCurrentVCFinishedKey = @"mtTransitionConfigPushToCurrentVCFinishedKey";
//static const void *mtTransitionConfigEnableSlideBackKey = @"mtTransitionConfigEnableSlideBackKey";
//static const void *mtTransitionConfigNavigationBarAlphaKey = @"mtTransitionConfigNavigationBarAlphaKey";
//static const void *mtTransitionConfigIgnoreTranslucentBarTintColorKey = @"mtTransitionConfigIgnoreTranslucentBarTintColorKey";
//static const void *mtTransitionConfigNavigationBarTitleColorKey = @"mtTransitionConfigNavigationBarTitleColorKey";
//
//
//@interface UINavigationController (Transition)
//
//- (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;
//
//@end
//
//@implementation UINavigationBar (Config)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL needSwizzleSelectors[4] = {
//            @selector(layoutSubviews),
//        };
//        
//        for (int i = 0; i < 4;  i++) {
//            SEL selector = needSwizzleSelectors[i];
//            NSString *newSelectorStr = [NSString stringWithFormat:@"mt_%@", NSStringFromSelector(selector)];
//            Method originMethod = class_getInstanceMethod(self, selector);
//            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
//            method_exchangeImplementations(originMethod, swizzledMethod);
//        }
//    });
//}
//
//-(void)mt_layoutSubviews
//{
//    [self mt_layoutSubviews];
//
//    self.shadowImage = [UIImage new];
//    
//    [self addSubview:self.bottomLine];
//    [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
//}
//
//-(UIView *)bottomLine
//{
//    UIView* bottomLine = objc_getAssociatedObject(self, mtNavConfigBottomLineKey);
//    
//    if(!bottomLine)
//    {
//        bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth_mt(), 0.5)];
//        bottomLine.backgroundColor = [UIColor clearColor];
//        
//        objc_setAssociatedObject(self, mtNavConfigBottomLineKey, bottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    
//    return bottomLine;
//}
//
//
//-(void)setBackgroundAlpha:(CGFloat)backgroundAlpha
//{
//    objc_setAssociatedObject(self, mtNavConfigBackgroundAlphaKey, @(backgroundAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    //必须要支持透明，否则不能设置透明度
//    self.translucent = YES;
//    //    self.globalAlpha = YES;
//    
//    UIView *barBackgroundView = self.subviews.firstObject;
//
//    // sometimes we can't change _UIBarBackground alpha
//    for (UIView *view in barBackgroundView.subviews)
//        view.alpha = backgroundAlpha;
//    
//    self.bottomLine.alpha = backgroundAlpha;        
//}
//
//
//
//-(CGFloat)backgroundAlpha
//{
//    return ((NSNumber*)objc_getAssociatedObject(self, mtNavConfigBackgroundAlphaKey)).floatValue;
//}
//
//-(void)setGlobalAlpha:(BOOL)globalAlpha
//{
//    objc_setAssociatedObject(self, mtNavConfigGlobalAlphaKey, @(globalAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    //修改导航条背景图片
//    [self setBackgroundImage:globalAlpha ? [UIImage new] : nil forBarMetrics:UIBarMetricsDefault];
//}
//
//-(BOOL)globalAlpha
//{
//    return ((NSNumber*)objc_getAssociatedObject(self, mtNavConfigGlobalAlphaKey)).boolValue;
//}
//
//-(void)setIgnoreTranslucentBarTintColor:(UIColor *)ignoreTranslucentBarTintColor
//{
//    self.globalAlpha = ignoreTranslucentBarTintColor;
//    self.backgroundView.backgroundColor = ignoreTranslucentBarTintColor;
//}
//
//-(UIColor *)ignoreTranslucentBarTintColor
//{
//    return self.backgroundView.backgroundColor;
//}
//
//
//
//- (UIView *)backgroundView {
//    
//    UIView* view = (UIView *)objc_getAssociatedObject(self, mtNavConfigBackgroundViewKey);
//    
//    if(!view)
//    {
//        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kNavigationBarHeight_mt())];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        // _UIBarBackground is first subView for navigationBar
//        self.backgroundView = view;
//    }
//    
//    //    [self.subviews.firstObject insertSubview:view atIndex:0];
//    return view;
//}
//- (void)setBackgroundView:(UIView *)backgroundView {
//    objc_setAssociatedObject(self, mtNavConfigBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (void)updateForTitleColor:(UIColor *)titleColor {
//    
//    if(!titleColor)
//        return;
//
//    NSDictionary *titleTextAttributes = self.titleTextAttributes;
//    if (titleTextAttributes == nil) {
//        self.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
//        return;
//    }
//    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
//    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
//    self.titleTextAttributes = newTitleTextAttributes;
//}
//
//@end
//
//
//
//
//@implementation UIViewController (TransitionConfig)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL needSwizzleSelectors[4] = {
//            @selector(viewWillAppear:),
//            @selector(viewDidAppear:),
//            //            @selector(viewWillDisappear:),
//            //            @selector(viewDidDisappear:)
//        };
//        
//        for (int i = 0; i < 4;  i++) {
//            SEL selector = needSwizzleSelectors[i];
//            NSString *newSelectorStr = [NSString stringWithFormat:@"mt_%@", NSStringFromSelector(selector)];
//            Method originMethod = class_getInstanceMethod(self, selector);
//            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
//            method_exchangeImplementations(originMethod, swizzledMethod);
//        }
//    });
//}
//
//- (void)mt_viewWillAppear:(BOOL)animated
//{
//    [self.navigationController.navigationBar updateForTitleColor:[NSStringFromClass([self class]) containsString:@"TZ"] ? [UIColor whiteColor] : self.navigationBarTitleColor];
//    
//    [self mt_viewWillAppear:animated];
//}
//
//
//- (void)mt_viewDidAppear:(BOOL)animated {
//    
//    self.navigationController.navigationBar.backgroundAlpha = self.navigationBarAlpha;
//    [self mt_viewDidAppear:animated];
//}
//
//- (BOOL)pushToCurrentVCFinished {
//    id isFinished = objc_getAssociatedObject(self, mtTransitionConfigPushToCurrentVCFinishedKey);
//    return (isFinished != nil) ? [isFinished boolValue] : NO;
//}
//
//- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
//    objc_setAssociatedObject(self, mtTransitionConfigPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(void)setEnableSlideBack:(BOOL)enableSlideBack
//{
//    objc_setAssociatedObject(self, mtTransitionConfigEnableSlideBackKey, @(enableSlideBack), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(BOOL)enableSlideBack
//{
//    id enableSlideBack = objc_getAssociatedObject(self, mtTransitionConfigEnableSlideBackKey);
//    if(!enableSlideBack)
//        return YES;
//    
//    return [enableSlideBack boolValue];
//}
//
//// navigationBar _UIBarBackground alpha
//-(CGFloat)navigationBarAlpha
//{
//    NSNumber* alpha= (NSNumber*)objc_getAssociatedObject(self, mtTransitionConfigNavigationBarAlphaKey);
//    return !alpha ? 1 : alpha.floatValue;
//}
//
//-(void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha
//{
//    objc_setAssociatedObject(self, mtTransitionConfigNavigationBarAlphaKey, @(navigationBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(UIColor *)ignoreTranslucentBarTintColor
//{
//    static UIColor* defaultColor;
//    if(!defaultColor)
//        defaultColor = self.navigationController.navigationBar.ignoreTranslucentBarTintColor;
//    
//    UIColor* color= (UIColor*)objc_getAssociatedObject(self, mtTransitionConfigIgnoreTranslucentBarTintColorKey);
//    
//    return color ? color : defaultColor;
//}
//
//-(void)setIgnoreTranslucentBarTintColor:(UIColor *)ignoreTranslucentBarTintColor
//{
//    objc_setAssociatedObject(self, mtTransitionConfigIgnoreTranslucentBarTintColorKey, ignoreTranslucentBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(UIColor *)navigationBarTitleColor
//{
//    static UIColor* defaultColor;
//    if(!defaultColor)
//        defaultColor = [self.navigationController.navigationBar.titleTextAttributes
//                        objectForKey:NSForegroundColorAttributeName];
//    
//    UIColor* color =  objc_getAssociatedObject(self, mtTransitionConfigNavigationBarTitleColorKey);
//    
//    return color ? color : defaultColor;
//}
//
//-(void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor
//{
//    objc_setAssociatedObject(self, mtTransitionConfigNavigationBarTitleColorKey, navigationBarTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    [self.navigationController.navigationBar updateForTitleColor:navigationBarTitleColor];
//}
//
//
//- (void)changeDefaultColor:(UIColor*)defaultColor ToTitleColor:(UIColor *)titleColor Percent:(CGFloat)percent;
//{
//    self.navigationBarTitleColor = [self.navigationController middleColor:defaultColor toColor:titleColor percent:percent];
//}
//
//@end
//
//
//@implementation UINavigationController(Config)
//
//- (void)setEnableSlideBack:(BOOL)enableSlideBack
//{
//    self.interactivePopGestureRecognizer.enabled = enableSlideBack;
//}
//
//
//-(BOOL)enableSlideBack
//{
//    return self.interactivePopGestureRecognizer.enabled;
//}
//
///**隐藏*/
//-(void)navigationBarHide{
//    
//    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    kfa.values = @[@(0), @(-20)];
//    kfa.duration = 0.25;
//    kfa.removedOnCompletion = false;
//    kfa.fillMode = kCAFillModeForwards;
//    
//    CAKeyframeAnimation *kfa2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    kfa2.values = @[@(1),@(0)];
//    kfa2.duration = 0.32;
//    
//    CAAnimationGroup* group = [CAAnimationGroup animation];
//    group.animations = @[kfa, kfa2];
//    //保留动画执行完的状态
//    group.removedOnCompletion = false;
//    group.fillMode = kCAFillModeForwards;
//    //时长
//    group.duration = 0.32;
//    
//    
//    self.navigationBar.tag = -1;
//    [self.navigationBar.layer addAnimation:group forKey:@"navigationBarHide"];
//    [self.navigationBar.layer removeAnimationForKey:@"navigationBarShow"];
//    
//    self.view.userInteractionEnabled = false;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.32 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//        self.view.userInteractionEnabled = YES;
//    });
//}
//
///**显示*/
//-(void)navigationBarShow{
//    
//    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    kfa.values = @[@(-20), @(0)];
//    kfa.removedOnCompletion = false;
//    kfa.fillMode = kCAFillModeForwards;
//    kfa.duration = 0.25;
//    
//    CAKeyframeAnimation *kfa2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    kfa2.values = @[@(0), @(1)];
//    kfa2.duration = 0.32;
//    
//    CAAnimationGroup* group = [CAAnimationGroup animation];
//    group.animations = @[kfa, kfa2];
//    //保留动画执行完的状态
//    group.removedOnCompletion = false;
//    group.fillMode = kCAFillModeForwards;
//    //时长
//    group.duration = 0.32;
//    
//    self.navigationBar.tag = 0;
//    [self.navigationBar.layer addAnimation:group forKey:@"navigationBarShow"];
//    [self.navigationBar.layer removeAnimationForKey:@"navigationBarHide"];
//    
//    self.view.userInteractionEnabled = false;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.32 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        self.view.userInteractionEnabled = YES;
//    });
//}
//
//@end
//
//@implementation UINavigationController (Transition)
//
//static CGFloat mtPopDuration = 0.12;
//static int mtPushDisplayCount = 0;
//
//- (CGFloat)mtPopProgress {
//    CGFloat all = 60 * mtPopDuration;
//    int current = MIN(all, mtPushDisplayCount);
//    return current / all;
//}
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        SEL needSwizzleSelectors[4] = {
//            NSSelectorFromString(@"_updateInteractiveTransition:"),
//            @selector(popToViewController:animated:),
//            @selector(popToRootViewControllerAnimated:),
//            @selector(pushViewController:animated:)
//        };
//        
//        for (int i = 0; i < 4;  i++) {
//            SEL selector = needSwizzleSelectors[i];
//            NSString *newSelectorStr = [[NSString stringWithFormat:@"mt_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
//            Method originMethod = class_getInstanceMethod(self, selector);
//            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
//            method_exchangeImplementations(originMethod, swizzledMethod);
//        }
//    });
//}
//
//
//- (void)mt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    if(![self isKindOfClass:NSClassFromString(@"MTNavigationController")] || [NSStringFromClass([self class]) containsString:@"TZ"])
//    {
//        [self mt_pushViewController:viewController animated:animated];
//        return;
//    }
//    
//    self.enableSlideBack = viewController.enableSlideBack;
//    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(transitionNeedDisplay:)];
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    [CATransaction setCompletionBlock:^{
//        [displayLink invalidate];
//        displayLink = nil;
//        mtPushDisplayCount = 0;
//        [viewController setPushToCurrentVCFinished:YES];
//    }];
//    [CATransaction setAnimationDuration:mtPopDuration];
//    [CATransaction begin];
//    [self mt_pushViewController:viewController animated:animated];
//    [CATransaction commit];
//}
//
//
//- (NSArray<UIViewController *> *)mt_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    if(![self isKindOfClass:NSClassFromString(@"MTNavigationController")])
//        return [self mt_popToViewController:viewController animated:animated];
//    
//    self.enableSlideBack = viewController.enableSlideBack;
//    // pop 的时候直接改变 barTintColor、tintColor
//        
//    if(![NSStringFromClass([self class]) containsString:@"TZ"])
//    {
//        [self.navigationBar updateForTitleColor:viewController.navigationBarTitleColor];
//        self.navigationBar.ignoreTranslucentBarTintColor = viewController.ignoreTranslucentBarTintColor;
//    }
//    
//    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(transitionNeedDisplay:)];
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    [CATransaction setCompletionBlock:^{
//        [displayLink invalidate];
//        displayLink = nil;
//        mtPushDisplayCount = 0;
//    }];
//    [CATransaction setAnimationDuration:mtPopDuration];
//    [CATransaction begin];
//    NSArray<UIViewController *> *vcs = [self mt_popToViewController:viewController animated:animated];
//    [CATransaction commit];
//    return vcs;
//}
//
//- (NSArray<UIViewController *> *)mt_popToRootViewControllerAnimated:(BOOL)animated {
//    
//    if(![self isKindOfClass:NSClassFromString(@"MTNavigationController")])
//        return [self mt_popToRootViewControllerAnimated:animated];
//    
//    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(transitionNeedDisplay:)];
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    [CATransaction setCompletionBlock:^{
//        [displayLink invalidate];
//        displayLink = nil;
//        mtPushDisplayCount = 0;
//    }];
//    [CATransaction setAnimationDuration:mtPopDuration];
//    [CATransaction begin];
//    NSArray<UIViewController *> *vcs = [self mt_popToRootViewControllerAnimated:animated];
//    [CATransaction commit];
//    return vcs;
//}
//
//// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
//- (void)transitionNeedDisplay:(CADisplayLink*)displayLink {
//    
//    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
//        mtPushDisplayCount += 1;
//        CGFloat popProgress = [self mtPopProgress];
//        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
//        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
//        
//        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
//    }
//    else
//    {
//        [displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    }
//}
//
//
//#pragma mark - deal the gesture of return
//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
//    __weak typeof (self) weakSelf = self;
//    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
//    if ([coor initiallyInteractive] == YES) {
//        
//        if (@available(iOS 10.0, *)) {
//            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//                __strong typeof (self) pThis = weakSelf;
//                [pThis dealInteractionChanges:context];
//            }];
//        } else {
//            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//                __strong typeof (self) pThis = weakSelf;
//                [pThis dealInteractionChanges:context];
//            }];
//        }
//        return YES;
//    }
//    
//    NSUInteger itemCount = self.navigationBar.items.count;
//    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
//    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
//    [self popToViewController:popToVC animated:YES];
//    return YES;
//}
//
//// deal the gesture of return break off
//- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
//    
//    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
//        UIViewController *vc = [context viewControllerForKey:key];
//        
//        self.navigationBar.backgroundAlpha = vc.navigationBarAlpha;
//    };
//    
//    // after that, cancel the gesture of return
//    if ([context isCancelled] == YES) {
//        double cancelDuration = 0;
//        [UIView animateWithDuration:cancelDuration animations:^{
//            animations(UITransitionContextFromViewControllerKey);
//        }];
//    } else {
//        // after that, finish the gesture of return
//        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
//        [UIView animateWithDuration:finishDuration animations:^{
//            animations(UITransitionContextToViewControllerKey);
//        }];
//    }
//}
//
//- (void)mt_updateInteractiveTransition:(CGFloat)percentComplete {
//    
//    if(![self isKindOfClass:NSClassFromString(@"MTNavigationController")])
//        return;
//    
//    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
//        
//    [self mt_updateInteractiveTransition:percentComplete];
//}
//
//- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
//{
//    if([fromVC isKindOfClass:[UITabBarController class]] || [fromVC isKindOfClass:[UINavigationController class]])
//        return;
//    
//    if([NSStringFromClass([fromVC class]) containsString:@"TZ"])
//        return;
//    
//    
//    // change navBarTintColor
//    self.navigationBar.ignoreTranslucentBarTintColor = [self middleColor:fromVC.ignoreTranslucentBarTintColor toColor:toVC.ignoreTranslucentBarTintColor percent:progress];
//    
//    // change navBar _UIBarBackground alpha
//    self.navigationBar.backgroundAlpha = [self middleAlpha: fromVC.navigationBarAlpha toAlpha :toVC.navigationBarAlpha percent:progress];    
//}
//
//
//
//- (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
//    CGFloat fromRed = 0;
//    CGFloat fromGreen = 0;
//    CGFloat fromBlue = 0;
//    CGFloat fromAlpha = 0;
//    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
//    
//    CGFloat toRed = 0;
//    CGFloat toGreen = 0;
//    CGFloat toBlue = 0;
//    CGFloat toAlpha = 0;
//    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
//    
//    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
//    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
//    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
//    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
//    
//    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
//}
//
//- (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
//    return fromAlpha + (toAlpha - fromAlpha) * percent;
//}
//
//@end
//
//
//
//
//
//
