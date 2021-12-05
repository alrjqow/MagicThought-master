//
//  MTHeaderFooterRefreshListController.h
//  MDKit
//
//  Created by monda on 2019/5/17.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTHeaderRefreshListController.h"
#import "MTRefreshBackNormalFooter.h"
#import "MTPageInfoModel.h"

#define propertyModelArray(className) \
-(NSMutableArray<className*> *)modelArray \
{return [super modelArray];}

@interface MTHeaderFooterRefreshListController : MTHeaderRefreshListController

@property (nonatomic,assign) NSInteger startPage;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) NSMutableArray* modelArray;

@property (nonatomic,strong) MJRefreshFooter<MJRefreshFooterProtocol>* mj_footer;

@property (nonatomic,copy) MTBlock mj_footer_Block;

@property (nonatomic,strong) MTPageInfoModel* infoModel;

@property (nonatomic,assign, readonly) BOOL isRemoveMJFooter;

@property (nonatomic,strong, readonly) Class footerClass;

@end



