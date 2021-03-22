//
//  MTImagePlayView0.m
//  8kqw
//
//  Created by 王奕聪 on 2017/4/7.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTImagePlayView0.h"
#import "MTImagePlayViewCell.h"
#import "MTDelegateProtocol.h"
#import "MTConst.h"
#import "UIView+Frame.h"
#import "NSString+Exist.h"

NSString*  MTImagePlayViewOrder = @"MTImagePlayViewOrder";
@interface MTImagePlayView0()<UICollectionViewDelegate,UICollectionViewDataSource,MTDelegateProtocol>

@property(nonatomic,strong) NSTimer* timer;

@property(nonatomic,assign) NSInteger itemCount;

@end

@implementation MTImagePlayView0

-(void)setImageURLs:(NSArray<NSString *> *)imageURLs
{
    _imageURLs = imageURLs;
    
    [self stopTimer];
    
    self.itemCount = imageURLs.count > 0 ? imageURLs.count : 1;
    self.pagePoint.numberOfPages = self.itemCount;
    self.pagePoint.hidden = self.itemCount <= 1;
    
    if(!self.isScrollLimit)
    self.collectionView.tag = self.itemCount > 1 ? self.itemCount * itemTimes * 0.5 : 0;
    
    self.tag = 1;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    [self setupTimer];
}


-(void)setupDefault
{
    [super setupDefault];
    
    [self setupSubView];
    [self setupTimer];
}

#define ImagePlayViewCell @"MTImagePlayViewCell"
-(void)setupSubView
{
    self.scrollTime = 3.0;
  
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    
    
    if([self.imagePlayCellClass isExist])
    {
        Class class = NSClassFromString(self.imagePlayCellClass);
        if([class isSubclassOfClass:[MTImagePlayViewCell class]])
            [collectionView registerClass:class forCellWithReuseIdentifier:ImagePlayViewCell];
        else
            [collectionView registerClass:[MTImagePlayViewCell class] forCellWithReuseIdentifier:ImagePlayViewCell];
    }
    else
        [collectionView registerClass:[MTImagePlayViewCell class] forCellWithReuseIdentifier:ImagePlayViewCell];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    self.pagePoint.hidden = YES;
    [self addSubview:self.pagePoint];
}

-(void)setupTimer
{
    if(self.isStopTimer)
        return;
    
    [self stopTimer];
    if(self.itemCount <= 1) return;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextPage
{
    self.collectionView.tag ++;
    if(self.isScrollLimit && self.collectionView.tag >= self.itemCount)
        self.collectionView.tag = 0;
        
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.pagePoint.currentPage = (self.pagePoint.currentPage + 1) % self.itemCount;
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)dealloc
{
    [self stopTimer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
            
    self.collectionView.frame = self.bounds;
    
    CGPoint center = self.center;
    center.y = self.height * 0.85;
    self.pagePoint.center = center;
    
    if(self.tag)
    {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        self.tag = 0;
    }
}


-(UIPageControl *)pagePoint
{
    if(!_pagePoint)
    {
        _pagePoint = [UIPageControl new];
    }
    
    return _pagePoint;
}

-(UICollectionViewFlowLayout *)flowLayout
{
    if(!_flowLayout)
    {
        UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _flowLayout = layout;
    }
    
    return _flowLayout;
}

static NSInteger itemTimes = 100;
#pragma mark - collectionView数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.isScrollLimit)
        return self.itemCount;
    return self.itemCount > 1 ? self.itemCount * itemTimes : self.itemCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{        
    MTImagePlayViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImagePlayViewCell forIndexPath:indexPath];
    cell.mt_delegate = self;
    
    cell.imgURL = self.imageURLs.count > 0 ? self.imageURLs[indexPath.row % self.itemCount] : nil;
    return cell;
}

-(void)resetPosition
{
    if(self.isScrollLimit)
        return;
    
    NSInteger row = self.itemCount > 1 ? self.itemCount * itemTimes * 0.5 + self.pagePoint.currentPage : 0;
    self.collectionView.tag = row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        self.pagePoint.currentPage = self.collectionView.tag % self.itemCount;
        [self resetPosition];
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pagePoint.currentPage = self.collectionView.tag % self.itemCount;
    [self resetPosition];
    [self setupTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetPosition];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.imageURLs.count) return;
    if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:withItem:)])
        [self.mt_delegate doSomeThingForMe:self withOrder: MTImagePlayViewOrder withItem:@(indexPath.row % self.itemCount)];
}




@end
