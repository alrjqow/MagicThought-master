//
//  MTWindow.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTWindow.h"
#import "MTPopView.h"
#import "UIView+MTBackground.h"

@interface MTWindow()<UIGestureRecognizerDelegate>

@end

@implementation MTWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        gesture.cancelsTouchesInView = NO;
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
    }
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

- (void)actionTap:(UITapGestureRecognizer*)gesture
{
    if (!self.mt_BackgroundAnimating )
    {
        for ( UIView *v in [self attachView].mt_BackgroundView.subviews )
        {
            if ( [v isKindOfClass:[MTPopView class]] )
            {
                MTPopView *popupView = (MTPopView*)v;
                if(popupView.touchWildToHide)
                    [popupView hide];
            }
        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ( touch.view == self.attachView.mt_BackgroundView );
}

- (UIView *)attachView
{
    return self.rootViewController.view;
}


@end
