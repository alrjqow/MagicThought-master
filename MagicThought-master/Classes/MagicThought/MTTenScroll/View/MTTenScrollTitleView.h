//
//  MTTenScrollTitleView.h
//  DaYiProject
//
//  Created by monda on 2018/12/19.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDelegateCollectionView.h"
#import "MTDelegateCollectionViewCell.h"

@class MTTenScrollModel;
@interface MTTenScrollTitleView : MTDelegateCollectionView<MTDelegateProtocol,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) MTTenScrollModel* model;

@property (nonatomic,strong) UIImageView* bottomLine;

@end


@interface MTTenScrollTitleCell : MTDelegateCollectionViewCell

@property (nonatomic,strong) UILabel* title;

@property (nonatomic,weak) MTTenScrollModel* model;

@end
