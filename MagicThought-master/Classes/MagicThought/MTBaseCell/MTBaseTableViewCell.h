//
//  MTBaseTableViewCell.h
//  SimpleProject
//
//  Created by monda on 2019/5/8.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDelegateTableViewCell.h"
#import "MTBaseCellModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "UIView+Frame.h"
#import "MTTextField.h"
#import "MTTextView.h"

@interface MTBaseTableViewCell : MTDelegateTableViewCell<MTTextFieldDelegate, UITextViewDelegate>

@property (nonatomic,strong) MTBaseCellModel* contentModel;

/**右箭头*/
@property (nonatomic,strong, readonly) UIImageView* arrowView;

/**扩展*/
@property (nonatomic,strong) UIView* externView;

@property (nonatomic,strong) UILabel* detailTextLabel2;

@property (nonatomic,strong) UILabel* detailTextLabel3;

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


@interface MTNoSepLineBaseCell : MTBaseTableViewCell @end


@interface MTBaseSubTableViewCell : MTBaseTableViewCell

@property (nonatomic,strong) UILabel* detailTextLabel4;

@property (nonatomic,strong) UIImageView* imageView5;

@property (nonatomic,strong) UIButton* button5;


@end

@interface MTBaseSubTableViewCell2 : MTBaseSubTableViewCell

@property (nonatomic,strong) UILabel* detailTextLabel5;

@property (nonatomic,strong) UIImageView* imageView6;

@property (nonatomic,strong) UIButton* button6;


@end



