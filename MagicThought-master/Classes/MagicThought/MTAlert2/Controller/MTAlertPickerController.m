//
//  MTAlertPickerController.m
//  SimpleProject
//
//  Created by monda on 2019/6/11.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTAlertPickerController.h"

#import "MTAlertUIContainer.h"

#import "UIView+Frame.h"

#import "MTConst.h"

@interface MTAlertPickerController ()

@end

@implementation MTAlertPickerController

#pragma mark - 生命周期

-(void)setupSubview
{
    [super setupSubview];
    
        __weak __typeof(self) weakSelf = self;
    [MTAlertUIContainer setUpControllBarOnController:self Layout:^(UIButton *cancelBtn, UIButton *enterBtn, UIView *sepLine) {
       
        weakSelf.pickerView.frame = CGRectMake(0, sepLine.maxY, kScreenWidth_mt(), weakSelf.alertView.height - sepLine.maxY);
    }];
}

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件

#pragma mark - 成员方法


#pragma mark - 代理与数据源


#pragma mark - 懒加载

@end
