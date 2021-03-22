//
//  UITextField+Word.h
//  8kqw
//
//  Created by 王奕聪 on 2017/5/8.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTWordStyle.h"
#import "MTConst.h"

@interface UITextField (Word)

-(instancetype)setWordWithStyle:(MTWordStyle*)style;

-(instancetype)setPlaceholderWithStyle:(MTWordStyle *)placeholderStyle;


@end
