//
//  MTSafariView.h
//  MyTool
//
//  Created by 王奕聪 on 2017/4/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface MTSafariView : WKWebView

+(void)clearCache;


-(WKNavigation *)loadRequest:(NSURLRequest *)request Cookies:(NSString*)cookie
__attribute__((deprecated("过期方法，请勿用")));

@property(nonatomic,copy) void (^doSomethingWhenTap) (UITapGestureRecognizer*);



@end
