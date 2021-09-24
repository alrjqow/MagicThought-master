//
//  MTServiceModel.m
//  AFNetworking
//
//  Created by monda on 2021/1/18.
//

#import "MTServiceModel.h"

@implementation MTServiceModel

-(instancetype)setWithObject:(NSObject *)obj
{
    [super setWithObject:obj];
    
    if([obj isKindOfClass:[UIViewController class]])
        _viewController = (UIViewController*)obj;
    
    if([obj isKindOfClass:[MTViewController class]])
    {
        _controller = (MTViewController*)obj;
        _transitionController = _controller;
    }
    
    if([obj isKindOfClass:[MTBaseListController class]])
        _listController = (MTBaseListController*)obj;
    
    if([obj isKindOfClass:[MTHeaderRefreshListController class]])
        _headerListController = (MTHeaderRefreshListController*)obj;
    
    if([obj isKindOfClass:[MTHeaderFooterRefreshListController class]])
        _headerFooterRefreshListController = (MTHeaderFooterRefreshListController*)obj;
    
    if([obj isKindOfClass:[MTPageSumController class]])
        _pageSumController = (MTPageSumController*)obj;
    
    if([obj isKindOfClass:[MTPageScrollListController class]])
    {
        _pageScrollListController = (MTPageScrollListController*)obj;
        _transitionController = _pageScrollListController.pageSumController;
    }
                
    if([obj isKindOfClass:[MTBaseAlertController class]])
        _alertController = (MTBaseAlertController*)obj;
    
    if([obj isKindOfClass:[UIView class]])
        _view = (UIView*)obj;
    
    [self setupDefault];
    return self;
}

-(void)loadData
{
    [self.controller loadData];
}

-(UIViewController *)showNoMsgController
{
    return [self.viewController showMsg:nil];
}

@end
