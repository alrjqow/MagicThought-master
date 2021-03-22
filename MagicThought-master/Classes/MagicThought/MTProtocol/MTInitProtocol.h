//
//  MTInitProtocol.h
//  MDKit
//
//  Created by monda on 2019/5/15.
//  Copyright © 2019 monda. All rights reserved.
//


#import <Foundation/Foundation.h>

/**生命周期*/
@protocol MTInitProtocol

-(void)setupDefault;

@optional

/**对象属性初始化*/
-(void)initProperty;

/**设置子控件*/
- (void)setupSubview;

/**初始化tabBar的item*/
-(void)setupTabBarItem;

/**初始化导航栏item*/
-(void)setupNavigationItem;

/**当销毁时*/
-(void)whenDealloc;

/**点击了导航栏右侧按钮*/
-(void)navigationBarRightBtnClick;

/**反向计算父控件高度*/
-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight;

@end


/**请求数据*/
@class MTBaseDataModel;
@protocol MTRequestDataProtocol

@optional

/**加载数据*/
-(void)loadData;

/**请求数据*/
-(void)startRequest;

@end





/**处理通知*/
@protocol MTNotificationProtocol

@optional

/**接收到通知后*/
-(void)whenReceiveNotification:(NSNotification *)info;


@end
