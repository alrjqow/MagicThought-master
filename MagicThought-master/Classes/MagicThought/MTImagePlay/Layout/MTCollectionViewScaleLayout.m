//
//  MTCollectionViewScaleLayout.m
//  DaYiProject
//
//  Created by monda on 2019/4/19.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTCollectionViewScaleLayout.h"

@implementation MTCollectionViewScaleLayout

-(instancetype)init
{
    if(self = [super init])
    {
        self.scaleFactor = 0.5;
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.itemSize = self.collectionView.frame.size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];

    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attributes  in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / self.collectionView.width);
        CGFloat zoom = 1 - self.scaleFactor  * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y + zoom, attributes.size.width, attributes.size.height);
//        if (true) {
//           attributes.alpha = zoom;
//        }
        attributes.center = CGPointMake(attributes.center.x, self.collectionView.center.y + zoom);

    }
    return array;
}

//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
//    //屏幕中线
//    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
//    //刷新cell缩放
//    for (UICollectionViewLayoutAttributes *attributes in arr) {
//        CGFloat distance = fabs(attributes.center.x - centerX);
//        //移动的距离和屏幕宽度的的比例
//        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
//        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
//        CGFloat scale = fabs(cos(apartScale * M_PI/4));
//        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
//        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
//    }
//    return arr;
//}

//防止报错 先复制attributes

- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

//是否需要重新计算布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
