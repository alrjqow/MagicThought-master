//
//  MTBaseListController.h
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTViewController.h"
#import "MTDelegateTableView.h"
#import "MTDragCollectionView.h"
#import "MTConst.h"
#import "MJRefresh.h"


@interface MTBaseListController : MTViewController<MTDelegateViewDataProtocol, UIScrollViewDelegate>

/**懒加载，默认不添加到父级*/
@property (nonatomic, strong) MTDelegateTableView *mtBase_tableView;
@property (nonatomic, strong) MTDragCollectionView *mtBase_collectionView;
/**默认为 mtBase_tableView*/
@property (nonatomic, strong, readonly) UIScrollView *mtListView;

/**使用数据源所有高度之和作为列表高度*/
@property (nonatomic,assign, readonly) BOOL adjustListViewHeightByData;


@property (nonatomic,strong, readonly) NSArray* realDataList;

@property (nonatomic,strong, readonly) NSArray* realTenScrollDataList;

@property (nonatomic,strong, readonly) NSArray* realSectionList;

@property (nonatomic,strong, readonly) NSObject* realEmptyData;


/* MTDataSourceModel 类类名，该类用于将 controller 中通用的数据抽离放在一起，避免在 controller 中写重复的数据源*/
@property (nonatomic,strong, readonly) NSString* dataModelClassName;


@property (nonatomic,strong, readonly) UICollectionViewFlowLayout* collectionViewFlowLayout;
-(UICollectionViewFlowLayout*)createCollectionViewFlowLayout;

@end


