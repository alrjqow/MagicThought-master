//
//  MTViewContentModel+MTAlert.h
//  QXProject
//
//  Created by monda on 2020/12/1.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define alertView(...) alertViewWithObject(@[__VA_ARGS__])

@interface NSObject (MTAlert)

//为了识别宏 alertView
@property (nonatomic,assign) NSInteger alertView;

@property (nonatomic,copy, readonly) void (^alertViewWithObject)(id);


@end


@interface MTAlertConfig : NSObject

@property (nonatomic, assign) NSTimeInterval configAnimationDuration;

@property (nonatomic,assign) CGFloat configBackgroundViewAlpha;

@property (nonatomic,assign) BOOL configCanBackgroundViewTouchDismiss;

@end

CG_EXTERN MTAlertConfig* mt_AlertConfigMake(NSTimeInterval configAnimationDuration, CGFloat  configBackgroundViewAlpha, BOOL configCanBackgroundViewTouchDismiss);

