//
//  MTHeaderRefreshListController.h
//  MDKit
//
//  Created by monda on 2019/5/17.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTListController.h"
#import "MTRefreshGifHeader.h"



@interface MTHeaderRefreshListController : MTListController

@property (nonatomic,strong) MJRefreshHeader* mj_header;

@property (nonatomic,copy) MTBlock mj_Block;

@property (nonatomic,assign, readonly) BOOL isRemoveMJHeader;

@property (nonatomic,strong, readonly) Class headerClass;

@end



