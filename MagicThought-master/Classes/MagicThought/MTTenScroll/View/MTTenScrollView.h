//
//  MTTenScrollView.h
//  DaYiProject
//
//  Created by monda on 2018/12/26.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDelegateTableView.h"
#import "MTDelegateCollectionView.h"

@class MTTenScrollModel;
@interface UIScrollView (MTTenScrollModel)

@property (nonatomic,weak) MTTenScrollModel* mt_tenScrollModel;

@end



@interface MTTenScrollView : MTDelegateTableView @end

@interface MTDelegateTenScrollView : MTDelegateTableView @end



@interface MTTenScrollViewX : MTDelegateCollectionView @end

@interface MTDelegateTenScrollViewX : MTDelegateCollectionView @end




