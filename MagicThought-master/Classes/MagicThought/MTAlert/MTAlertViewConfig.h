//
//  MTAlertViewConfig.h
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTPopViewConfig.h"

@class MTAlertViewButtonConfig;

@interface MTAlertViewConfig : MTPopViewConfig

@property (nonatomic, strong) NSArray<MTBaseViewContentModel*>* buttonModelList;

/*-----------------------------------华丽分割线-----------------------------------*/

@property (nonatomic, assign) CGFloat width;                // Default is kScreenWidth_mt() - 4 * 25.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat innerTopMargin;          // Default is 25.

@property (nonatomic,assign) UIEdgeInsets logoMargin;  // Default is (0, 0, 12, 6).

@property (nonatomic, assign) CGFloat detailInnerMargin;          // Default is 15.

@property (nonatomic, assign) CGFloat splitWidth;          // Default is 1.

-(void)alert;
-(void)hide;

//直接重写样式，不需 super
-(void)setupStyle;

@end


@interface MTAlertViewButtonConfig : MTBaseViewContentStateModel @end
