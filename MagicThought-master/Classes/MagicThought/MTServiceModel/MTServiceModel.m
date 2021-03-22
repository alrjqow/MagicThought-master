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
    
    if([obj isKindOfClass:[MTViewController class]])
        _controller = (MTViewController*)obj;
    
    if([obj isKindOfClass:[MTBaseListController class]])
        _listController = (MTBaseListController*)obj;
    
    if([obj isKindOfClass:[MTHeaderRefreshListController class]])
        _headerListController = (MTHeaderRefreshListController*)obj;
    
    if([obj isKindOfClass:[MTHeaderFooterRefreshListController class]])
        _headerFooterRefreshListController = (MTHeaderFooterRefreshListController*)obj;
    
    if([obj isKindOfClass:[MTPageSumController class]])
        _pageSumController = (MTPageSumController*)obj;
    
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


@end
