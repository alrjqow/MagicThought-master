//
//  MTEmptyBaseCell.h
//  SimpleProject
//
//  Created by monda on 2019/5/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseTableViewCell.h"


//MTBanClickOrder
///**你必须给你的数据绑定这个 Order，才能切换为你想要的下拉刷新*/
//无数据是空界面
@class MTLoadingView;
@interface MTEmptyBaseCell : MTNoSepLineBaseCell

@property (nonatomic,strong) MTLoadingView* loadingView;


@end





