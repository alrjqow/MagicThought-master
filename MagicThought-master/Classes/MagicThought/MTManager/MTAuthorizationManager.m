//
//  MTAuthorizationManager.m
//  8kqw
//
//  Created by 王奕聪 on 2017/4/15.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTAuthorizationManager.h"
#import "MTAlertView.h"
#import "NSArray+Alert.h"
#import "MTConst.h"

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <EventKit/EventKit.h>

@implementation MTAuthorizationManager

+(BOOL)haveAuthorizationWith:(MTAuthorizationType)type
{
    NSString* url;
    BOOL haveAuthorization = YES;
    NSString* message;
    
    
    switch (type) {
        case MTAuthorizationTypePhoto:
        {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
            {
                message = @"您还没有开启相册权限，是否开启？";
                haveAuthorization = false;
                //                url = @"prefs:root=Privacy&path=Photos";
            }
            
            break;
        }
            
        case MTAuthorizationTypeCamera:
        {
            AVAuthorizationStatus status =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied)
            {
                message = @"您还没有开启相机权限，是否开启？";
                haveAuthorization = false;
                //                url = @"prefs:root=Privacy&path=CAMERA";
            }
            break;
        }
            
        case MTAuthorizationTypeLocation:
        {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if (![CLLocationManager locationServicesEnabled] || status == kCLAuthorizationStatusRestricted || status ==kCLAuthorizationStatusDenied)
            {
                message = @"您还没有开启定位权限，是否开启？";
                haveAuthorization = false;
                //                url = @"prefs:root=Privacy&path=LOCATION_SERVICES";
            }
        }
            
            break;
            
        case MTAuthorizationTypeMicrophone:
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
            if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied)
            {
                message = @"您还没有开启麦克风权限，是否开启？";
                haveAuthorization = false;
                //                url = @"prefs:root=Privacy&path=MICROPHONE";
            }
        }
            break;
            
        case MTAuthorizationTypeMessagePush:
        {
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
            
            if (UIUserNotificationTypeNone == setting.types)
            {
                message = @"您还没有开启推送权限，是否开启？";
                haveAuthorization = false;
                //                    url = @"prefs:root=Privacy&path=NOTIFICATIONS_ID";
            }
        }
            
            break;
            
        case MTAuthorizationTypeCalendar:
        {
            EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
            if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted){
                message = @"您还没有开启日历权限，是否开启？";
                haveAuthorization = false;
            }
        }
            break;
            
        default:
            break;
    }
    
    
//    if(!haveAuthorization)
//    {
//        __weak __typeof(self) weakSelf = self;
//        @[
//            appTitle_mtAlert(),
//            content_mtAlert(message),
//            buttons_mtAlert(@[
//                @"不开启",
//                @"去开启".bindClick(^(NSString* order)
//                                 {
//                    [weakSelf openSettingWithURL:url];
//                }),
//            ])
//        ].alert_mt();
//    }
    
    return haveAuthorization;
}


+(void)openSettingWithURL:(NSString*)urlStr
{
    NSURL* url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //    NSURL* url = [UIDevice currentDevice].systemVersion.floatValue >= 10 ? [NSURL URLWithString:UIApplicationOpenSettingsURLString] :[NSURL URLWithString:urlStr];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
}

@end
