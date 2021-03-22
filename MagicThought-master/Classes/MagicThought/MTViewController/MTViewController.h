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

@class MTBaseDataModel;
@protocol MTDelegateProtocol;

@interface MTViewController : UIViewController<MTDelegateProtocol, WKScriptMessageHandler>

@property (nonatomic,copy) void (^block)(id object);
@property (nonatomic,copy) void (^initBlock)(id object);

@property (nonatomic,strong) NSString* order;

/**是否加入 [MTCloud shareCloud].currentViewController */
@property (nonatomic,assign) BOOL isNotCurrentController;

/**判断视图的可见性*/
@property(nonatomic,assign) BOOL isVisible;

/**判断视图的是否已加载*/
@property (nonatomic,assign, readonly) BOOL isViewDidLoad;

/**是否第一次请求成功*/
@property (nonatomic,assign) BOOL isFirstRequestSuccess;

/**结束刷新黑名单*/
@property (nonatomic,strong) NSDictionary* endRefreshBlackList;

/**想要pop到的Controller*/
@property (nonatomic,weak) UIViewController* popToController;

/**pop到根部*/
@property (nonatomic,assign) BOOL isPopToRoot;

/**返回页面*/
-(void)goBack;



@end
