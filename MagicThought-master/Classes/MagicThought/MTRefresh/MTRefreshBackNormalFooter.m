//
//  MTRefreshBackNormalFooter.m
//  DaYiProject
//
//  Created by monda on 2019/4/22.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTRefreshBackNormalFooter.h"
#import "UIView+Frame.h"
#import "MTConst.h"


@implementation MTRefreshBackNormalFooter

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview
{    
    self.stateLabel.textColor = hex(0x666666);
    
    [self setTitle:@"下拉查看更多" forState:MJRefreshStateIdle];
    [self setTitle:@"已无更多数据" forState:MJRefreshStateNoMoreData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = 80;

    [self.stateLabel sizeToFit];
    self.stateLabel.centerX = self.centerX;
    self.stateLabel.y = self.halfHeight - self.stateLabel.halfHeight - 3;
}

- (void)setupDefault{}



@end


@implementation MTRefreshAutoNormalFooter

-(instancetype)init
{
    if(self = [super init])
    {
        [self setupSubView];
    }
    
    return self;
}

+(instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MTRefreshAutoNormalFooter* footer = [super footerWithRefreshingTarget:target refreshingAction:action];
    [footer setupSubView];
    
    return footer;
}

+(instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MTRefreshAutoNormalFooter* footer = [super footerWithRefreshingBlock:refreshingBlock];
    [footer setupSubView];
    
    return footer;
}

-(void)setupSubView
{
    self.stateLabel.textColor = hex(0x666666);
    
    [self setTitle:@"下拉查看更多" forState:MJRefreshStateIdle];
    [self setTitle:@"已无更多数据" forState:MJRefreshStateNoMoreData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = 80;

    [self.stateLabel sizeToFit];
    self.stateLabel.centerX = self.centerX;
    self.stateLabel.y = self.halfHeight - self.stateLabel.halfHeight - 3;
}

- (void)setupDefault{}



@end


