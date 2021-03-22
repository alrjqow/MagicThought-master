//
//  MTWindow.h
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTWindow : UIWindow

@property (nonatomic, readonly) UIView* attachView;

+ (MTWindow *)sharedWindow;

@end
