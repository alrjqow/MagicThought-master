//
//  MTDelegatePickerView.h
//  DaYiProject
//
//  Created by monda on 2018/9/20.
//  Copyright © 2018 monda. All rights reserved.
//

#import "UIView+Delegate.h"

@protocol MTDelegatePickerViewDelegate <UIPickerViewDelegate>

@optional
- (NSString *)pickerView:(UIPickerView *)pickerView titleForData:(id)data ForRow:(NSInteger)row forComponent:(NSInteger)component;

@end

@interface MTDelegatePickerView : UIPickerView

@property (nonatomic,strong) NSString* cellClass;

@property(nonatomic,strong) UIColor* separatorColor;

- (void)addTarget:(id<MTDelegatePickerViewDelegate>)target;

- (void)addTarget:(id<MTDelegatePickerViewDelegate>)target  DataList:(NSArray*)dataList;

- (void)reloadDataWithDataList:(NSArray*)dataList;

-(NSObject*)getDataForRow:(NSInteger)row forComponent:(NSInteger)component;

@end

