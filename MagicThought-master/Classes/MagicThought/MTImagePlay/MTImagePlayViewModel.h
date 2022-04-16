//
//  MTImagePlayViewModel.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UIView+Delegate.h"

@interface MTImagePlayViewModel : NSObject<MTViewModelProtocol>

@property (nonatomic,assign) BOOL isBase;

/**是否滚动有限*/
@property (nonatomic,assign) BOOL isScrollLimit;

/**是否关闭自动滚动*/
@property (nonatomic,assign) BOOL isStopTimer;

@property (nonatomic,copy) void (^pageChange)(NSInteger currentPage);

@end

