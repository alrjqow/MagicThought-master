//
//  MTImagePlayView.m
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImagePlayView.h"


@implementation MTBaseImagePlayView

-(void)setupDefault
{
    [super setupDefault];
    
    self.backgroundColor = [UIColor clearColor];
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    self.alwaysBounceVertical = false;
    self.pagingEnabled = YES;    
    if (@available(iOS 11.0, *))
       self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

+(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    return layout;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if([self.viewModel respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
        [self.viewModel doSomeThingForMe:self withOrder:@"layoutSubviews"];
}


@end

@implementation MTImagePlayView

-(NSString *)viewModelClass
{
    return @"MTImagePlayViewModel";
}

@end

@implementation MTImagePlayScaleLayoutView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    return [super initWithFrame:frame collectionViewLayout:[MTCollectionViewScaleLayout new]];
}

@end

@implementation MTImagePlayScaleLayout2View

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    return [super initWithFrame:frame collectionViewLayout:[MTCollectionViewScaleLayout2 new]];
}

@end


