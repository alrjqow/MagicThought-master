//
//  MTTextView.h
//  8kqw
//
//  Created by 王奕聪 on 2017/8/8.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//


#import "UIView+Delegate.h"
#import "MTTextVerifyModel.h"

@interface MTTextView : UITextView

@property (nonatomic,strong) MTTextVerifyModel* verifyModel;
 
@end
