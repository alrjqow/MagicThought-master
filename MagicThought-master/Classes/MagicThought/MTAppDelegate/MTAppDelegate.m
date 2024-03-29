//
//  MTAppDelegate.m
//  QXProject
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTAppDelegate.h"
#import "MTAlert.h"
#import "MTConst.h"
#import "NSString+Exist.h"
#import "MTCloud.h"
#import "VKCssProtocol.h"

@interface MTAppDelegate ()


@end

@implementation MTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self setValue:@(YES) forKey:@"isOnlineTag"];
        
    [self setValue:@(YES) forKey:@"isSimuLatorShow"];    
    
    //设置异常监听
//    [self configExceptionHandle];
       
    //设置第三方库信息
    [self configThirdPartyLibrary];
    
    //配置项目架构
    [self configProjectArchitecture];
    
    //配置网路请求
    [self configNetwork];
    
    //设置样式
    [self configViewStyle];
    
    //设置弹窗样式
    [self configMTCloud];
    
    [self setupDefault];
    
    self.windowNum = 0;
   
    return YES;
}

/// 在这里写支持的旋转方向，为了防止横屏方向，应用启动时候界面变为横屏模式
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 可以这么写
    if (self.allowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

//设置登录数据源
- (void)configLoginData{}

//设置注册数据源
- (void)configRegisterData:(MTLoginServiceModel*)registerServiceModel{}

//设置忘记密码数据源
- (void)configForgetPasswordData:(MTLoginServiceModel*)forgetPasswordServiceModel{}

//设置第三方库信息
- (void)configThirdPartyLibrary{}

//配置网路请求
- (void)configNetwork{}

//配置项目架构
- (void)configProjectArchitecture{}

//设置样式
-(void)configViewStyle;
{
#if TARGET_IPHONE_SIMULATOR
    if(self.cssFilePath_simulator.length > 0)
    {
        NSString *rootPath = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"projectPath"];
        //本地绝对路径
        NSString *cssPath = [NSString stringWithFormat:@"%@/%@", rootPath, self.cssFilePath_simulator];
        [VKCssHotReloader hotReloaderListenCssPath:cssPath];
        [VKCssHotReloader startHotReloader];
    }
#else
    if([self.cssFilePath isExist])
    {
        @loadPathCss(self.cssFilePath);
    }
    else if([self.cssFileName isExist])
    {
        @loadBundleCss(self.cssFileName);
    }        
#endif
}

//设置弹窗样式
-(void)configMTCloud
{
    [MTCloud shareCloud].alertViewConfigName = self.alertConfigName;
        
    Class apiManagerClassName = NSClassFromString(self.apiManagerName);
    if([apiManagerClassName isSubclassOfClass:[NSObject class]])
      [MTCloud shareCloud].apiManager = apiManagerClassName.new;
}

/**去登录*/
-(void)goToLogin{}

-(void)loginSuccess:(NSString*)token
{
    setUserToken_mt(token);
    self.tabBarController = nil;
    self.windowNum = MTAppDelegateWindowNumMain;
}

-(void)logoutSuccess
{
    setUserToken_mt(nil);
    self.windowNum = MTAppDelegateWindowNumLogin;    
}

+ (instancetype)sharedDefault
{
    id d = [UIApplication sharedApplication].delegate;    
    if(![d isKindOfClass:[MTAppDelegate class]])
        return nil;
    
    return (MTAppDelegate*)d;
}


#pragma mark - 异常处理理
- (void)configExceptionHandle
{
    // 捕获所有异常
        NSSetUncaughtExceptionHandler(gloablException);
    //    [JJException configExceptionCategory:JJExceptionGuardAll];
    //    [JJException startGuardException];
    //    [JJException registerExceptionHandle:self];
    //    JJException.exceptionWhenTerminate = YES;
}

/**
 统一捕获异常
 
 @param exception 异常信息
 */
void gloablException(NSException * exception) {
    
#ifdef DEBUG
    // 异常信息打印
    NSLog(@"异常信息:\n%@", exception);
    NSLog(@"异常堆栈信息:\n %@", [exception callStackSymbols]);
    
#else
    
    // TODO: 可以直接将 exception 中的所有信息发到服务器.
    
#endif
    
    // 重启        
    [[MTAppDelegate sharedDefault] handleCrashException:@"" extraInfo:nil];
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}

- (void)handleCrashException:(nonnull NSString *)exceptionMessage extraInfo:(nullable NSDictionary *)info {
                
}

- (void)doSomeThingForMe:(id)obj withOrder:(NSString *)order {
    if([order isEqualToString:@"MTAlertExitAppOrder"]) {
        exit(0);
    }
}


#pragma mark - 懒加载

-(UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    
    return _window;
}

-(UIViewController *)rootViewController
{
    switch (self.windowNum) {
        case MTAppDelegateWindowNumMain:
            return self.tabBarController;
                        
        default:
            return [UserToken_mt() isExist] ? self.tabBarController : self.loginController;            
    }
    return nil;
}

-(void)setWindowNum:(NSInteger)windowNum
{
    _windowNum = windowNum;
    
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
}

-(BOOL)isOnline{return [[self valueForKey:@"isOnlineTag"] boolValue];}

-(MTNavigationController *)loginController
{
    if(!_loginController)
    {
        Class loginClass = NSClassFromString(self.loginClassName ? self.loginClassName : @"MTLoginController");
                
        if(![loginClass isSubclassOfClass:NSClassFromString(@"MTViewController")])
            loginClass = NSClassFromString(@"MTViewController");
            
        _loginController = [[MTNavigationController alloc] initWithRootViewController:loginClass.new];
        self.loginServiceModel.bindTag(kIsLogin);
        
        //设置登录数据源
        [self configLoginData];
    }
    
    return _loginController;
}

-(MTTabBarController *)tabBarController
{
    if(!_tabBarController)
    {
        Class tabBarClass = NSClassFromString(self.tabBarClassName ? self.tabBarClassName : @"MTTabBarController");
                
        if(![tabBarClass isSubclassOfClass:NSClassFromString(@"MTTabBarController")])
            tabBarClass = NSClassFromString(@"MTTabBarController");
            
        _tabBarController = tabBarClass.new;
    }
    
    return _tabBarController;
}

-(MTLoginServiceModel *)loginServiceModel
{
    if(!_loginServiceModel)
        _loginServiceModel = MTLoginServiceModel.new;
        
    MTLoginServiceModel * loginServiceModel = [self.loginController.childViewControllers.firstObject valueForKey:@"loginServiceModel"];
    
    return [loginServiceModel isKindOfClass:MTLoginServiceModel.class] ? loginServiceModel : _loginServiceModel;
}

@end
