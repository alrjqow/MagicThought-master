//
//  MTRefreshBackNormalFooter.h
//  DaYiProject
//
//  Created by monda on 2019/4/22.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MJRefresh.h"
#import "MTInitProtocol.h"

@protocol MJRefreshFooterProtocol <NSObject>

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

@end

@interface MTRefreshBackNormalFooter : MJRefreshBackNormalFooter<MTInitProtocol>

@end

@interface MTRefreshAutoNormalFooter : MJRefreshAutoNormalFooter<MTInitProtocol>

@end


