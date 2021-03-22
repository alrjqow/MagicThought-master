//
//  MTSafariViewController.m
//  MyTool
//
//  Created by 王奕聪 on 2017/4/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTSafariViewController.h"
#import "MTSafariView.h"
#import "UIDevice+DeviceInfo.h"
#import "MTConst.h"
#import "MTCloud.h"
#import "NSString+Exist.h"
#import "objc/runtime.h"

@interface MTSafariViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(assign,nonatomic)BOOL flag;
@property (nonatomic,weak) id<UINavigationControllerDelegate, UIImagePickerControllerDelegate> imagePickerDelegate;

@property(nonatomic,strong) UIButton* back;
@property(nonatomic,strong) UIButton* more;

@property(nonatomic,strong) NSString* titleName;

//此值用于与UINavigationController+PushWebVC建立联系
@property(nonatomic,assign) BOOL isWait;

@property(nonatomic,assign) BOOL isGoBack;

@end

@implementation MTSafariViewController


-(UIButton *)more
{
    if(!_more)
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"MTSafariViewController.bundle/more"]   forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(doMore) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        
        _more = btn;
    }
    
    return _more;
}

-(UIButton *)back
{
    if(!_back)
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"MTSafariViewController.bundle/return"]   forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backUp) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if(@available(iOS 11.0, *))
            btn.frame = CGRectMake(0, 0, 40, 50);
        else
        {
            btn.frame = CGRectMake(0, 0, 50, 50);
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        }

        
        _back = btn;
    }
    return _back;
}

-(void)setUrl:(NSString *)url
{
    if(_url)
    {
        _url = url;
        [self loadH5];
    }
    else
        _url = url;
}

-(void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    
    self.title = titleName;
    if(!self.navigationItem.titleView)
    {
        UILabel* label = [[UILabel alloc] init];
        label.text = titleName;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        self.navigationItem.titleView = label;
    }
    else
    {
        UILabel* label = (UILabel*)self.navigationItem.titleView;
        label.text = titleName;
        [label sizeToFit];
    }
}

-(MTSafariView *)webView
{
    if(!_webView)
    {
        WKWebViewConfiguration*  config = WKWebViewConfiguration.new;
        config.userContentController = [self safariViewUserContentController];
                
        CGFloat topInset = [self valueForKey:@"navigationBarAlpha"] ? kNavigationBarHeight_mt() : 0;
        _webView = [[MTSafariView alloc] initWithFrame:CGRectMake(0, topInset, mt_ScreenW(), mt_ScreenH() - topInset) configuration:config];
        
        _webView.multipleTouchEnabled=YES;
        _webView.scrollView.showsVerticalScrollIndicator = false;
        _webView.scrollView.showsHorizontalScrollIndicator = false;
    }
    
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,[self valueForKey:@"navigationBarAlpha"] ? kNavigationBarHeight_mt() : 0, self.view.frame.size.width, 0)];
      
        progressView.tintColor = [UIColor orangeColor];
        progressView.trackTintColor = [UIColor clearColor];
        _progressView = progressView;
    }
    return _progressView;
}

-(WKUserContentController*)safariViewUserContentController
{
    return WKUserContentController.new;
}

-(void)setHideRightBtn:(BOOL)hideRightBtn
{
    _hideRightBtn = hideRightBtn;
    
    self.more.hidden = hideRightBtn;
}

-(void)setHideleftBtn:(BOOL)hideleftBtn
{
    _hideleftBtn = hideleftBtn;
    
    self.back.hidden = hideleftBtn;
}

-(void)setScriptDelegate:(MTViewController* )scriptDelegate
{
    [self whenDealloc];
    
    _scriptDelegate = scriptDelegate;
    
    [[MTCloud shareCloud] setObject:self forKey:scriptDelegate];
    [self.safariViewUserContentController addScriptMessageHandler:(id<WKScriptMessageHandler>)scriptDelegate name:@"iOSHandler"];
}


#pragma mark - 生命周期

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(userContentController:didReceiveScriptMessage:),
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"mt_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

-(void)dealloc
{
    self.webView.scrollView.delegate = nil;
    
    if(self.isShowProgressBar)
       [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [self deleteWebCache];
    [self whenDealloc];
    NSLog(@"webView死亡");
}

-(void)whenDealloc
{
    if(self.scriptDelegate)
        [[MTCloud shareCloud] removeObjectForKey:self.scriptDelegate];
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:@"iOSHandler"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupWebView];
    [self setupNavigationItem];

    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    
    if(self.isWait)
        self.isWait = false;
    else
        [self loadH5];
}

#pragma mark - 初始化

-(instancetype)init
{
    if(self = [super init])
    {
        self.loadWebTitle = YES;
    }
    
    return self;
}

-(void)setupWebView
{
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    [self.view addSubview:self.webView];
    if(self.isShowProgressBar)
    {
        [self.view addSubview:self.progressView];
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)setupNavigationItem
{
    //证明是根控制器，或者没导航控制器
    if((!self.navigationController && !self.isWait) || (self.navigationController.childViewControllers[0] == self && !self.showBarButtonInRoot))
        return;
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.back]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.more];
}

#pragma mark 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
//            [self.progressView setProgress:newprogress animated:YES];
        }
        else
        {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - 点击

#pragma mark - 布局子控件

#pragma mark - 成员方法

-(void)evaluateJavaScript:(WKWebView *)webView
{
    
}

-(void)didFinishNavigation:(WKNavigation *)navigation
{
    
}

-(BOOL)isPopSelf
{
    return false;
}

-(BOOL)isHasSpecificLink
{
    return false;
}

-(void)loadH5
{
    if(!self.url.length || self.isWait) return;
    
    [self.view showMsg:@"正在加载..."];
    [self.webView loadRequest:[self loadSpecialRequest]];
}

-(NSURLRequest*)loadSpecialRequest
{      NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50.0];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    return request;
}

-(void)doMore
{
    if(self.hideRightBtn) return;
    if(self.doMoreWhenTapRight)
        self.doMoreWhenTapRight();
}

-(void)backUp
{
    if(self.hideleftBtn) return;
    if(self.doMoreWhenTapLeft && !self.doMoreWhenTapLeft()) return;
    if([self isHasSpecificLink]) return;
    
    
    if(![self.webView canGoBack])
    {
        if(self.tabBarController.navigationController && self.navigationController.childViewControllers[0] == self)
            [self.tabBarController.navigationController popViewControllerAnimated:YES];
        else
            [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if([self isPopSelf])
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    self.isGoBack = YES;
    [self.webView goBack];
}

-(void)goBack
{    
    if([self.webView canGoBack])
        [self.webView goBack];
    else
        [super goBack];
}

-(void)setupLeftButtonWithTitle:(NSString*)title Image:(NSString*)image ForState:(UIControlState)state
{
    [self setupBarButton:self.back WithTitle:title Image:image ForState:state];
}

-(void)setupRightButtonWithTitle:(NSString*)title Image:(NSString*)image ForState:(UIControlState)state
{
    [self setupBarButton:self.more WithTitle:title Image:image ForState:state];
}

-(void)setupBarButton:(UIButton*)btn WithTitle:(NSString*)title Image:(NSString*)image ForState:(UIControlState)state
{
    if(![title isExist] && ![image isExist]) return;
    
    [btn setTitle:title forState:state];
    [btn setImage:[UIImage imageNamed:image] forState:state];
    [btn sizeToFit];
}


#pragma mark - JS原生交互

-(void)mt_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    id scriptDelegate = [[MTCloud shareCloud] objectForKey:self];
    
    if(!scriptDelegate)
        [self mt_userContentController:userContentController didReceiveScriptMessage:message];
    else if([scriptDelegate isKindOfClass:[MTSafariViewController class]])
        [(MTSafariViewController*)scriptDelegate mt_userContentController:userContentController didReceiveScriptMessage:message];
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}


#pragma mark - 代理


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if([webView.URL.absoluteString containsString:@"tel:"])
    {
        NSURL* url = [NSURL URLWithString:[webView.URL.absoluteString stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        if([[UIApplication sharedApplication] canOpenURL:url])
            [[UIApplication sharedApplication] openURL:url];
        
        [self.view dismissIndicator];
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.view dismissIndicator];
    
    if(self.loadWebTitle)
        self.titleName = webView.title;
    
    NSLog(@"webView.title %@",webView.title);
   
    [self makeCookiesForeverAfterFinishNavigation:webView];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self.view showError:@"加载出错啦"];
//    [self webView:webView didFailNavigation:navigation withError:error];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"网页错误%@",error);
    
    if(self.isGoBack)
    {
        [self.view dismissIndicator];
        self.isGoBack = false;
        return;
    }
    [self.view showError:@"加载出错啦"];
}



// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"发送请求");
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"接收到服务器跳转请求");
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    }

    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - cookies持久化

-(void)makeCookiesForeverAfterFinishNavigation:(WKWebView *)webView
{
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString = @"function setCookie(name,value,expires)\{\ var oDate=new Date();\ oDate.setDate(oDate.getDate()+expires);\ document.cookie=name+'='+value+';expires='+oDate+';path=/'\ }\ function getCookie(name)\ {\ var arr = document.cookie.match(new RegExp('(^| )'+name+'=({FNXX==XXFN}*)(;|$)'));\ if(arr != null) return unescape(arr[2]); return null;\ }\ function delCookie(name)\ {\ var exp = new Date();\ exp.setTime(exp.getTime() - 1);\ var cval=getCookie(name);\ if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\ }";
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
        
    }
    //执行js
    [webView evaluateJavaScript:JSCookieString completionHandler:^(id obj, NSError * _Nullable error) {
        //        NSLog(@"%@",error);
        //        NSLog(@"===%@",obj);
    }];
}


- (void)deleteWebCache {
    
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        ]];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
            
        }];
    }
    else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]; NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"]; NSError *errors; [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}



#pragma mark - 解决两次dissmiss的问题

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    self.flag = ([viewControllerToPresent isKindOfClass:[UIDocumentMenuViewController class]] || [viewControllerToPresent isKindOfClass:[UIDocumentPickerViewController class]]
                 || [viewControllerToPresent isKindOfClass:[UIImagePickerController class]]);
    
    if([viewControllerToPresent isKindOfClass:[UIImagePickerController class]])
    {
        UIImagePickerController* vc = (UIImagePickerController*)viewControllerToPresent;
        self.imagePickerDelegate = vc.delegate;
        vc.delegate = self;
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    
    if(self.flag)
        return;
    
    [super dismissViewControllerAnimated:flag completion:completion];
}


#pragma mark - imagePickerController代理

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerController *,id> *)info
{
    self.flag = false;
    [self.imagePickerDelegate imagePickerController:picker didFinishPickingMediaWithInfo:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.flag = false;
    [self.imagePickerDelegate imagePickerControllerDidCancel:picker];
}


@end
