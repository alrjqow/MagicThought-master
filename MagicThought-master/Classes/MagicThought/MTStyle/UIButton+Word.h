//
//  UIButton+Word.h
//  MyTool
//
//  Created by 王奕聪 on 2017/4/11.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTWordStyle.h"
#import "MTConst.h"

@interface UIButton (Word)

-(instancetype)setWordWithStyle:(MTWordStyle*)style;

-(instancetype)setWordWithStyle:(MTWordStyle*)style State:(UIControlState)state;

@end
