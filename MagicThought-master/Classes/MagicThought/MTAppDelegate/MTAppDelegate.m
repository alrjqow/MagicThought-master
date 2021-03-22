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
#import "NSArray+Alert.h"
#import "MTAlertViewConfig.h"
#import "MTCloud.h"
#import "VKCssProtocol.h"

@interface MTAppDelegate ()


@end

@implementation MTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //设置异常监听
//    [self configExceptionHandle];
       
    //设置第三方库信息
    [self configThirdPartyLibrary];
    
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

//设置第三方库信息
- (void)configThirdPartyLibrary{}

//配置网路请求
- (void)configNetwork{}

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
                
    MTAlertViewConfig* config =            @[
        appTitle_mtAlert(),
        content_mtAlert(@"出现了一个问题，导致程序停止正常工作。请关闭该程序。"),
        buttons_mtAlert(@"关闭程序")
    ].alertConfig;
    
    config.mtContent.wordStyle.wordLineSpacing = 4;
    config.alert_mt();    
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
    return nil;
}

-(void)setWindowNum:(NSInteger)windowNum
{
    _windowNum = windowNum;
    
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
}

@end
