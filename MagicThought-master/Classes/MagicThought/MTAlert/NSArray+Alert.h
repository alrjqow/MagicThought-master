//
//  NSArray+Alert.h
//  QXProject
//
//  Created by monda on 2019/12/11.
//  Copyright © 2019 monda. All rights reserved.
//


#import <Foundation/Foundation.h>

@class MTAlertViewConfig;
typedef void (^Alert) (void);

@interface NSObject (Alert)

@property (nonatomic,copy,readonly) Alert _Nonnull alert_mt;
@property (nonatomic,copy,readonly) MTAlertViewConfig* _Nonnull alertConfig;

@end


extern NSObject* _Nullable appTitle_mtAlert(void);
extern NSObject* _Nullable title_mtAlert(NSObject* _Nullable object);
extern NSObject* _Nullable logo_mtAlert(NSObject* _Nullable object);
extern NSObject* _Nullable content_mtAlert(NSObject* _Nullable object);
extern NSObject* _Nullable buttons_mtAlert(NSObject* _Nullable object);
