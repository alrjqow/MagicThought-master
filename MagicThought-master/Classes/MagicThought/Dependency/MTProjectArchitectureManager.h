//
//  MTProjectArchitectureManager.h
//  MagicThought-master
//
//  Created by apple on 2022/3/8.
//

#import "MTManager.h"
#import <UIKit/UIKit.h>

@interface MTProjectArchitectureManager : MTManager

@property (nonatomic,strong) UIColor* baseBackgroundColor;

@property (nonatomic,strong) UIColor* basePageScrollListBackgroundColor;

@property (nonatomic,strong) NSString* baseNavigationBarClassName;

@property (nonatomic,assign) BOOL baseSystemNavigationBarHidden;

@property (nonatomic,assign, readonly) BOOL isOnline;

@property (nonatomic,assign) NSArray<NSString*>* hostNameList;

@property (nonatomic,assign) NSInteger baseFootListStartPage;

@property (nonatomic,strong) NSArray<NSDictionary *>* baseTabBarItemArr;

@property (nonatomic,strong) UIColor* baseNormalColor;

@property (nonatomic,strong) UIColor* baseSelectedColor;

@property (nonatomic,strong) UIFont* baseTabBarFont;

@property (nonatomic,strong) UIColor* baseTabBarColor;

@property (nonatomic,assign) BOOL baseTabBarTranslucent;

@property (nonatomic,strong) void (^baseNavigationBarSetupDefault)(id navigationBar);

@property (nonatomic,strong) NSDictionary* baseHostModelDict;


//登录模块
@property (nonatomic,strong) NSArray* loginDataList;

@property (nonatomic,strong) NSArray* loginSectionList;



@end

extern NSString *const kHostOnlineNum;

extern NSString *const kIsUserPhone;
extern NSString *const kIsPassword;
extern NSString *const kIsVfcode;
extern NSString *const kIsLogin;

#define kArchitectureManager_mt [MTProjectArchitectureManager manager]

