//
//  MTBaseAlertGroupController.m
//  SimpleProject
//
//  Created by monda on 2019/6/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseAlertGroupController.h"

#import "MTConst.h"
#import "UIView+Circle.h"

@interface MTBaseAlertGroupController ()

@end

@implementation MTBaseAlertGroupController

#pragma mark - 生命周期

-(void)initProperty
{
    [super initProperty];
    
    self.type = MTBaseAlertTypeUp;
}

-(void)setupSubview
{
    [super setupSubview];
    
    self.alertView = [UIView new];
    self.alertView.frame = CGRectMake(0, 0, kScreenWidth_mt(), 360);
    self.alertView.backgroundColor = [UIColor whiteColor];
    [self.alertView becomeCircleWithBorder:mt_BorderStyleMake(0, 12, nil).corners(UIRectCornerTopLeft | UIRectCornerTopRight)];
    
    [self.view addSubview:self.alertView];
}

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件


#pragma mark - 成员方法

-(void)enterSelected{}

#pragma mark - 代理与数据源


#pragma mark - 懒加载



@end
