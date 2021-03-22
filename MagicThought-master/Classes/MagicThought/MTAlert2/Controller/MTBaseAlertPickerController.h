//
//  MTBaseAlertPickerController.h
//  SimpleProject
//
//  Created by monda on 2019/6/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseAlertGroupController.h"
#import "MTDelegatePickerView.h"


@interface MTBaseAlertPickerController : MTBaseAlertGroupController<UIPickerViewDataSource,MTDelegatePickerViewDelegate>

@property (nonatomic,strong) MTDelegatePickerView* pickerView;


-(NSObject*)getDataForRow:(NSInteger)row forComponent:(NSInteger)component;

@end



