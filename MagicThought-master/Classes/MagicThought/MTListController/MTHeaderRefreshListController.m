//
//  MTHeaderRefreshListController.m
//  MDKit
//
//  Created by monda on 2019/5/17.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTHeaderRefreshListController.h"

@interface MTHeaderRefreshListController ()

@end

@implementation MTHeaderRefreshListController

#pragma mark - 懒加载

-(void)setupDefault
{
    [super setupDefault];
    
    if(!self.isRemoveMJHeader)
        self.mtListView.mj_header = self.mj_header;
}

-(void)startRequest
{
    [self.mtListView.mj_header endRefreshing];
}

-(MTBlock)mj_Block
{
    if(!_mj_Block)
    {
        __weak __typeof(self) weakSelf = self;
        _mj_Block = ^{
            
            [weakSelf startRequest];
        };
    }
    
    return _mj_Block;
}

-(MJRefreshHeader *)mj_header
{
    if(!_mj_header)
    {
        __weak __typeof(self) weakSelf = self;
        
        Class headerClass = self.headerClass;
        if(![headerClass isSubclassOfClass:[MJRefreshHeader class]])
            headerClass = [MTRefreshGifHeader class];
        
        MJRefreshHeader* header = [headerClass new];
        header.refreshingBlock = ^{
            if(weakSelf.mj_Block)
                weakSelf.mj_Block();
        };
        _mj_header = header;
    }
    
    return _mj_header;
}

-(Class)headerClass
{
    return MTRefreshGifHeader.class;
}

@end
