//
//  MTAuthorizationManager.h
//  8kqw
//
//  Created by 王奕聪 on 2017/4/15.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"

typedef NS_ENUM(NSInteger, MTAuthorizationType) {
    MTAuthorizationTypePhoto,
    MTAuthorizationTypeCamera,
    MTAuthorizationTypeLocation,
    MTAuthorizationTypeMicrophone,
    MTAuthorizationTypeMessagePush,
    MTAuthorizationTypeCalendar
};

@interface MTAuthorizationManager : MTManager

+(BOOL)haveAuthorizationWith:(MTAuthorizationType)type;

@end
