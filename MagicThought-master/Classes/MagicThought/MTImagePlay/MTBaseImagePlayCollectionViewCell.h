//
//  MTBaseImagePlayCollectionViewCell.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/3/31.
//

#import "MTBaseCollectionViewCell.h"
#import "MTImagePlayView.h"
#import "MTDataSourceModel.h"
#import "MTPageControl.h"


@interface MTBaseImagePlayCollectionViewCell : MTBaseCollectionViewCell

@property (nonatomic,strong) UICollectionViewLayout* imagePlayViewLayout;
@property (nonatomic,strong) MTImagePlayView* imagePlayView;

@property (nonatomic,strong) MTPageControl* pageControl;

@property (nonatomic,strong) MTDataSourceModel* dataSourceModel;

@property (nonatomic,assign, readonly) NSInteger maxPageCount;
@property (nonatomic,assign, readonly) NSInteger currentPageCount;

@end

