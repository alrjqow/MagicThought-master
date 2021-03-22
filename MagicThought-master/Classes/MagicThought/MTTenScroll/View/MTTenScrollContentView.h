//
//  MTTenScrollContentView.h
//  DaYiProject
//
//  Created by monda on 2018/12/4.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDelegateCollectionView.h"

@class MTTenScrollModel;
@interface MTTenScrollContentView : MTDelegateCollectionView

@property (nonatomic,weak) MTTenScrollModel* model;

@end

