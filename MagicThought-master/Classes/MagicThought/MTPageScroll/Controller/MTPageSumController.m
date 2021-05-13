//
//  MTPageSumController.m
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageSumController.h"
#import "MTCloud.h"
#import "MTPageControllModel.h"

@interface MTPageSumController ()

@end

@implementation MTPageSumController

-(void)setupDefault
{
    [super setupDefault];
    
    self.mtListView.scrollsToTop = false;
}

-(void)loadData
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.pageControllModel performSelector:@selector(resetModelData)];
#pragma clang diagnostic pop
    [super loadData];
}

-(MTPageScrollView *)pageScrollView
{
    if(!_pageScrollView)
    {
        _pageScrollView = [[MTPageScrollView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _pageScrollView.mt_pageControllModel = self.pageControllModel;
        _pageScrollView.backgroundColor = [UIColor clearColor];
        _pageScrollView.showsVerticalScrollIndicator = false;
        _pageScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //防止分页漂移
        _pageScrollView.estimatedRowHeight = 0;
        _pageScrollView.estimatedSectionHeaderHeight = 0;
        _pageScrollView.estimatedSectionFooterHeight = 0;
        [_pageScrollView addTarget:self];
        //        在设置代理前设置tableFooterView，上边会出现多余间距，谨记谨记
        _pageScrollView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *))
            _pageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _pageScrollView;
}

-(MTPageScrollViewX *)pageScrollViewX
{
    if(!_pageScrollViewX)
    {
        _pageScrollViewX = [[MTPageScrollViewX alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _pageScrollViewX.mt_pageControllModel = self.pageControllModel;
        _pageScrollViewX.backgroundColor = [UIColor clearColor];
        _pageScrollViewX.showsVerticalScrollIndicator = false;
        [_pageScrollViewX addTarget:self];
        if (@available(iOS 11.0, *))
            _pageScrollViewX.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _pageScrollViewX;
}

-(UIScrollView *)mtListView
{
    return self.pageScrollViewX;
}

- (MTPageControllModel *)pageControllModel
{
    if(!_pageControllModel)
    {
        Class c = NSClassFromString(self.pageControllModelClassName);
        
        _pageControllModel = [c isSubclassOfClass:[MTPageControllModel class]] ? [c.new setWithObject:self] : MTPageControllModel.new(self);
        _pageControllModel.delegate = self;
    }
    
    return _pageControllModel;
}

-(NSString *)pageControllModelClassName
{
    return @"MTPageControllModel";
}

-(BOOL)isRemoveMJHeader
{
    return YES;
}

@end



@implementation MTPageScrollListController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.mtListView.mt_pageControllModel performSelector:@selector(pageScrollListViewWillAppear:) withObject:self.mtListView];
    #pragma clang diagnostic pop    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    #pragma clang diagnostic push
      #pragma clang diagnostic ignored "-Wundeclared-selector"
          [self.mtListView.mt_pageControllModel performSelector:@selector(pageScrollListViewDidAppear:) withObject:self.mtListView];
      #pragma clang diagnostic pop
    self.mtListView.scrollsToTop = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.mtListView.mt_pageControllModel performSelector:@selector(pageScrollListViewDidDisappear:) withObject:self.mtListView];
    #pragma clang diagnostic pop
    
    self.mtListView.scrollsToTop = false;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
        
    [self layoutScrollListView];
    [self loadData];
}

- (void)layoutScrollListView
{
    self.mtListView.frame = self.view.bounds;
}

-(BOOL)navigationBarHidden{return YES;}

-(void)loadData
{
    if(self.isViewDidLoad)
        [super loadData];
}

-(MTPageScrollListView *)pageScrollListView
{
    if(!_pageScrollListView)
    {
        _pageScrollListView = [[MTPageScrollListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _pageScrollListView.backgroundColor = [UIColor clearColor];
        _pageScrollListView.showsVerticalScrollIndicator = false;
        _pageScrollListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _pageScrollListView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        //防止分页漂移
        _pageScrollListView.estimatedRowHeight = 0;
        _pageScrollListView.estimatedSectionHeaderHeight = 0;
        _pageScrollListView.estimatedSectionFooterHeight = 0;
        [_pageScrollListView addTarget:self];
        //        在设置代理前设置tableFooterView，上边会出现多余间距，谨记谨记
        _pageScrollListView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *))
            _pageScrollListView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _pageScrollListView;
}

-(MTPageScrollListViewX *)pageScrollListViewX
{
    if(!_pageScrollListViewX)
    {
        _pageScrollListViewX = [[MTPageScrollListViewX alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _pageScrollListViewX.backgroundColor = [UIColor clearColor];
        _pageScrollListViewX.showsVerticalScrollIndicator = false;
        _pageScrollListViewX.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        
        [_pageScrollListViewX addTarget:self];
        if (@available(iOS 11.0, *))
            _pageScrollListViewX.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _pageScrollListViewX;
}

-(UIScrollView *)mtListView
{
//    return self.delegateTenScrollView;
    return self.pageScrollListViewX;
}

-(BOOL)isRemoveMJHeader
{
    return YES;
}

-(BOOL)isRemoveMJFooter
{
    return YES;
}

/**显示成功*/
-(instancetype)showSuccess:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showSuccess:msg];
    
    [[MTCloud shareCloud].currentViewController.view showSuccess:msg];
    return self;
}

/**显示错误*/
-(instancetype)showError:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showError:msg];
    
    [[MTCloud shareCloud].currentViewController.view showError:msg];
    return self;
}

/**显示提示*/
-(instancetype)showTips:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showTips:msg];
    
    [[MTCloud shareCloud].currentViewController.view showTips:msg];
    return self;
}

/**显示toast*/
-(instancetype)showToast:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showToast:msg];
    
    [[MTCloud shareCloud].currentViewController.view showToast:msg];
    return self;
}

-(instancetype)showCenterToast:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showCenterToast:msg];
    
    [[MTCloud shareCloud].currentViewController.view showCenterToast:msg];
    return self;
}

/**显示圈圈*/
-(instancetype)showMsg:(NSString*)msg
{
    if(self.isUseSelfHud)
        return [super showMsg:msg];
    
    [[MTCloud shareCloud].currentViewController.view showMsg:msg];
    return self;
}

/**隐藏提示*/
-(instancetype)dismissIndicator
{
    if(self.isUseSelfHud)
        return [super dismissIndicator];
    
    [[MTCloud shareCloud].currentViewController.view dismissIndicator];
    return self;
}

#pragma mark - 懒加载
-(void)setMt_hudStyle:(MBHudStyle)mt_hudStyle
{
    if(self.isUseSelfHud)
    {
        [super setMt_hudStyle:mt_hudStyle];
        return;
    }
    
    [MTCloud shareCloud].currentViewController.view.mt_hudStyle = mt_hudStyle;
}

-(MBHudStyle)mt_hudStyle
{
    if(self.isUseSelfHud)
        return [super mt_hudStyle];
    return [MTCloud shareCloud].currentViewController.view.mt_hudStyle;
}


@end

