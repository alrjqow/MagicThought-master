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


@interface MTHeaderFooterRefreshListController : MTHeaderRefreshListController

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) MJRefreshFooter<MJRefreshFooterProtocol>* mj_footer;

@property (nonatomic,copy) MTBlock mj_footer_Block;

@property (nonatomic,strong) MTPageInfoModel* infoModel;

@property (nonatomic,assign, readonly) BOOL isRemoveMJFooter;

@property (nonatomic,strong) NSMutableArray* itemArr;

@property (nonatomic,strong, readonly) Class footerClass;

@end



