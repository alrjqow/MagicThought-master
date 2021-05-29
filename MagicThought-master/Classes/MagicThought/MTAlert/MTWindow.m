//
//  MTWindow.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTWindow.h"
#import "UIView+MTBackground.h"

@interface MTWindow() @end

@implementation MTWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        self.windowLevel = UIWindowLevelStatusBar + 1;
    
    return self;
}

+ (MTWindow  *)sharedWindow
{
    static MTWindow *window;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        window = [[MTWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.rootViewController = [UIViewController new];
    });
    
    return window;
}

- (UIView *)attachView
{
    return self.rootViewController.view;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{    
    return touch.view == self.attachView.mt_BackgroundView;    
}

@end
