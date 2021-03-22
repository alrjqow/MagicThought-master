//
//  MTBaseAlertCollectionController.m
//  SimpleProject
//
//  Created by monda on 2019/6/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseAlertCollectionController.h"

#import "MTConst.h"
#import "UIView+Frame.h"

@interface MTBaseAlertCollectionController ()

@end

@implementation MTBaseAlertCollectionController

#pragma mark - 生命周期

-(void)setupDefault
{
    [super setupDefault];
    
    self.mtListView.frame = CGRectMake(0, 0, kScreenWidth_mt(), self.alertView.height);
}

-(void)setupSubview
{
    [super setupSubview];
    
    [self.view addSubview:self.mtListView];
}

#pragma mark - 网络回调

#pragma mark - 网络请求

#pragma mark - 重载方法

#pragma mark - 点击事件

#pragma mark - 成员方法

#pragma mark - 代理与数据源

#pragma mark - 懒加载

-(UIScrollView *)mtListView
{
    return self.mtBase_collectionView;
}

@end
