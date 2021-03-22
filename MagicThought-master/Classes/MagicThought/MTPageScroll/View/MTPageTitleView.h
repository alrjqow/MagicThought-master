//
//  MTPageTitleView.h
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTDelegateCollectionView.h"
#import "MTBaseCollectionViewCell.h"
#import "MTPageControllModel.h"

@interface MTPageTitleView : MTDelegateCollectionView<MTDelegateProtocol,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) MTPageControllModel* pageControllModel;

@property (nonatomic,strong) UIView* bottomLine;

@end


@interface MTPageTitleCell : MTBaseCollectionViewCell @end
