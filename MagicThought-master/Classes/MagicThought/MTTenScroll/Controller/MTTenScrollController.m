//
//  MTTenScrollController.m
//  Demo
//
//  Created by monda on 2019/8/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTTenScrollController.h"

@interface MTTenScrollController ()



@end

@implementation MTTenScrollController

#pragma mark - 生命周期

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件


#pragma mark - 成员方法


#pragma mark - 代理与数据源


#pragma mark - 懒加载

-(MTTenScrollView *)tenScrollView
{
    if(!_tenScrollView)
    {
        _tenScrollView = [[MTTenScrollView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tenScrollView.mt_tenScrollModel = self.tenScrollModel;
        _tenScrollView.backgroundColor = [UIColor clearColor];
        _tenScrollView.showsVerticalScrollIndicator = false;
        _tenScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;        
        //防止分页漂移
        _tenScrollView.estimatedRowHeight = 0;
        _tenScrollView.estimatedSectionHeaderHeight = 0;
        _tenScrollView.estimatedSectionFooterHeight = 0;
        [_tenScrollView addTarget:self];
        //        在设置代理前设置tableFooterView，上边会出现多余间距，谨记谨记
        _tenScrollView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *))
            _tenScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _tenScrollView;
}

-(MTTenScrollViewX *)tenScrollViewX
{
    if(!_tenScrollViewX)
    {
        _tenScrollViewX = [[MTTenScrollViewX alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _tenScrollViewX.mt_tenScrollModel = self.tenScrollModel;
        _tenScrollViewX.backgroundColor = [UIColor clearColor];
        _tenScrollViewX.showsVerticalScrollIndicator = false;
        [_tenScrollViewX addTarget:self];
        if (@available(iOS 11.0, *))
            _tenScrollViewX.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _tenScrollViewX;
}

-(UIScrollView *)mtListView
{
    return self.tenScrollViewX;
}

-(MTTenScrollModel *)tenScrollModel
{
    if(!_tenScrollModel)
    {
        _tenScrollModel = [MTTenScrollModel new];
        _tenScrollModel.delegate = self;
    }
    
    return _tenScrollModel;
}

-(BOOL)isRemoveMJHeader
{
    return YES;
}

@end




#pragma mark - MTTenScrollListController


@interface MTTenScrollListController ()

@end

@implementation MTTenScrollListController

#pragma mark - 生命周期

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件


#pragma mark - 成员方法


#pragma mark - 代理与数据源


#pragma mark - 懒加载


-(MTDelegateTenScrollView *)delegateTenScrollView
{
    if(!_delegateTenScrollView)
    {
        _delegateTenScrollView = [[MTDelegateTenScrollView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
                
        _delegateTenScrollView.backgroundColor = [UIColor clearColor];
        _delegateTenScrollView.showsVerticalScrollIndicator = false;
        _delegateTenScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _delegateTenScrollView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        //防止分页漂移
        _delegateTenScrollView.estimatedRowHeight = 0;
        _delegateTenScrollView.estimatedSectionHeaderHeight = 0;
        _delegateTenScrollView.estimatedSectionFooterHeight = 0;
        [_delegateTenScrollView addTarget:self];
        //        在设置代理前设置tableFooterView，上边会出现多余间距，谨记谨记
        _delegateTenScrollView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *))
            _delegateTenScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    
    return _delegateTenScrollView;
}

-(MTDelegateTenScrollViewX *)delegateTenScrollViewX
{
    if(!_delegateTenScrollViewX)
    {
        _delegateTenScrollViewX = [[MTDelegateTenScrollViewX alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _delegateTenScrollViewX.backgroundColor = [UIColor clearColor];
        _delegateTenScrollViewX.showsVerticalScrollIndicator = false;
        _delegateTenScrollViewX.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        
        [_delegateTenScrollViewX addTarget:self];
        if (@available(iOS 11.0, *))
            _delegateTenScrollViewX.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _delegateTenScrollViewX;
}

-(UIScrollView *)mtListView
{
//    return self.delegateTenScrollView;
    return self.delegateTenScrollViewX;
}

-(BOOL)isRemoveMJHeader
{
    return YES;
}

-(BOOL)isRemoveMJFooter
{
    return YES;
}

@end
