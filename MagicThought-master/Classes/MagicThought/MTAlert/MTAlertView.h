//
//  MTAlertView.h
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTPopView.h"

@class MTAlertViewConfig;
@interface MTAlertView : MTPopView

+ (instancetype) alertWithConfig:(MTAlertViewConfig*)config;

+ (instancetype) alertWithConfig:(MTAlertViewConfig*)config CustomView:(UIView*)customView;

@end
