//
//  MTPageTitleControllModel.m
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageTitleControllModel.h"
#import "NSObject+ReuseIdentifier.h"

@implementation MTPageTitleControllModel

#pragma mark - 生命周期

-(instancetype)init
{
    if(self = [super init])
    {                
        self.titleViewHeight = 80;                
    }
    
    return self;
}

#pragma mark - 懒加载

-(MTWordStyle *)normalStyle
{
    if(!_normalStyle)
    {
        _normalStyle = mt_WordStyleMake(14, @"", [UIColor blackColor]);
    }
    
    return _normalStyle;
}

-(MTWordStyle *)selectedStyle
{
    if(!_selectedStyle)
    {
        _selectedStyle = mt_WordStyleMake(18, @"", hex(0x2976f4)).bold(YES);
    }
    
    return _selectedStyle;
}

-(UIColor *)bottomLineColor
{
    if(!_bottomLineColor)
    {
        _bottomLineColor = hex(0x2976f4);
    }
    
    return _bottomLineColor;
}

-(UIColor *)titleViewBgColor
{
    if(!_titleViewBgColor)
    {
        _titleViewBgColor = [UIColor whiteColor];
    }
    
    return _titleViewBgColor;
}

-(MTDataSourceModel *)dataSourceModel
{
    if(!_dataSourceModel)
    {
        _dataSourceModel = [MTDataSourceModel new];
        _dataSourceModel.sectionList = @[mt_empty().bindSpacing(mt_collectionViewSpacingMake(self.padding, self.padding, UIEdgeInsetsZero))];
    }
    
    return _dataSourceModel;
}

@end
