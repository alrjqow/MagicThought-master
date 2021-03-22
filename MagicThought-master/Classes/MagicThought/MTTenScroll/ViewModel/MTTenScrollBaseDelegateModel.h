//
//  MTTenScrollBaseDelegateModel.h
//  MagicThought
//
//  Created by monda on 2019/11/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIView+Delegate.h"

@class MTTenScrollModel;
@interface MTTenScrollBaseDelegateModel : NSObject<MTViewModelProtocol>

@property (nonatomic,weak) MTTenScrollModel* model;

@end

