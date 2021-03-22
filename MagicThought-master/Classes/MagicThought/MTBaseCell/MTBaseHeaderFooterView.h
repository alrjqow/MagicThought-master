//
//  MTBaseHeaderFooterView.h
//  SimpleProject
//
//  Created by monda on 2019/5/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDelegateHeaderFooterView.h"
#import "MTViewContentModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "UIView+Frame.h"
#import "MTTextField.h"
#import "MTTextView.h"

@interface MTBaseHeaderFooterView : MTDelegateHeaderFooterView<MTTextFieldDelegate, UITextViewDelegate>

@property (nonatomic,strong) UIColor* headerFooterViewBackgroundColor;

@property (nonatomic,strong) MTViewContentModel* contentModel;

/**扩展*/
@property (nonatomic,strong) UIView* externView;

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





