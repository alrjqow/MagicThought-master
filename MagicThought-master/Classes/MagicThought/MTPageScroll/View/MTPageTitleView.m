//
//  MTPageTitleView.m
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageTitleView.h"
#import "MTCloud.h"

@implementation MTPageTitleView

-(void)setupDefault
{
    [super setupDefault];
    
    self.scrollsToTop = false;
    self.backgroundColor = [UIColor clearColor];
    
    if (@available(iOS 11.0, *)) {
         self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     }
          
     self.showsVerticalScrollIndicator = false;
     self.showsHorizontalScrollIndicator = false;
     self.clipsToBounds = false;
     self.bounces = false;
     
     if([MTCloud shareCloud].currentViewController.navigationController)
         [self.panGestureRecognizer requireGestureRecognizerToFail:[MTCloud shareCloud].currentViewController.navigationController.interactivePopGestureRecognizer];
     [self addSubview:self.bottomLine];
     [self addTarget:self EmptyData:nil DataList:nil SectionList:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self sendSubviewToBack:self.bottomLine];
    
    self.bottomLine.maxY = self.height -  - self.pageControllModel.titleControllModel.bottomLineBottomMargin;
}


#pragma mark - 懒加载

+(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return layout;
}

-(UIImageView *)bottomLine
{
    if(!_bottomLine)
    {
        _bottomLine = [UIImageView new];
        _bottomLine.height = 2;
    }
    
    return _bottomLine;
}

@end

@implementation MTPageTitleCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    self.textLabel.center = self.contentView.center;
}

@end
