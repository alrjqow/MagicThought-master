//
//  MTDeviceManager.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/20.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"
#import <CoreMotion/CoreMotion.h>

@interface MTDeviceManager : MTManager

@property (nonatomic,strong) CMMotionManager* motionManager;

/**获取屏幕方向, 返回Yes代表终止获取*/
+(void)getOrientationWithHandler:(BOOL (^)(UIDeviceOrientation))handler;

+ (NSInteger)openOrCloseFlash;

/**获取屏幕方向*/
+(void)callMobile:(NSString*)number;

@end
