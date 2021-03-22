//
//  MTPageScrollCellViewModel.m
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageScrollCellViewModel.h"
#import "MTPageTitleView.h"

#import "UIView+Frame.h"

@interface MTPageScrollCellViewModel ()

@property (nonatomic,weak) UIView* cell;

@property (nonatomic,strong) MTPageTitleView* titleView;

@property (nonatomic,weak) UIView* pageView;

@end

@implementation MTPageScrollCellViewModel

-(void)whenGetResponseObject:(NSObject *)object
{
    if([object isKindOfClass:[UIView class]])
        self.cell = (UIView*)object;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.cell.backgroundColor = [UIColor clearColor];
    self.cell.clipsToBounds = YES;
    [self.cell addSubview:self.titleView];
}

-(void)layoutSubviews
{
    self.titleView.frame = CGRectMake(0, 0, self.cell.width, self.model.titleControllModel.titleViewHeight);
     self.pageView.frame = CGRectMake(0, self.titleView.maxY, self.cell.width, self.cell.height - self.titleView.maxY);
}

#pragma mark - 懒加载

-(void)setModel:(MTPageControllModel *)model
{
    [super setModel:model];
        
    [model setValue:self.titleView forKey:@"pageTitleView"];
    
    [self.pageView removeFromSuperview];
    UIViewController* vc = [model valueForKey:@"pageScrollController"];    
    self.pageView = vc.view;
    [self.cell addSubview:self.pageView];
    
    [self.cell layoutIfNeeded];
}

-(MTPageTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [MTPageTitleView new];
    }
    
    return _titleView;
}

@end
