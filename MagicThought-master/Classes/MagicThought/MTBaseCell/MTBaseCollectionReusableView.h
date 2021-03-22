//
//  MTBaseCollectionReusableView.h
//  SimpleProject
//
//  Created by monda on 2019/5/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDelegateCollectionReusableView.h"
#import "MTViewContentModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "UIView+Frame.h"

@interface MTBaseCollectionReusableView : MTDelegateCollectionReusableView

@property (nonatomic,strong) MTViewContentModel* contentModel;

/**扩展*/
@property (nonatomic,strong) UIView* externView;

@property (nonatomic,strong) UILabel* textLabel;

@property (nonatomic,strong) UILabel* detailTextLabel;

@property (nonatomic,strong) UILabel* detailTextLabel2;

@property (nonatomic,strong) UILabel* detailTextLabel3;

@property (nonatomic,strong) UIImageView* imageView;

@property (nonatomic,strong) UIImageView* imageView2;

@property (nonatomic,strong) UIImageView* imageView3;

@property (nonatomic,strong) UIImageView* imageView4;

@property (nonatomic,strong) UIButton* button;

@property (nonatomic,strong) UIButton* button2;

@property (nonatomic,strong) UIButton* button3;

@property (nonatomic,strong) UIButton* button4;

@end



