//
//  NSString+Money.h
//  MyTool
//
//  Created by 王奕聪 on 2017/3/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Money)

+(NSString*)stringWithMoneyHidePoint:(CGFloat)floatValue;

-(NSString*)money;
-(NSString*)floatMoney;

-(NSString*)deleteFloatAllZero;

@end

MTL_EXTERN NSString* deleteFloatMoneyAllZero(CGFloat floatValue);
