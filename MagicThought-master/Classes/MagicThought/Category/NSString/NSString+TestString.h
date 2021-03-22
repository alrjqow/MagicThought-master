//
//  NSString+TestString.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TestString)

/**检测是否是有n位小数的数字*/
-(BOOL)testDecimalWithPlace:(NSInteger)place;

/**检测是否为手机号*/
-(BOOL)testPhoneNumber;

/**检测是否为身份证号*/
-(BOOL)testIDCard;

/**检测是否金额*/
-(BOOL)testMoney;

/**检验是否为非0的正整数*/
-(BOOL)testPositiveInteger;

/**检验是否以某个字符串开头*/
-(BOOL)testStartWith:(NSString*)startStr;

/**检验是否为正数*/
-(BOOL)testPositiveNumber;

/**检验是否为汉字*/
-(BOOL)testChinese;

/**检验6位数字的短信验证码*/
-(BOOL)testVFCode;

/**检验6位数字的支付密码*/
-(BOOL)testPayPassword;

/**检验仅能输入数字与密码*/
-(BOOL)testNumberWithWord;

/**自定义检验*/
-(BOOL)testWithFormat:(NSString*)format;

/**检验是否为n位的数字*/
-(BOOL)testNumberWithCount:(NSInteger)count;

-(NSRange)rangeWithFormat:(NSString *)regularExpress;

@end
