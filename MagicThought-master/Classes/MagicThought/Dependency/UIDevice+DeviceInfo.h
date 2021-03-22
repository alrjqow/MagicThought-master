//
//  UIDevice+DeviceInfo.h
//  8kqw
//
//  Created by 王奕聪 on 2017/9/9.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIDevice (DeviceInfo)

/**获取是何种设备*/
+(NSString*) appleDevice;

+(NSString*)iosVersion;

+(CGFloat)iosVersionNumber;

/**机身码*/
+(NSString*)UUID;

+ (BOOL)isIphoneX;

/**是否刘海屏*/
+ (BOOL)isHairScreen;

+(NSString*)iPhoneScreen;

+(CGFloat)adjustFloatAccordingToScreen:(NSArray<NSNumber*>*)arr;

@end
