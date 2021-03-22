//
//  MTDelegateCollectionView.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "UIView+Delegate.h"

@interface MTDelegateCollectionView : UICollectionView

@property (nonatomic,strong, readonly) UICollectionViewLayout * layout;

+(UICollectionViewLayout*)layout;

@end

