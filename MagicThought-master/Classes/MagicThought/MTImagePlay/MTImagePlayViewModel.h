//
//  MTImagePlayViewModel.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UIView+Delegate.h"

@interface MTImagePlayViewModel : NSObject<MTViewModelProtocol>

@property (nonatomic,copy) void (^pageChange)(NSInteger currentPage);

@end

