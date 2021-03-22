//
//  MTTenScrollViewCellDelegateModel.m
//  MagicThought
//
//  Created by monda on 2019/11/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTTenScrollViewCellDelegateModel.h"

#import "MTTenScrollContentView.h"
#import "MTTenScrollTitleView.h"
#import "MTTenScrollModel.h"

#import "UIView+Frame.h"


@interface MTTenScrollViewCellDelegateModel()

@property (nonatomic,weak) UIView* cell;

@property (nonatomic,strong) MTTenScrollContentView* collectionView;

@property (nonatomic,strong) MTTenScrollTitleView* titleView;

@end

@implementation MTTenScrollViewCellDelegateModel

-(void)whenGetResponseObject:(NSObject *)object
{
    if([object isKindOfClass:[UIView class]])
        self.cell = (UIView*)object;
}

-(void)setupDefault
{    
    [super setupDefault];
    
    self.cell.backgroundColor = [UIColor clearColor];
    [self.cell addSubview:self.collectionView];
    [self.cell addSubview:self.titleView];
}

-(void)giveSomeThingToMe:(id)obj WithOrder:(NSString *)order
{
    UIView* superView = (UIView*)obj;
    
    self.titleView.frame = CGRectMake(0, 0, superView.width, self.model.titleViewModel.titleViewHeight);    
    self.collectionView.frame = CGRectMake(0, self.titleView.maxY, superView.width, superView.height - self.titleView.maxY);
}

#pragma mark - 懒加载

-(void)setModel:(MTTenScrollModel *)model
{
    [super setModel:model];
    
    self.collectionView.model = self.model;
    self.titleView.model = self.model;
}

-(MTTenScrollContentView *)collectionView
{
    if(!_collectionView)
    {
        _collectionView = [MTTenScrollContentView new];
    }
    
    return _collectionView;
}

-(MTTenScrollTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [MTTenScrollTitleView new];
    }
    
    return _titleView;
}



@end
