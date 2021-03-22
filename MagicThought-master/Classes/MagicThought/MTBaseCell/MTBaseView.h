//
//  MTBaseView.h
//  QXProject
//
//  Created by monda on 2019/12/10.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDelegateView.h"
#import "MTViewContentModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "UIView+Frame.h"

@interface MTBaseView : MTDelegateView

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


@interface MTBaseSubView : MTBaseView

@property (nonatomic,strong) UILabel* detailTextLabel4;

@property (nonatomic,strong) UIImageView* imageView5;

@property (nonatomic,strong) UIButton* button5;

@end


@interface MTBaseSubView2 : MTBaseSubView

@property (nonatomic,strong) UILabel* detailTextLabel5;

@property (nonatomic,strong) UIImageView* imageView6;

@property (nonatomic,strong) UIButton* button6;

@end
