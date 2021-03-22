//
//  MTAlertDatePickerController.m
//  SimpleProject
//
//  Created by monda on 2019/6/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTAlertDatePickerController.h"

#import "MTConst.h"
#import "MTWordStyle.h"
#import "UILabel+Word.h"
#import "MTTimer.h"


@interface MTAlertDatePickerController ()
{
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
}

/**年*/
@property (nonatomic,strong) NSMutableArray* yearArray;
/**月*/
@property (nonatomic,strong) NSMutableArray* monthArray;
/**日*/
@property (nonatomic,strong) NSMutableArray* dayArray;

/**时间容器，一个包含了详细的年月日时分秒的容器*/
@property (nonatomic, strong) NSDateComponents *comp;

@property (nonatomic,assign) BOOL isLoad;

@end

@implementation MTAlertDatePickerController

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!self.isLoad)
    {
        [self selectActionToPickerView:self.pickerView row:yearIndex inComponent:0];
        [self selectActionToPickerView:self.pickerView row:monthIndex inComponent:1];
        [self selectActionToPickerView:self.pickerView row:dayIndex inComponent:2];
        self.isLoad = YES;
    }
}


-(void)initProperty
{
    [super initProperty];
    
    yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", self.comp.year]];
    monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", self.comp.month]];
    dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", self.comp.day]];
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark - 网络回调

#pragma mark - 网络请求


#pragma mark - 重载方法

#pragma mark - 点击事件

-(void)enterSelected
{
    if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:withItem:)])
        [self.mt_delegate doSomeThingForMe:self withOrder:@"MTAlertDatePickerControllerEnterOrder" withItem:[self getTime]];
    
    [self dismissWithAnimate];
}

#pragma mark - 成员方法

- (BOOL)isleapYear:(NSInteger)year {
    if ((year % 400) == 0) {
        return YES;
    } else if (((year % 100) != 0) && ((year % 4) == 0)) {
        return YES;
    }
    return NO;
}

- (void)selectActionToPickerView:(UIPickerView *)pickerView row:(NSInteger)row inComponent:(NSInteger)inComponent {
    [pickerView selectRow:row inComponent:inComponent animated:YES];
    [self pickerView:pickerView didSelectRow:row inComponent:inComponent];
}

-(NSString*)getTime
{
    NSString *pickerYear = ((UILabel *)[self.pickerView viewForRow:yearIndex forComponent:0]).text;
    NSString *pickerMonth = ((UILabel *)[self.pickerView viewForRow:monthIndex forComponent:1]).text;
    NSString *pickerDay = ((UILabel *)[self.pickerView viewForRow:dayIndex forComponent:2]).text;
    NSString *timeStr = [NSString stringWithFormat:@"%@%@%@", pickerYear, pickerMonth, pickerDay];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    NSLog(@"timeStr:%@", timeStr);
    
    return timeStr;
}

#pragma mark - 代理与数据源


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    } else if(component == 1) {
        // 如果是今年返回当前已过月分数
        if ([self.yearArray[yearIndex] isEqualToString:self.yearArray.lastObject]) {
            return self.comp.month;
        }
        return self.monthArray.count;
    } else {
        // 如果是今年今月返回当前已过天数
        if ([self.yearArray[yearIndex] isEqualToString:self.yearArray.lastObject] && self.comp.month - 1 == monthIndex) {
            return self.comp.day;
        }
        switch (monthIndex + 1) {
            case 2:{
                NSString *pickerYear = ((UILabel *)[pickerView viewForRow:yearIndex forComponent:0]).text;
                // 需要考虑闰年闰月情况
                if ([self isleapYear:[pickerYear integerValue]]) {
                    return 29;
                } else {
                    return 28;
                }
            }
            case 4:
            case 6:
            case 9:
            case 11:
                return 30;
            default:
                return 31;
        }
    }
}

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        yearIndex = row;
        // 重新加载确保是当前年月时不出现多余可选范围
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        // 选择年份时月日超出今日日期则自动滚到今天
        if ([self.yearArray[row] isEqualToString:self.yearArray.lastObject]) {
            if (self.comp.month - 1 < monthIndex) {
                monthIndex = self.comp.month - 1;
                [self selectActionToPickerView:pickerView row:monthIndex inComponent:1];
                
                dayIndex = self.comp.day - 1;
                [self selectActionToPickerView:pickerView row:dayIndex inComponent:2];
            }
            
            if (self.comp.month - 1 == monthIndex && self.comp.day - 1 < dayIndex) {
                dayIndex = self.comp.day - 1;
                [self selectActionToPickerView:pickerView row:dayIndex inComponent:2];
            }
        }
    } else if (component == 1) {
        monthIndex = row;
        // 重新加载确保是当前年月时不出现多余可选范围
        [pickerView reloadComponent:2];
        if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
            if (dayIndex + 1 == 31) {
                dayIndex--;
            }
        } else if (monthIndex + 1 == 2) {
            if (dayIndex + 1 > 28) {
                dayIndex = 27;
            }
        }
        // 选择月份时月日超出今日日期则自动滚到今天
        NSString *pickerYear = ((UILabel *)[pickerView viewForRow:yearIndex forComponent:0]).text;
        if ([pickerYear isEqualToString:self.yearArray.lastObject] && self.comp.month - 1 < monthIndex) {
            monthIndex = self.comp.month - 1;
            dayIndex = self.comp.day - 1;
            [self selectActionToPickerView:pickerView row:monthIndex inComponent:1];
            [self selectActionToPickerView:pickerView row:dayIndex inComponent:2];
        }
        
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
    } else {
        dayIndex = row;
        // 选择日期时超出今日日期则自动滚到今天
        NSString *pickerYear = ((UILabel *)[pickerView viewForRow:yearIndex forComponent:0]).text;
        NSString *pickerMonth = ((UILabel *)[pickerView viewForRow:monthIndex forComponent:1]).text;
        if ([pickerYear isEqualToString:self.yearArray.lastObject] && [pickerMonth isEqualToString:self.monthArray[self.comp.month - 1]] && self.comp.day - 1 < dayIndex) {
            dayIndex = self.comp.day - 1;
            [self selectActionToPickerView:pickerView row:dayIndex inComponent:2];
        }
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
    }
    
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSInteger selectedRow = [pickerView selectedRowInComponent:component];
    
    //设置文字的属性
    UILabel *genderLabel = [view isKindOfClass:[UILabel class]] ? (UILabel*)view : [UILabel new];
    [genderLabel setWordWithStyle:mt_WordStyleMake(12, @"", row == selectedRow ? hex(0x2976f4) : hex(0x333333))];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        genderLabel.text = self.yearArray[row];
    } else if (component == 1) {
        genderLabel.text = self.monthArray[row];
    } else {
        genderLabel.text = self.dayArray[row];
    }
    return genderLabel;
}

#pragma mark - 懒加载

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        for (int year = 1950; year <= self.comp.year; year++) {
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            [_yearArray addObject:str];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        for (int month = 1; month <= 12; month++) {
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            [_monthArray addObject:str];
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
        for (int day = 1; day <= 31; day++) {
            NSString *str = [NSString stringWithFormat:@"%02d日", day];
            [_dayArray addObject:str];
        }
    }
    return _dayArray;
}

-(NSDateComponents *)comp
{
    if(!_comp)
    {
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour |  NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        _comp = [calendar components: unitFlags fromDate:[MTTimer getCurrentDate]];
    }
    
    return _comp;
}


@end
