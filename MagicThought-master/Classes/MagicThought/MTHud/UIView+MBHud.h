//
//  UIView+MBHud.h
//  ActivityIndicator
//
//  Created by 王奕聪 on 2018/2/11.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,MBHudStyle){
    MBHudStyleDefault,//白色调
    MBHudStyleBlack,//黑色调
};

@class MBProgressHUD;

@interface NSObject (MBHud)

@property (nonatomic,assign) MBHudStyle mt_hudStyle;

/**显示成功*/
-(instancetype)showSuccess:(NSString*)msg;

/**显示错误*/
-(instancetype)showError:(NSString*)msg;

/**显示提示*/
-(instancetype)showTips:(NSString*)msg;

/**显示toast*/
-(instancetype)showToast:(NSString*)msg;
-(instancetype)showCenterToast:(NSString*)msg;

/**显示圈圈*/
-(instancetype)showMsg:(NSString*)msg;

/**隐藏提示*/
-(instancetype)dismissIndicator;

@end


