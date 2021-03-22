//
//  MTSafariViewController.h
//  MyTool
//
//  Created by 王奕聪 on 2017/4/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "MTViewController.h"

@class MTSafariView;
@interface MTSafariViewController : MTViewController<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) MTViewController* scriptDelegate;

@property (strong, nonatomic)  MTSafariView *webView;

/**进度条*/
@property (nonatomic,strong) UIProgressView* progressView;
@property (nonatomic,assign) BOOL isShowProgressBar;

@property(nonatomic,strong) NSString* url;

/*!
 用于判断是否加载H5的标题，默认加载
 */
@property(nonatomic,assign) BOOL loadWebTitle;

/*!
 用于判断是否隐藏右侧按钮，默认显示
 */
@property(nonatomic,assign) BOOL hideRightBtn;
@property(nonatomic,assign) BOOL hideleftBtn;

/*!
 用于设置根控制器webView是否显示导航栏按钮，默认不显示
 */
@property(nonatomic,assign) BOOL showBarButtonInRoot;

@property(nonatomic,copy) void (^doMoreWhenTapRight)(void);
@property(nonatomic,copy) BOOL (^doMoreWhenTapLeft)(void);

-(void)setupLeftButtonWithTitle:(NSString*)title Image:(NSString*)image ForState:(UIControlState)state;
-(void)setupRightButtonWithTitle:(NSString*)title Image:(NSString*)image ForState:(UIControlState)state;

/**当页面加载完成时做操作*/
-(void)didFinishNavigation:(WKNavigation *)navigation;

/**当页面加载完成时并且可以goback时做操作*/
-(BOOL)isPopSelf;

/**当点击返回声明了特地跳转链接时做操作*/
-(BOOL)isHasSpecificLink;

/**指定特殊请求请求*/
-(NSURLRequest*)loadSpecialRequest;

/**需要注入的脚本控制器*/
-(WKUserContentController*)safariViewUserContentController;

/**注入脚本*/
-(void)evaluateJavaScript:(WKWebView *)webView;



/*-----------------------------------华丽分割线-----------------------------------*/





/**用于设置goback返回时页面会上移64个点的问题*/
@property(nonatomic,assign) BOOL isScrollOffset;



@end
