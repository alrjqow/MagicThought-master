//
//  MTAppDelegate.h
//  QXProject
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import "NSObject+CommonProtocol.h"
#import "MTNavigationController.h"
#import "MTTabBarController.h"
#import "MTLoginServiceModel.h"

#define RegisterAppDelegate(appDelegate) typedef appDelegate __MTAppDelegate__;

#define RegisterOnline @property (nonatomic, assign) BOOL isOnlineTag;

#define RegisterSimuLatorShowTag @property (nonatomic, assign) BOOL isSimuLatorShow;

typedef enum : NSUInteger {
    MTAppDelegateWindowNumLogin,
    MTAppDelegateWindowNumMain
} MTAppDelegateWindowNum;

@interface MTAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, assign) BOOL allowOrentitaionRotation;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly, strong) UIViewController* rootViewController;
/**重写 rootViewController, 改变 windowNum 值实现窗口切换*/
@property (nonatomic,assign) NSInteger windowNum;


/**mainBundle中css文件名*/
@property (nonatomic,strong) NSString* cssFileName;
/**css文件路径，优先级大于 cssFileName*/
@property (nonatomic,strong) NSString* cssFilePath;
/**模拟器css文件路径*/
@property (nonatomic,strong) NSString* cssFilePath_simulator;

@property (nonatomic,strong, readonly) NSString* loginClassName;
@property (nonatomic,strong) MTNavigationController* loginController;

@property (nonatomic,strong, readonly) NSString* tabBarClassName;
@property (nonatomic,strong) MTTabBarController* tabBarController;

@property (nonatomic,strong) MTLoginServiceModel* loginServiceModel;

/**弹框类名*/
@property (nonatomic,strong, readonly) NSString* alertConfigName;
/**请求干预者类名*/
@property (nonatomic,strong, readonly) NSString* apiManagerName;


@property (nonatomic, readonly, assign) BOOL isOnline;

/**设置第三方库信息*/
- (void)configThirdPartyLibrary;

/**配置网络请求*/
- (void)configNetwork;

/**配置项目架构*/
- (void)configProjectArchitecture;

/**去登录*/
-(void)goToLogin;

+ (instancetype)sharedDefault;

@end

#define AppDelegate_mt [__MTAppDelegate__ sharedDefault]
