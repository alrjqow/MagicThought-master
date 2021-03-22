//
//  MTDelegateCollectionView.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDelegateCollectionView.h"

@implementation MTDelegateCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if(!layout)
        layout = [self.class layout];
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
                 
        if([layout isKindOfClass:[UICollectionViewFlowLayout class]])
        {
            UICollectionViewFlowLayout* layout0 = (UICollectionViewFlowLayout*)layout;
            self.alwaysBounceVertical= layout0.scrollDirection == UICollectionViewScrollDirectionVertical;
            self.alwaysBounceHorizontal = layout0.scrollDirection == UICollectionViewScrollDirectionHorizontal;
        }
        
        _layout = layout;
        [self setupDefault];
    }
    
    return self;
}


+(UICollectionViewLayout*)layout
{
    return [UICollectionViewFlowLayout new];
}

@end
