//
//  MTImagePlayViewModel.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UIView+Delegate.h"

@interface MTImagePlayViewModel : NSObject<MTViewModelProtocol>

/**当前索引*/
@property (nonatomic,assign, readonly) NSInteger currentPage;

@end

