//
//  MTTimeModel.h
//  QXProject
//
//  Created by 王奕聪 on 2020/6/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTTimeRecordModel;
typedef MTTimeRecordModel* (^MTTimeRecord) (NSTimeInterval time);

@interface MTTimeRecordModel : NSObject

@property (nonatomic,strong,readonly) MTTimeRecordModel* reduceTImeModel;

@property (nonatomic,assign,readonly) NSTimeInterval century;
@property (nonatomic,assign,readonly) NSTimeInterval year;
@property (nonatomic,assign,readonly) NSTimeInterval month;
@property (nonatomic,assign,readonly) NSTimeInterval week;
@property (nonatomic,assign,readonly) NSTimeInterval day;
@property (nonatomic,assign,readonly) NSTimeInterval hour;
@property (nonatomic,assign,readonly) NSTimeInterval minute;
@property (nonatomic,assign,readonly) NSTimeInterval second;
@property (nonatomic,assign,readonly) NSTimeInterval milliSecond;
@property (nonatomic,assign,readonly) NSTimeInterval milliSecondDecimal;

@property (nonatomic,assign, readonly) BOOL isTimeEmpty;

@property (nonatomic,copy,readonly) MTTimeRecord addMilliSecond;
@property (nonatomic,copy,readonly) MTTimeRecord addSecond;
@property (nonatomic,copy,readonly) MTTimeRecord addMinute;
@property (nonatomic,copy,readonly) MTTimeRecord addHour;
@property (nonatomic,copy,readonly) MTTimeRecord addDay;
@property (nonatomic,copy,readonly) MTTimeRecord addWeek;
@property (nonatomic,copy,readonly) MTTimeRecord addMonth;
@property (nonatomic,copy,readonly) MTTimeRecord addYear;
@property (nonatomic,copy,readonly) MTTimeRecord addCentury;

@property (nonatomic,copy,readonly) MTTimeRecord reduceMilliSecond;
@property (nonatomic,copy,readonly) MTTimeRecord reduceSecond;
@property (nonatomic,copy,readonly) MTTimeRecord reduceMinute;
@property (nonatomic,copy,readonly) MTTimeRecord reduceHour;
@property (nonatomic,copy,readonly) MTTimeRecord reduceDay;
@property (nonatomic,copy,readonly) MTTimeRecord reduceWeek;
@property (nonatomic,copy,readonly) MTTimeRecord reduceMonth;
@property (nonatomic,copy,readonly) MTTimeRecord reduceYear;
@property (nonatomic,copy,readonly) MTTimeRecord reduceCentury;

-(void)clearTimeRecord;

/**计算后会记录在 reduceTImeModel 中，并不会影响原来的值*/
-(void)reduceTImeWithModel:(MTTimeRecordModel*)timeRecordModel;


-(NSTimeInterval)getTotalYear;
-(NSTimeInterval)getTotalMonth;
-(NSTimeInterval)getTotalWeek;
-(NSTimeInterval)getTotalDay;
-(NSTimeInterval)getTotalHour;
-(NSTimeInterval)getTotalMinute;
-(NSTimeInterval)getTotalSecond;
-(NSTimeInterval)getTotalMilliSecond;

@end


@interface MTTimerModel : MTTimeRecordModel

@property (nonatomic,assign) BOOL isBegin;
/**执行的时间间隔*/
@property (nonatomic,assign) CGFloat timeInterval;

-(void)start;
-(void)stop;

-(void)addObserver:(id)observer;
-(void)removeObserver:(id)observer;


@end

CG_EXTERN MTTimeRecordModel*  mt_timeRecorder(void);
CG_EXTERN MTTimerModel*  mt_timer(void);
