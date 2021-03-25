//
//  MTPageSumController.h
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTHeaderFooterRefreshListController.h"
#import "MTPageControllModel.h"
#import "MTPageScrollView.h"


@interface MTPageSumController : MTHeaderRefreshListController<MTPageControllModelDelegate>

@property (nonatomic,strong) MTPageScrollView* pageScrollView;
@property (nonatomic,strong) MTPageScrollViewX* pageScrollViewX;

@property (nonatomic,strong) MTPageControllModel* pageControllModel;

@property (nonatomic,strong, readonly) NSString* pageControllModelClassName;

@end

@interface MTPageScrollListController : MTHeaderFooterRefreshListController

@property (nonatomic,assign, readonly) BOOL isUseSelfHud;

@property (nonatomic,strong) MTPageScrollListView* pageScrollListView;
@property (nonatomic,strong) MTPageScrollListViewX* pageScrollListViewX;

- (void)layoutScrollListView;

@end
