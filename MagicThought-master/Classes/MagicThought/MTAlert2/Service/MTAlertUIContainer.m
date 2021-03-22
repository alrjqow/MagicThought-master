//
//  MTAlertUIContainer.m
//  SimpleProject
//
//  Created by monda on 2019/6/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTAlertUIContainer.h"

#import "MTBaseAlertController.h"

#import "UIButton+Word.h"
#import "UIView+Frame.h"

@implementation MTAlertUIContainer

+(void)setUpControllBarOnController:(MTBaseAlertController*)controller Layout:(void (^)(UIButton* cancelBtn, UIButton* enterBtn, UIView* sepLine))layout
{
    UIButton* cancelBtn = [[UIButton new] setWordWithStyle:mt_WordStyleMake(15, @"取消", hex(0x888888))];
    cancelBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0);
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelBtn.frame = CGRectMake(0, 0, 100, 48);
    [cancelBtn addTarget:controller action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* enterBtn = [[UIButton new] setWordWithStyle:mt_WordStyleMake(15, @"确定", hex(0x2976f4))];
    enterBtn.tag = 1;
    enterBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 26);
    enterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    enterBtn.frame = CGRectMake(kScreenWidth_mt() - 100, 0, 100, 48);
    
    
    if([controller respondsToSelector:@selector(enterSelected)])
        [enterBtn addTarget:controller action: [controller isKindOfClass:NSClassFromString(@"MTBaseAlertPickerController")] ? @selector(enterClick) : @selector(enterSelected) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* sepLine = [UIView new];
    sepLine.frame = CGRectMake(0, enterBtn.maxY, kScreenWidth_mt(), 1);
    sepLine.backgroundColor = hex(0xf0f0f0);
    
    [controller.alertView addSubview:cancelBtn];
    [controller.alertView addSubview:enterBtn];
    [controller.alertView addSubview:sepLine];
    
    if(layout)
        layout(cancelBtn, enterBtn, sepLine);
}

@end
