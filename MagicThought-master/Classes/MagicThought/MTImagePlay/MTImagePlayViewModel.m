//
//  MTImagePlayViewModel.m
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImagePlayViewModel.h"
#import "UIView+Frame.h"

@interface MTImagePlayViewModel ()

@property (nonatomic,weak) UICollectionView* collectionView;

@property(nonatomic,strong) NSTimer* timer;

@property (nonatomic,assign) NSInteger tag;

/**当前索引*/
@property (nonatomic,assign) NSInteger currentPage;

/**数量与倍数*/
@property(nonatomic,assign) NSInteger dataCount;
@property(nonatomic,assign) NSInteger dataTimes;

/**是否关闭自动滚动*/
@property (nonatomic,assign) BOOL isStopTimer;

/**滚动间隔*/
@property(nonatomic,assign) CGFloat scrollTime;

/**是否滚动有限*/
@property (nonatomic,assign) BOOL isScrollLimit;

@end

@implementation MTImagePlayViewModel

-(void)setupDefault
{
    [super setupDefault];
    
    self.dataTimes = 100;
    self.scrollTime = 3.0;
    
    [self.collectionView addTarget:self];        
}

#pragma mark - 设置计时器
-(void)setupTimer
{
    if(self.isStopTimer)
        return;
    
    [self stopTimer];
    if(self.dataCount <= 1) return;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextPage
{
    self.collectionView.tag ++;
    if(self.isScrollLimit && self.collectionView.tag >= self.dataCount)
        self.collectionView.tag = 0;
        
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] animated:YES];
        
    self.currentPage = self.collectionView.tag % self.dataCount;
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 滚动完重置位置

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath  animated:(BOOL)animated
{    
    [self.collectionView scrollToItemAtIndexPath: indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    
//    [self.collectionView setContentOffset:CGPointMake(indexPath.row * self.collectionView.width, 0) animated:animated];
}

-(void)resetPosition
{
    if(self.isScrollLimit)
        return;
    
    NSInteger row = self.dataCount > 1 ? self.dataCount * self.dataTimes * 0.5 + self.currentPage : 0;
    self.collectionView.tag = row;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:false];
}

#pragma mark - collectionView数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.isScrollLimit)
        return self.dataCount;
    return self.dataCount > 1 ? self.dataCount * self.dataTimes : self.dataCount;
}

#pragma mark - 代理_处理当拖拽开始与结束时,停止与开启定时器

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        CGFloat indexFloat = scrollView.offsetX / scrollView.width;
        NSInteger index = indexFloat;
        self.currentPage = (index + ((indexFloat - index) > 0.5 ? 1 : 0)) % self.dataCount;
        
        [self resetPosition];
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat indexFloat = scrollView.offsetX / scrollView.width;
    NSInteger index = indexFloat;
    self.currentPage = (index + ((indexFloat - index) > 0.5 ? 1 : 0)) % (self.dataCount > 0 ? self.dataCount : 1);
    
    [self resetPosition];
    [self setupTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetPosition];
}

#pragma mark - 代理

-(void)doSomeThingForMe:(id)obj withOrder:(NSString *)order
{
//    if(self.collectionView.tag >= self.dataCount)
//        return;
    if([order isEqualToString:@"MTDataSourceReloadDataAfterOrder"])
    {
           self.tag = 1;
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] animated:false];
           [self setupTimer];
    }
    else if([order isEqualToString:@"layoutSubviews"])
    {
        if(self.tag)
        {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] animated:false];
            self.tag = 0;
        }
    }
}

- (void)didSetDataList:(NSArray*)dataList
{
    BOOL isAllArr = YES;
    for (NSObject* object in dataList) {
        if([object isKindOfClass:[NSArray class]])
            continue;
        
        isAllArr = false;
        break;
    }
    
    NSArray* arr = isAllArr ? (NSArray*)[dataList getDataByIndex:0] : dataList;
    if([arr isKindOfClass:[NSArray class]])
        self.dataCount = arr.count;
    else
        self.dataCount = 0;
    
    if(!self.isScrollLimit)
        self.collectionView.tag = self.dataCount > 1 ? self.dataCount * self.dataTimes * 0.5 : 0;
}

#pragma mark - 其他

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    
    if(self.pageChange)
        self.pageChange(currentPage);
}

-(void)dealloc
{
    [self stopTimer];
}

-(void)whenGetResponseObject:(NSObject *)object
{
    if(![object isKindOfClass:[UICollectionView class]])
        return;
    
    self.collectionView = (UICollectionView*)object;
}





@end
