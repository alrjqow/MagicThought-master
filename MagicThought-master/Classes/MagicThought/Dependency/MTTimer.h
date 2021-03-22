//
//  MTTimer.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"

@interface MTTimer : MTManager

/**获取当前时区的时间*/
+(NSDate*)getCurrentDate;

/**获取给定时间的字符串*/
+(NSString*)getTimeWithDate:(NSDate*)date Format:(NSString*)format;

/**获取给定字符串的时间*/
+(NSDate*)getDateWithTime:(NSString*)time Format:(NSString*)format;

/**获取给定时间字符串的字符串*/
+(NSString*)getTimeWithDateString:(NSString*)dateString Format:(NSString*)format;

/**获取当前时间的字符串*/
+(NSString*)getTimeWithCurrentDateAndFormat:(NSString*)format;

/**获取当前时间的时间戳*/
+(NSTimeInterval)getCurrentTimeStamp;

/**获取给定字符串的时间戳*/
+(NSTimeInterval)getTimeStampWithString:(NSString*)timeString;

/**获取当日凌晨0点的时间戳*/
+(NSTimeInterval)getTodayBeginTimeStamp;

/**获取当前时区时间的时间戳*/
//+(NSTimeInterval)getCurrentZoneTimeStamp;

/**算时间差值是否超过给定值*/
+(BOOL)dValueBetweenCurrentZoneTimeStampAndLastStamp:(NSInteger)lastStamp IsOver:(NSInteger)time;


/**计算当前时间前几天的日期*/
+(NSString*)getStartTimeAccrodingToCurrentDateWithDays:(NSInteger)days;

@end
