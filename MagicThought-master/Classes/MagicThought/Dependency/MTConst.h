//
//  MTConst.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//


#import <UIKit/UIKit.h>

#if !defined(MT_EXTERN)
#  if defined(__cplusplus)
#   define MT_EXTERN extern "C"
#  else
#   define MT_EXTERN extern
#  endif
#endif

#define half(a) ((a) / 2)
#define doubles(a) ((a) * 2)


#define MT_iPhone4s CGSizeMake(320, 480)
#define MT_iPhone5s CGSizeMake(320, 568)
#define MT_iPhone6s CGSizeMake(375,667)
#define MT_iPhone6sP CGSizeMake(414,736)

typedef void (^MTBlock) (void);
typedef void (^MTBlockWithObject) (id);

typedef BOOL (^MTBOOLBlock) (void);
typedef BOOL (^MTBOOLBlockWithObject) (id);

typedef NSInteger (^MTIntegerBlock) (void);
typedef NSInteger (^MTIntegerBlockWithObject) (id);

typedef CGFloat (^MTFloatBlock) (void);
typedef CGFloat (^MTFloatBlockWithObject) (id);

typedef id (^MTObjectBlock) (void);
typedef id (^MTObjectBlockWithObject) (id);

//判断是几位整数
MT_EXTERN NSInteger numberCount(NSInteger number);

//设置token
MT_EXTERN NSString* UserToken_mt(void);
MT_EXTERN void setUserToken_mt(NSString* token);

//设置登录账号
MT_EXTERN NSString* UserAccount_mt(void);
MT_EXTERN void setUserAccount_mt(NSString* account);

//检验登录状态
MT_EXTERN BOOL UserLoginStatus_mt(void);
MT_EXTERN void setLoginStatus_mt(BOOL status);

//四舍五入
MT_EXTERN CGFloat mt_roundFloat(CGFloat floatValue);

MT_EXTERN CGFloat kStatusBarHeight_mt(void);

MT_EXTERN CGFloat kNavigationBarHeight_mt(void);

MT_EXTERN CGFloat kTabBarHeight_mt(void);
MT_EXTERN CGFloat kTabBarBottomInset_mt(void);

MT_EXTERN CGFloat kScreenWidth_mt(void);

MT_EXTERN CGFloat kScreenHeight_mt(void);



MT_EXTERN NSString* mt_IphoneScreen(void);

MT_EXTERN BOOL mt_IPhoneSmallScreen(void);
MT_EXTERN BOOL mt_IPhoneScreen_3P5(void);
MT_EXTERN BOOL mt_IPhoneScreen_4P0(void);

MT_EXTERN BOOL mt_IPhoneScreen_4P7(void);
MT_EXTERN BOOL mt_IPhoneScreen_4P7_BigMode(void);

MT_EXTERN BOOL mt_IPhoneScreen_5P5(void);
MT_EXTERN BOOL mt_IPhoneScreen_5P5_BigMode(void);

MT_EXTERN BOOL mt_IPhoneScreen_5P8(void);
MT_EXTERN BOOL mt_IPhoneScreen_5P8_BigMode(void);

MT_EXTERN UIColor* rgb(NSInteger r, NSInteger g, NSInteger b);
MT_EXTERN UIColor* rgba(NSInteger r, NSInteger g, NSInteger b, CGFloat alpha);




MT_EXTERN UIColor* hex(NSInteger colorValue);
MT_EXTERN UIColor* hexa(NSInteger colorValue, CGFloat alpha);

MT_EXTERN UIFont* mt_font(NSInteger size);

/**一周的时间*/
MT_EXTERN NSInteger MTWeekTime;
/**一天的时间*/
MT_EXTERN NSInteger MTDayTime;

MT_EXTERN NSString*  mt_userInfoPath(void);
MT_EXTERN NSString*  mt_dataCachePath(void);
MT_EXTERN NSString*  mt_cachePath(void);
MT_EXTERN NSString*  mt_documentPath(void);
MT_EXTERN NSString*  mt_libraryPath(void);

MT_EXTERN NSString*  mt_AppVersion(void);
MT_EXTERN NSString*  mt_AppBulid(void);
MT_EXTERN NSString*  mt_AppName(void);
MT_EXTERN NSString* mt_BundleID(void);
MT_EXTERN void mt_GoToAppStore(void);
MT_EXTERN void mt_PostNotification(NSString* notificationName, NSDictionary* userInfo);
MT_EXTERN void mt_PostNotificationWithObject(NSString* notificationName, id object);

MT_EXTERN CGFloat mt_ScreenW(void);
MT_EXTERN CGFloat mt_ScreenH(void);
MT_EXTERN UIWindow* mt_Window(void);
MT_EXTERN UIViewController* mt_rootViewController(void);

MT_EXTERN CGFloat mt_iOSVersion(void);

MT_EXTERN BOOL MTDidReceiveMemoryWarning;

MT_EXTERN NSString*  MTUpdateLocationFinishNotification;
MT_EXTERN NSString*  MTUpdatePositionFinishNotification;
MT_EXTERN NSString*  MTShadowHideNotification;
MT_EXTERN NSString*  MTExitTime;
MT_EXTERN NSString*  MTReachability;


MT_EXTERN NSString*  MTGetPhotoFromAlbumOrder;
MT_EXTERN NSString*  MTGetPhotoFromCameraOrder;
MT_EXTERN NSString* MTTextValueChangeOrder;


//app的数字ID
MT_EXTERN NSString* mt_appleStoreID;

/**产品型号*/
MT_EXTERN NSString *const Device_Simulator;

MT_EXTERN NSString *const Device_AirPods1;
MT_EXTERN NSString *const Device_AirPods2;
MT_EXTERN NSString *const Device_AirPodsPro1;

MT_EXTERN NSString *const Device_AppleTV2;
MT_EXTERN NSString *const Device_AppleTV3;
MT_EXTERN NSString *const Device_AppleTV4;
MT_EXTERN NSString *const Device_AppleTV4K;

MT_EXTERN NSString *const Device_AppleWatch1;
MT_EXTERN NSString *const Device_AppleWatchSeries1;
MT_EXTERN NSString *const Device_AppleWatchSeries2;
MT_EXTERN NSString *const Device_AppleWatchSeries3;
MT_EXTERN NSString *const Device_AppleWatchSeries4;
MT_EXTERN NSString *const Device_AppleWatchSeries5;

MT_EXTERN NSString *const Device_HomePod1;

MT_EXTERN NSString *const Device_iPodTouch1;
MT_EXTERN NSString *const Device_iPodTouch2;
MT_EXTERN NSString *const Device_iPodTouch3;
MT_EXTERN NSString *const Device_iPodTouch4;
MT_EXTERN NSString *const Device_iPodTouch5;
MT_EXTERN NSString *const Device_iPodTouch6;
MT_EXTERN NSString *const Device_iPodTouch7;

MT_EXTERN NSString *const Device_iPad1;
MT_EXTERN NSString *const Device_iPad2;
MT_EXTERN NSString *const Device_iPad3;
MT_EXTERN NSString *const Device_iPad4;
MT_EXTERN NSString *const Device_iPad5;
MT_EXTERN NSString *const Device_iPad6;
MT_EXTERN NSString *const Device_iPad7;
MT_EXTERN NSString *const Device_iPadAir1;
MT_EXTERN NSString *const Device_iPadAir2;
MT_EXTERN NSString *const Device_iPadAir3;
MT_EXTERN NSString *const Device_iPadPro1;
MT_EXTERN NSString *const Device_iPadProMax1;
MT_EXTERN NSString *const Device_iPadPro2;
MT_EXTERN NSString *const Device_iPadProMax2;
MT_EXTERN NSString *const Device_iPadPro3;
MT_EXTERN NSString *const Device_iPadProMax3;
MT_EXTERN NSString *const Device_iPadPro4;
MT_EXTERN NSString *const Device_iPadProMax4;
MT_EXTERN NSString *const Device_iPadMini1;
MT_EXTERN NSString *const Device_iPadMini2;
MT_EXTERN NSString *const Device_iPadMini3;
MT_EXTERN NSString *const Device_iPadMini4;
MT_EXTERN NSString *const Device_iPadMini5;

MT_EXTERN NSString *const Device_iPhone1;
MT_EXTERN NSString *const Device_iPhone3G;
MT_EXTERN NSString *const Device_iPhone3GS;
MT_EXTERN NSString *const Device_iPhone4;
MT_EXTERN NSString *const Device_iPhone4S;
MT_EXTERN NSString *const Device_iPhone5;
MT_EXTERN NSString *const Device_iPhone5S;
MT_EXTERN NSString *const Device_iPhone5C;
MT_EXTERN NSString *const Device_iPhone6;
MT_EXTERN NSString *const Device_iPhone6Plus;
MT_EXTERN NSString *const Device_iPhone6S;
MT_EXTERN NSString *const Device_iPhone6SPlus;
MT_EXTERN NSString *const Device_iPhoneSE;
MT_EXTERN NSString *const Device_iPhoneSE2;
MT_EXTERN NSString *const Device_iPhone7;
MT_EXTERN NSString *const Device_iPhone7Plus;
MT_EXTERN NSString *const Device_iPhone8;
MT_EXTERN NSString *const Device_iPhone8Plus;
MT_EXTERN NSString *const Device_iPhoneX;
MT_EXTERN NSString *const Device_iPhoneXS;
MT_EXTERN NSString *const Device_iPhoneXR;
MT_EXTERN NSString *const Device_iPhoneXSMax;
MT_EXTERN NSString *const Device_iPhone11;
MT_EXTERN NSString *const Device_iPhone11Pro;
MT_EXTERN NSString *const Device_iPhone11ProMax;

MT_EXTERN NSString *const IPhoneScreen_3P5;
MT_EXTERN NSString *const IPhoneScreen_4P0;
MT_EXTERN NSString *const IPhoneScreen_4P7;
MT_EXTERN NSString *const IPhoneScreen_4P7_BigMode;
MT_EXTERN NSString *const IPhoneScreen_5P5;
MT_EXTERN NSString *const IPhoneScreen_5P5_BigMode;
MT_EXTERN NSString *const IPhoneScreen_5P8;
MT_EXTERN NSString *const IPhoneScreen_5P8_BigMode;
MT_EXTERN NSString *const IPhoneScreen_6P1;
MT_EXTERN NSString *const IPhoneScreen_6P5;



MT_EXTERN NSString *const Device_Unrecognized;

