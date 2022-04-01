//
//  MTImagePlayView.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTDelegateCollectionView.h"
#import "MTCollectionViewScaleLayout.h"
#import "MTCollectionViewScaleLayout2.h"
#import "MTImagePlayViewModel.h"

@interface MTBaseImagePlayView : MTDelegateCollectionView @end

@interface MTImagePlayView : MTBaseImagePlayView

@property (nonatomic,strong) MTImagePlayViewModel* imagePlayViewModel;

@property (nonatomic,strong, readonly) MTCollectionViewScaleLayout* scaleLayout;
@property (nonatomic,strong, readonly) MTCollectionViewScaleLayout2* scaleLayout2;



@end

@interface MTImagePlayScaleLayoutView : MTImagePlayView @end

@interface MTImagePlayScaleLayout2View : MTImagePlayView @end

