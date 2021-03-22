//
//  MTEmptyBaseCell.m
//  SimpleProject
//
//  Created by monda on 2019/5/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTEmptyBaseCell.h"
#import "NSString+Exist.h"
#import "MTLoadingView.h"

@implementation MTEmptyBaseCell

-(void)setContentModel:(MTEmptyBaseCellModel *)contentModel
{
    [super setContentModel:contentModel];
        
    self.loadingView.hidden = contentModel.isAlreadyLoad;
        
    if(contentModel.isAlreadyLoad && [contentModel.mt_order isEqualToString:@"MTBanClickOrder"] && [contentModel.refreshOrder isExist])
        contentModel.mt_click(contentModel.refreshOrder);
}

-(void)setupDefault
{
    [super setupDefault];
        
    self.loadingView.backgroundColor = [UIColor clearColor];
    self.loadingView.hidden = YES;
    [self addSubview:self.loadingView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loadingView.frame = self.bounds;
    
    [self.imageView sizeToFit];
    self.imageView.centerX = self.contentView.centerX;
    
    [self.textLabel sizeToFit];
    self.textLabel.centerX = self.imageView.centerX;
    
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.centerX = self.imageView.centerX;
    
    CGFloat totalHeight = self.imageView.height  + self.textLabel.height + self.detailTextLabel.height + ([self.textLabel.text isExist] ? 30 : 11 );
    CGFloat halfHeight = totalHeight * 0.5;
    CGFloat centerY = self.contentView.centerY;
    
    
    self.loadingView.centerLayoutY = centerY;
    self.imageView.y = centerY - halfHeight;
    self.textLabel.centerY = self.imageView.maxY + 20 + self.textLabel.halfHeight;
    self.detailTextLabel.centerY = ([self.textLabel.text isExist] ? self.textLabel.maxY : (self.imageView.maxY + 1)) + 10 + self.detailTextLabel.halfHeight;
}

-(MTLoadingView *)loadingView
{
    if(!_loadingView)
    {
        _loadingView = [MTLoadingView new];
    }
    
    return _loadingView;
}

-(Class)classOfResponseObject
{
    return [MTEmptyBaseCellModel class];
}

@end


