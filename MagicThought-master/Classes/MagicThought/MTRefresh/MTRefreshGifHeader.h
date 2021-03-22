//
//  MTRefreshGifHeader.h
//  MonDaProject
//
//  Created by monda on 2018/6/15.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MJRefreshGifHeader.h"
#import "MTInitProtocol.h"

@interface MTRefreshGifHeader : MJRefreshGifHeader<MTInitProtocol>

@property (nonatomic,strong) NSString* loadingIcon;

@property (nonatomic,assign) CGFloat headerHeight;

@end


