//
//  MTBaseAlertPickerController.m
//  SimpleProject
//
//  Created by monda on 2019/6/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseAlertPickerController.h"

#import "MTConst.h"
#import "UIView+Frame.h"


@interface MTBaseAlertPickerController ()

@end

@implementation MTBaseAlertPickerController

#pragma mark - 生命周期

-(void)setupSubview
{
    [super setupSubview];
    
    self.pickerView.frame = CGRectMake(0, 0, kScreenWidth_mt(), self.alertView.height);
    
    [self.alertView addSubview:self.pickerView];
}

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([self.pickerView isRolling])
        return;
    [super touchesBegan:touches withEvent:event];
}

-(void)enterClick
{
    if([self.pickerView isRolling])
        return;
    
    [self enterSelected];
}

#pragma mark - 成员方法

-(void)loadData
{
    [self.pickerView reloadDataWithDataList:self.dataList];
}

-(NSObject*)getDataForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerView getDataForRow:row forComponent:component];
}

#pragma mark - 代理与数据源


#pragma mark - 懒加载



-(MTDelegatePickerView *)pickerView
{
    if(!_pickerView)
    {
        _pickerView = [MTDelegatePickerView new];
        _pickerView.separatorColor = hex(0xf0f0f0);
        [_pickerView addTarget:self];
        
        //        [_pickerView addTarget:self EmptyData:nil DataList:self.dataArr SectionList:nil];
    }
    
    return _pickerView;
}

@end
