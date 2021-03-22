//
//  MTManager.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/18.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTManager : NSObject

/**管理者单例*/
+(instancetype)manager;

/**清除单例*/
+(void)clear;

@end
