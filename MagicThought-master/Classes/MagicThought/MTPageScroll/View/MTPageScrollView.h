//
//  MTPageScrollView.h
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTDelegateTableView.h"
#import "MTDragCollectionView.h"

@interface MTPageScrollView : MTDelegateTableView @end
@interface MTPageScrollListView : MTDelegateTableView @end


@interface MTPageScrollViewX : MTDelegateCollectionView @end
@interface MTPageScrollListViewX : MTDragCollectionView @end




@class MTPageControllModel;
@interface UIScrollView (MTPageControllModel)

@property (nonatomic,weak) MTPageControllModel* mt_pageControllModel;

@end
