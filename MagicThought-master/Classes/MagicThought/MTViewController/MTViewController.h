//
//  MTViewController.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/28.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "UIView+MBHud.h"
#import "NSObject+CommonProtocol.h"
#import "MTNavigationBar.h"

@class MTBaseDataModel;
@protocol MTDelegateProtocol;

@interface MTViewController : UIViewController<MTDelegateProtocol, WKScriptMessageHandler>

@property (nonatomic,assign) BOOL isLoadResult;

@property (nonatomic,copy) void (^block)(id object);
@property (nonatomic,copy) void (^initBlock)(id object);

/**缺省加载圈*/
-(instancetype)showNoMsg;

@property (nonatomic,strong, readonly) MTNavigationBar* navigationBar;
@property (nonatomic,assign, readonly) BOOL navigationBarHidden;
/**给定类名，生成对应导航栏，默认为 MTNavigationBar*/
@property (nonatomic,strong, readonly) NSString* navigationBarClassName;


@property (nonatomic,strong) UIView* emptyLoadingView;
@property (nonatomic,assign, readonly) BOOL emptyLoadingViewInitHidden;
/**给定类名，生成对应加载页*/
@property (nonatomic,strong, readonly) NSString* emptyLoadingViewClassName;

//是否用白色状态栏
@property (nonatomic,assign, readonly) BOOL isLoadStatusBarLightContent;
//状态栏颜色
-(void)loadStatusBarStyle;


/**是否加入 [MTCloud shareCloud].currentViewController */
@property (nonatomic,assign) BOOL isNotCurrentController;

/**判断视图的可见性*/
@property(nonatomic,assign) BOOL isVisible;
@property(nonatomic,assign) BOOL isDidAppear;

/**判断视图的是否已加载*/
@property (nonatomic,assign, readonly) BOOL isViewDidLoad;

/**想要pop到的Controller*/
@property (nonatomic,weak) UIViewController* popToController;

/**pop到根部*/
@property (nonatomic,assign) BOOL isPopToRoot;

/**返回页面*/
-(void)goBack;


/**接收到登录*/
-(void)didReceiveLogin:(BOOL)isLogin;

@end
