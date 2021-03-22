//
//  MTLabel.h
//  8kqw
//
//  Created by 王奕聪 on 2017/5/8.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTWordStyle.h"

@interface MTLabel : UILabel

@property(nonatomic,assign) IBInspectable MTVerticalAlignment verticalAlignment;

@property (nonatomic,assign) UIEdgeInsets inset;

@end
