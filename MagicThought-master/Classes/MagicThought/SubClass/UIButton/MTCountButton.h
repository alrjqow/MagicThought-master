//
//  MTCountButton.h
//  8kqw
//
//  Created by 八块钱网 on 2017/6/8.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "UIView+Delegate.h"

extern NSString*  MTCountButtonDidFinishedCountDownOrder;
@interface MTCountButton : UIButton

-(void)stop;

-(void)startCountWithTitle:(NSString*)title Time:(NSInteger)time;

-(void)startCountWithTitle:(NSString*)title Time:(NSInteger)time CountDownTitle:(NSString*)title;

@end
