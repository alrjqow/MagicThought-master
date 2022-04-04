//
//  MTPopTipServiceModel.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import "MTPopTipServiceModel.h"
#import "MTDelegateCollectionView.h"


@interface MTPopTipServiceModel ()
{
    PopTip* _popTip;
}

@property (nonatomic,strong) MTDelegateCollectionView* collectionView;

@end

@implementation MTPopTipServiceModel

-(instancetype)init
{
    if(self = [super init])
    {
        self.direction = PopTipDirectionAuto;
    }
    
    return self;
}

-(void)showPopTips
{
    [self.popTip showWithCustomView:self.collectionView direction:self.direction in:mt_Window() from:self.fromRect];
}

-(void)dismissPopTips
{
    [self.popTip hideWithForced:false];
}

-(void)setPopViewSize:(CGSize)popViewSize
{
    _popViewSize = popViewSize;
    
    self.collectionView.frame = CGRectMake(0, 0, popViewSize.width, popViewSize.height);
}

-(void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    
    [self.collectionView reloadDataWithDataList:dataList];
}

-(PopTip *)popTip
{
    if(!_popTip)
    {
        _popTip = PopTip.new;
        
        _popTip.shouldDismissOnTap = false;
        _popTip.shouldDismissOnTapOutside = true;
        _popTip.shouldDismissOnSwipeOutside = false;
        _popTip.shouldShowMask = true;
        _popTip.bubbleColor = [UIColor whiteColor];
        _popTip.cornerRadius = 10;
//        _popTip.arrowSize = CGSizeZero;
        _popTip.padding = 0;
        _popTip.edgeInsets = UIEdgeInsetsZero;
        _popTip.edgeMargin = 16;
        _popTip.offset = 10;
    }
    
    return _popTip;
}

-(MTDelegateCollectionView *)collectionView
{
    if(!_collectionView)
    {
        _collectionView = [MTDelegateCollectionView new];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.bounces = false;
        [_collectionView addTarget:self];
        if (@available(iOS 11.0, *))
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

@end
