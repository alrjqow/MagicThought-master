//
//  MTPageScrollBaseViewModel.h
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UIView+Delegate.h"
#import "MTPageControllModel.h"

@interface MTPageScrollBaseViewModel : NSObject<MTViewModelProtocol>

@property (nonatomic,weak) MTPageControllModel* model;

@end

