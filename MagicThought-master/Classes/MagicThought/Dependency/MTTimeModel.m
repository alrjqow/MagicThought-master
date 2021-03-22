//
//  MTTimeModel.m
//  QXProject
//
//  Created by 王奕聪 on 2020/6/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTTimeModel.h"
#import "NSObject+CommonProtocol.h"

@interface MTTimeRecordModel ()
{
    MTTimeRecordModel* _reduceTImeModel;
}

@property (nonatomic,assign) BOOL isTimer;

@property (nonatomic,strong) MTTimeRecordModel* timeRecordModel;


@end

@implementation MTTimeRecordModel

#pragma mark - 时间相对某个计量单位的整数转化

-(NSTimeInterval)getTotalYear
{
    return self.century * 100 + self.year;
}
-(NSTimeInterval)getTotalMonth
{
    return self.century * 100 * 12 + self.year * 12 + self.month;
}

-(NSTimeInterval)getTotalWeek
{
    return self.getTotalDay / 7;
}

-(NSTimeInterval)getTotalDay
{
    return self.century * 100 * 12 * 30 + self.year * 12 * 30 + self.month * 30 + self.day;
}

-(NSTimeInterval)getTotalHour
{
    return self.century * 100 * 12 * 30 * 24 + self.year * 12 * 30 * 24 + self.month * 30 * 24 + self.day * 24 + self.hour;
}

-(NSTimeInterval)getTotalMinute
{
    return self.century * 100 * 12 * 30 * 24 * 60 + self.year * 12 * 30 * 24 * 60 + self.month * 30 * 24 * 60 + self.day * 24 * 60 + self.hour * 60 + self.minute;
}

-(NSTimeInterval)getTotalSecond
{
    return self.century * 100 * 12 * 30 * 24 * 60 * 60 + self.year * 12 * 30 * 24 * 60 * 60 + self.month * 30 * 24 * 60 * 60 + self.day * 24 * 60 * 60 + self.hour * 60 * 60 + self.minute * 60 + self.second;
}

-(NSTimeInterval)getTotalMilliSecond
{
    return self.century * 100 * 12 * 30 * 24 * 60 * 60 * 1000 + self.year * 12 * 30 * 24 * 60 * 60 * 1000 + self.month * 30 * 24 * 60 * 60 * 1000 + self.day * 24 * 60 * 60 * 1000 + self.hour * 60 * 60 * 1000 + self.minute * 60 * 1000 + self.second * 1000 + self.milliSecond;
}

#pragma mark - 时间增加 block

-(MTTimeRecord)addMilliSecond
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addMilliSecond  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addMilliSecond:time];
        return weakSelf;
    };
    
    return addMilliSecond;
}

-(MTTimeRecord)addSecond
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addSecond  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addSecond:time];
        return weakSelf;
    };
    
    return addSecond;
}

-(MTTimeRecord)addMinute
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addMinute  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addMinute:time];
        return weakSelf;
    };
    
    return addMinute;
}

-(MTTimeRecord)addHour
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addHour  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addHour:time];
        return weakSelf;
    };
    
    return addHour;
}

-(MTTimeRecord)addDay
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addDay  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addDay:time];
        return weakSelf;
    };
    
    return addDay;
}

-(MTTimeRecord)addWeek
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addWeek  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addWeek:time];
        return weakSelf;
    };
    
    return addWeek;
}

-(MTTimeRecord)addMonth
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addMonth  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addMonth:time];
        return weakSelf;
    };
    
    return addMonth;
}

-(MTTimeRecord)addYear
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addYear  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addYear:time];
        return weakSelf;
    };
    
    return addYear;
}

-(MTTimeRecord)addCentury
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord addCentury  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf addCentury:time];
        return weakSelf;
    };
    
    return addCentury;
}

#pragma mark - 时间减少 block

-(MTTimeRecord)reduceMilliSecond
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceMilliSecond  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceMilliSecond:time];
        return weakSelf;
    };
    
    return reduceMilliSecond;
}

-(MTTimeRecord)reduceSecond
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceSecond  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceSecond:time];
        return weakSelf;
    };
    
    return reduceSecond;
}

-(MTTimeRecord)reduceMinute
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceMinute  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceMinute:time];
        return weakSelf;
    };
    
    return reduceMinute;
}

-(MTTimeRecord)reduceHour
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceHour  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceHour:time];
        return weakSelf;
    };
    
    return reduceHour;
}

-(MTTimeRecord)reduceDay
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceDay  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceDay:time];
        return weakSelf;
    };
    
    return reduceDay;
}

-(MTTimeRecord)reduceMonth
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceMonth  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceMonth:time];
        return weakSelf;
    };
    
    return reduceMonth;
}

-(MTTimeRecord)reduceYear
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceYear  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceYear:time];
        return weakSelf;
    };
    
    return reduceYear;
}

-(MTTimeRecord)reduceCentury
{
    __weak __typeof(self) weakSelf = self;
    MTTimeRecord reduceCentury  = ^(NSTimeInterval time){
        
        if(!weakSelf.isTimer)
            [weakSelf reduceCentury:time];
        return weakSelf;
    };
    
    return reduceCentury;
}

#pragma mark - 复制时间

-(void)copyTIme
{
    [self copyTImeWithModel:self.reduceTImeModel];
}

-(void)copyTImeWithModel:(MTTimeRecordModel*)timeRecordModel
{
    timeRecordModel.century = self.century;
    timeRecordModel.year = self.year;
    timeRecordModel.month = self.month;
    timeRecordModel.day = self.day;
    timeRecordModel.hour = self.hour;
    timeRecordModel.minute = self.minute;
    timeRecordModel.second = self.second;
    timeRecordModel.milliSecond = self.milliSecond;
    timeRecordModel.milliSecondDecimal = self.milliSecondDecimal;
}

#pragma mark - 时间相减

-(void)reduceTIme
{
    [self reduceTImeWithModel:self.timeRecordModel];
}

-(void)borrowMilliSecond:(NSInteger)level
{
    if(_milliSecond <= 0)
    {
        level++;
        [self borrowSecond:level];
    }
    else
    {
        _milliSecondDecimal += 1;
        _milliSecond --;
    }
}

-(void)borrowSecond:(NSInteger)level
{
    if(_second <= 0)
    {
        level++;
        [self borrowMinute:level];
    }
    else
    {
        _milliSecond += 1000;
        _second --;
        if(level > 0)
        {
            level--;
            [self borrowMilliSecond:level];
        }
    }
}

-(void)borrowMinute:(NSInteger)level
{
    if(_minute <= 0)
    {
        level++;
        [self borrowHour:level];
    }
    else
    {
        _second += 60;
        _minute --;
        if(level > 0)
        {
            level--;
            [self borrowSecond:level];
        }
    }
}

-(void)borrowHour:(NSInteger)level
{
    if(_hour <= 0)
    {
        level++;
        [self borrowDay:level];
    }
    else
    {
        _minute += 60;
        _hour --;
        if(level > 0)
        {
            level--;
            [self borrowMinute:level];
        }
    }
}

-(void)borrowDay:(NSInteger)level
{
    if(_day <= 0)
    {
        level++;
        [self borrowMonth:level];
    }
    else
    {
        _hour += 24;
        _day --;
        if(level > 0)
        {
            level--;
            [self borrowHour:level];
        }
    }
}

-(void)borrowMonth:(NSInteger)level
{
    if(_month <= 0)
    {
        level++;
        [self borrowYear:level];
    }
    else
    {
        _day += 30;
        _month --;
        if(level > 0)
        {
            level--;
            [self borrowDay:level];
        }
    }
}

-(void)borrowYear:(NSInteger)level
{
    if(_year <= 0)
    {
        level++;
        [self borrowCentury:level];
    }
    else
    {
        _month += 12;
        _year --;
        if(level > 0)
        {
            level--;
            [self borrowMonth:level];
        }
            
    }
}

-(void)borrowCentury:(NSInteger)level
{
    _century --;
    if(_century >= 0)
    {
        _year += 100;
        if(level > 0)
        {
            level--;
            [self borrowYear:level];
        }
    }
}

-(void)reduceTImeWithModel:(MTTimeRecordModel*)timeRecordModel
{
    [self copyTIme];
    
    if(timeRecordModel.milliSecondDecimal)
        self.reduceTImeModel.milliSecondDecimal -= timeRecordModel.milliSecondDecimal;
    if(self.reduceTImeModel.milliSecondDecimal < 0)
        [self.reduceTImeModel borrowMilliSecond:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.milliSecond)
        self.reduceTImeModel.milliSecond -= timeRecordModel.milliSecond;
    if(self.reduceTImeModel.milliSecond < 0)
        [self.reduceTImeModel borrowSecond:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.second)
        self.reduceTImeModel.second -= timeRecordModel.second;
    if(self.reduceTImeModel.second < 0)
        [self.reduceTImeModel borrowMinute:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.minute)
        self.reduceTImeModel.minute -= timeRecordModel.minute;
    if(self.reduceTImeModel.minute < 0)
        [self.reduceTImeModel borrowHour:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.hour)
        self.reduceTImeModel.hour -= timeRecordModel.hour;
    if(self.reduceTImeModel.hour < 0)
        [self.reduceTImeModel borrowDay:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.day)
        self.reduceTImeModel.day -= timeRecordModel.day;
    if(self.reduceTImeModel.day < 0)
        [self.reduceTImeModel borrowMonth:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.month)
        self.reduceTImeModel.month -= timeRecordModel.month;
    if(self.reduceTImeModel.month < 0)
        [self.reduceTImeModel borrowYear:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.year)
        self.reduceTImeModel.year -= timeRecordModel.year;
    if(self.reduceTImeModel.year < 0)
        [self.reduceTImeModel borrowCentury:0];
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
    
    if(timeRecordModel.century)
        self.reduceTImeModel.century -= timeRecordModel.century;
    if(self.reduceTImeModel.century < 0)
    {
        [self.reduceTImeModel clearTimeRecord];
        return;
    }
}

#pragma mark - 时间增加

-(void)addMilliSecondDecimal:(CGFloat)milliSecondDecimal
{
    milliSecondDecimal += _milliSecondDecimal;
    
    NSInteger milliSecond = floor(milliSecondDecimal);
    _milliSecondDecimal = milliSecondDecimal - milliSecond;
    if(milliSecond)
        [self addIntegerMilliSecond:milliSecond];
}

-(void)addMilliSecond:(CGFloat)milliSecond
{
    NSInteger milliSecond0 = milliSecond;
    if(milliSecond > milliSecond0)
        [self addMilliSecondDecimal:(milliSecond - milliSecond0)];
    if(milliSecond0)
        [self addIntegerMilliSecond:milliSecond0];
}
-(void)addIntegerMilliSecond:(NSInteger)milliSecond
{
    milliSecond += _milliSecond;
    _milliSecond = milliSecond % 1000;
    
    NSInteger second = milliSecond / 1000;
    if(second)
        [self addIntegerSecond:second];
}

-(void)addSecond:(CGFloat)second
{
    NSInteger second0 = second;
    if(second > second0)
        [self addMilliSecond:(second - second0) * 1000];
    if(second0)
        [self addIntegerSecond:second0];
}
-(void)addIntegerSecond:(NSInteger)second
{
    second += _second;
    _second = second % 60;
    
    NSInteger minute = second / 60;
    if(minute)
        [self addIntegerMinute:minute];
}

-(void)addMinute:(CGFloat)minute
{
    NSInteger minute0 = minute;
    if(minute > minute0)
        [self addSecond:(minute - minute0) * 60];
    if(minute0)
        [self addIntegerMinute:minute0];
}
-(void)addIntegerMinute:(NSInteger)minute
{
    minute += _minute;
    _minute = minute % 60;
    
    NSInteger hour = minute / 60;
    if(hour)
        [self addIntegerHour:hour];
}

-(void)addHour:(CGFloat)hour
{
    NSInteger hour0 = hour;
    if(hour > hour0)
        [self addMinute:(hour - hour0) * 60];
    if(hour0)
        [self addIntegerHour:hour0];
}
-(void)addIntegerHour:(NSInteger)hour
{
    hour += _hour;
    _hour = hour % 24;
    
    NSInteger day = hour / 24;
    if(day)
        [self addIntegerDay:day];
}

-(void)addDay:(CGFloat)day
{
    NSInteger day0 = day;
    if(day > day0)
        [self addHour:(day - day0) * 24];
    if(day0)
        [self addIntegerDay:day0];
}
-(void)addIntegerDay:(NSInteger)day
{
    day += _day;
    _day = day % 30;
    
    NSInteger month = day / 30;
    if(month)
        [self addIntegerMonth:month];
}

-(void)addWeek:(CGFloat)week
{
    [self addDay:week * 7];
}

-(NSInteger)week
{
    return (self.century * 100 * 12 * 30 + self.year * 12 * 30 + self.month * 30 + self.day) / 7;
}

-(void)addMonth:(CGFloat)month
{
    NSInteger month0 = month;
    if(month > month0)
        [self addDay:(month - month0) * 30];
    if(month0)
        [self addIntegerMonth:month0];
}
-(void)addIntegerMonth:(NSInteger)month
{
    month += _month;
    _month = month % 12;
    
    NSInteger year = month / 12;
    if(year)
        [self addIntegerYear:year];
}

-(void)addYear:(CGFloat)year
{
    NSInteger year0 = year;
    if(year > year0)
        [self addMonth:(year - year0) * 12];
    if(year0)
        [self addIntegerYear:year0];
}
-(void)addIntegerYear:(NSInteger)year
{
    year += _year;
    _year = year % 100;
    
    NSInteger century = year / 100;
    if(century)
        [self addIntegerCentury:century];
}

-(void)addIntegerCentury:(NSInteger)century
{
    _century += century;
}
-(void)addCentury:(CGFloat)century
{
    NSInteger century0 = century;
    if(century > century0)
        [self addYear:(century - century0) * 100];
    if(century0)
        [self addIntegerCentury:century0];
}

#pragma mark - 时间减少
-(void)reduceMilliSecond:(CGFloat)milliSecond
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addMilliSecond(milliSecond);
    [self reduceTIme];
}

-(void)reduceSecond:(CGFloat)second
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addSecond(second);
    [self reduceTIme];
}

-(void)reduceMinute:(CGFloat)minute
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addMinute(minute);
    [self reduceTIme];
}

-(void)reduceHour:(CGFloat)hour
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addHour(hour);
    [self reduceTIme];
}

-(void)reduceDay:(CGFloat)day
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addDay(day);
    [self reduceTIme];
}

-(void)reduceWeek:(CGFloat)week
{
    [self reduceDay:week * 7];
}

-(void)reduceMonth:(CGFloat)month
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addMonth(month);
    [self reduceTIme];
}

-(void)reduceYear:(CGFloat)year
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addYear(year);
    [self reduceTIme];
}

-(void)reduceCentury:(CGFloat)century
{
    [self.timeRecordModel clearTimeRecord];
    self.timeRecordModel.addCentury(century);
    [self reduceTIme];
}

-(void)clearTimeRecord
{
    _century = _year = _month = _day = _hour = _minute = _second = _milliSecond = _milliSecondDecimal = 0;
}

#pragma mark - Getter、Setter

-(void)setCentury:(NSInteger)century
{
    _century = century;
}

-(void)setYear:(NSInteger)year
{
    _year = year;
}

-(void)setMonth:(NSInteger)month
{
    _month = month;
}

-(void)setDay:(NSInteger)day
{
    _day = day;
}

-(void)setHour:(NSInteger)hour
{
    _hour = hour;
}

-(void)setMinute:(NSInteger)minute
{
    _minute = minute;
}

-(void)setSecond:(NSInteger)second
{
    _second = second;
}

-(void)setMilliSecond:(NSInteger)milliSecond
{
    _milliSecond = milliSecond;
}

-(void)setMilliSecondDecimal:(double)milliSecondDecimal
{
    _milliSecondDecimal = milliSecondDecimal;
}

-(MTTimeRecordModel *)timeRecordModel
{
    if(!_timeRecordModel)
    {
        _timeRecordModel = MTTimeRecordModel.new;
    }
    
    return _timeRecordModel;
}

-(MTTimeRecordModel *)reduceTImeModel
{
    if(!_reduceTImeModel)
    {
        _reduceTImeModel = MTTimeRecordModel.new;
    }
    
    return _reduceTImeModel;
}

-(BOOL)isTimeEmpty
{
    return self.century == 0 &&
    self.year == 0 &&
    self.month == 0 &&
    self.day == 0 &&
    self.hour == 0 &&
    self.minute == 0 &&
    self.second == 0 &&
    self.milliSecond == 0 &&
    self.milliSecondDecimal == 0;
}

@end

@interface MTTimerModel ()

@property(nonatomic,strong) NSTimer* timer;

@property (nonatomic,assign) NSInteger percent;

@end

@implementation MTTimerModel

-(void)countdown
{
    self.percent = (self.percent + 1) % 10;
    [self addSecond:self.timeInterval];
    self.isBegin = YES;
}

-(void)start
{
    [self stop];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stop
{
    [self.timer invalidate];
    self.timer = nil;
    self.isBegin = false;
    [self clearTimeRecord];
}

-(void)whenDealloc
{
    [super whenDealloc];
    [self stop];
}

-(BOOL)isTimer{return YES;}

-(void)addObserver:(id)observer
{
    [self addObserver:observer forKeyPath:@"percent" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserver:(id)observer
{
    [self removeObserver:observer forKeyPath:@"percent"];
}

@end

MTTimeRecordModel*  mt_timeRecorder(void)
{
    return MTTimeRecordModel.new;
}
MTTimerModel*  mt_timer(void)
{
    return MTTimerModel.new;
}
