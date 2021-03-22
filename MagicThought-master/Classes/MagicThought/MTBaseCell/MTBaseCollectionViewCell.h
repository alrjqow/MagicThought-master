//
//  MTBaseCollectionViewCell.h
//  SimpleProject
//
//  Created by monda on 2019/5/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDragCollectionViewCell.h"
#import "MTViewContentModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "UIView+Frame.h"
#import "MTTextField.h"
#import "MTTextView.h"

@interface MTBaseCollectionViewCell : MTDragCollectionViewCell<MTTextFieldDelegate>

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

@property (nonatomic,strong) MTTextField* textField;

@property (nonatomic, strong) MTTextView *textView;

@end


@interface MTBaseSubCollectionViewCell : MTBaseCollectionViewCell

@property (nonatomic,strong) UILabel* detailTextLabel4;

@property (nonatomic,strong) UIImageView* imageView5;

@property (nonatomic,strong) UIButton* button5;

@end


@interface MTBaseSubCollectionViewCell2 : MTBaseSubCollectionViewCell

@property (nonatomic,strong) UILabel* detailTextLabel5;

@property (nonatomic,strong) UIImageView* imageView6;

@property (nonatomic,strong) UIButton* button6;

@end

@interface MTBaseSubCollectionViewCell3 : MTBaseSubCollectionViewCell2

@property (nonatomic,strong) UILabel* detailTextLabel6;
@property (nonatomic,strong) UILabel* detailTextLabel7;
@property (nonatomic,strong) UILabel* detailTextLabel8;

@property (nonatomic,strong) UIImageView* imageView7;
@property (nonatomic,strong) UIImageView* imageView8;
@property (nonatomic,strong) UIImageView* imageView9;

@property (nonatomic,strong) UIButton* button7;
@property (nonatomic,strong) UIButton* button8;
@property (nonatomic,strong) UIButton* button9;


@end
