//
//  MTImagePlayViewCell.h
//  8kqw
//
//  Created by 王奕聪 on 2017/4/7.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTDelegateCollectionViewCell.h"

@interface MTImagePlayViewCell : MTDelegateCollectionViewCell

@property(nonatomic,weak) UIImageView* imgView;

@property(nonatomic,strong) NSString* imgURL;


@end
