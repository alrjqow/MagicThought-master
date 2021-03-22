//
//  MTImagePlayView0.h
//  8kqw
//
//  Created by 王奕聪 on 2017/4/7.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTDelegateView.h"

extern NSString*  MTImagePlayViewOrder;
@interface MTImagePlayView0 : MTDelegateView

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic)  UIPageControl *pagePoint;

@property (weak, nonatomic, readonly)  UICollectionView *collectionView;

@property (nonatomic,strong) NSString* imagePlayCellClass;

@property (nonatomic, strong) NSArray<NSString*>* imageURLs;

@property(nonatomic,strong) UIImage* placeholderImage;

@property(nonatomic,assign) CGFloat scrollTime;

/**是否滚动有限*/
@property (nonatomic,assign) BOOL isScrollLimit;

/**是否关闭自动滚动*/
@property (nonatomic,assign) BOOL isStopTimer;

@end
