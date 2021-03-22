//
//  MTCollectionViewScaleLayout.h
//  DaYiProject
//
//  Created by monda on 2019/4/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface MTCollectionViewScaleLayout : UICollectionViewFlowLayout

/**缩放系数 数值越大缩放越大 default 0.5*/
@property (nonatomic,assign) CGFloat scaleFactor;


@end
