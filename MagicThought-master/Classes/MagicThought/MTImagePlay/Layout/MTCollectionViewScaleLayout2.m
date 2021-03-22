//
//  MTCollectionViewScaleLayout2.m
//  DaYiProject
//
//  Created by monda on 2019/4/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTCollectionViewScaleLayout2.h"

@implementation MTCollectionViewScaleLayout2

-(instancetype)init
{
    if(self = [super init])
    {
        self.centerXOffsetScale = 0.5;
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
        
    self.minimumInteritemSpacing = 15;
    self.minimumLineSpacing = 15;
    self.itemSize = CGSizeMake(self.collectionView.width * 0.8, self.collectionView.height);
    CGFloat margin = (self.collectionView.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    self.collectionView.pagingEnabled = false;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

/**
 * collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if ([self.collectionView isPagingEnabled]) {
        return proposedContentOffset;
    }
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
  
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * self.centerXOffsetScale + self.centerXOffset;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }

    proposedContentOffset.x += minDelta;

    self.collectionView.tag = round((ABS(proposedContentOffset.x))/(self.itemSize.width+self.minimumLineSpacing));
    
    return proposedContentOffset;
    
}

@end
