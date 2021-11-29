//
//  MTTimer.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTTimer.h"

@implementation MTTimer

+(NSDate*)getCurrentDate
{
    NSDate* date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
//    date = [date dateByAddingTimeInterval:time];
    
    return date;
}

+(NSString*)getTimeWithCurrentDateAndFormat:(NSString*)format
{
    return [self getTimeWithDate:[self getCurrentDate] Format:format];
}

+(NSString*)getTimeWithDateString:(NSString*)dateString Format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* time = [self getTimeWithDate:[formatter dateFromString:dateString] Format:format];
    if(!time)
        time = @"";
    
    return time;
}

+(NSTimeInterval)getTimeStampWithString:(NSString*)timeString
{
    return [self getTimeStampWithString:timeString Format:nil];
}

+(NSTimeInterval)getTimeStampWithString:(NSString*)timeString Format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: format ? format : @"YYYY-MM-dd HH:mm:ss"];
    return [[formatter dateFromString:timeString] timeIntervalSince1970];
}

+(NSString*)getTimeWithDate:(NSDate*)date Format:(NSString*)format
{        
    NSDateFormatter* formater = [NSDateFormatter new];
    [formater setDateFormat:format ? format : @"YYYY-MM-dd HH:mm:ss"];
    return  [formater stringFromDate:date];
}

+(NSDate*)getDateWithTime:(NSString*)time Format:(NSString*)format
{
    NSDateFormatter* formater = [NSDateFormatter new];
    [formater setDateFormat:format ? format : @"YYYY-MM-dd HH:mm:ss"];
    
    NSDate* date = [formater dateFromString:time];
    return date;
//    NSTimeZone* zone = [NSTimeZone systemTimeZone];
//
//    return [date dateByAddingTimeInterval:[zone secondsFromGMTForDate:date]];
}

+(NSTimeInterval)getCurrentZoneTimeStamp
{
    return [[self getCurrentDate] timeIntervalSince1970];
}

+(NSTimeInterval)getCurrentTimeStamp
{
    return [[NSDate date] timeIntervalSince1970];
}

+(NSTimeInterval)getTodayBeginTimeStamp
{
    return [self getTime:0 andMinute:0];
}

+ (NSTimeInterval)getTime: (NSInteger)hour andMinute:(NSInteger)minute {
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [greCalendar setTimeZone: timeZone];

    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    //  定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setDay:dateComponents.day];
    [dateComponentsForDate setMonth:dateComponents.month];
    [dateComponentsForDate setYear:dateComponents.year];
    [dateComponentsForDate setHour:hour];
    [dateComponentsForDate setMinute:minute];

    NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
    return [dateFromDateComponentsForDate timeIntervalSince1970];
}

+(NSTimeInterval)didValueBetweenCurrentZoneTimeStampAndLastStamp:(NSInteger)lastStamp IsOver:(NSInteger)time
{
    return  ((NSInteger)[MTTimer getCurrentZoneTimeStamp]) - lastStamp - time;
}

+(NSString*)getStartTimeAccrodingToCurrentDateWithDays:(NSInteger)days
{
    NSTimeInterval stamp = (days - 1) * 24 * 60 * 60;
    
    NSTimeInterval startStamp = [self getCurrentTimeStamp] - stamp;
    
    return [self getTimeWithDate:[NSDate dateWithTimeIntervalSince1970:startStamp] Format:@"YYYY-MM-dd"];
}

+(void)setCurrentVfCodeTimeStamp:(NSString*)Identifier
{
    [[NSUserDefaults standardUserDefaults] setInteger:[self getCurrentTimeStamp] forKey:Identifier];
}

@end
