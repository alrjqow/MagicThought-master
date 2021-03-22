//
//  MTTextField.h
//  DaYiProject
//
//  Created by monda on 2018/8/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "UIView+Delegate.h"
#import "MTTextVerifyModel.h"

@protocol MTTextFieldDelegate <UITextFieldDelegate>

-(void)didTextValueChange:(UITextField *)textField;

@end

@interface MTTextField : UITextField

@property (nonatomic,strong) MTTextVerifyModel* verifyModel;

@end


