//
//  MTCollectionViewScaleLayout2.h
//  DaYiProject
//
//  Created by monda on 2019/4/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTCollectionViewScaleLayout.h"


@interface MTCollectionViewScaleLayout2 : MTCollectionViewScaleLayout

/**滑动的时候偏移的距离 以倍数计算 default 0.5 正中间*/
@property (nonatomic,assign) CGFloat centerXOffsetScale;
@property (nonatomic,assign) CGFloat centerXOffset;

@end
