//
//  NSString+TestString.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "NSString+TestString.h"

@implementation NSString (TestString)

-(BOOL)testWithFormat:(NSString*)format
{
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",format];
    BOOL result = [numberPre evaluateWithObject:self];
    return result;
}

-(BOOL)testDecimalWithPlace:(NSInteger)place
{
    return  [self testWithFormat:[NSString stringWithFormat:@"^[0-9]+(.[0-9]{0,%zd})?$",place]];
}


-(BOOL)testPositiveInteger
{
    return [self testWithFormat:@"^\\+?[1-9][0-9]*$"];
}

-(BOOL)testStartWith:(NSString*)startStr
{    
    return  [self testWithFormat:[NSString stringWithFormat:@"^(%@).*$",startStr]];
}


-(BOOL)testPositiveNumber
{
    return [self testWithFormat:@"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$"];
}

-(BOOL)testPhoneNumber
{
    return [self testWithFormat:@"^1(2[0-9]|3[0-9]|4[0-9]|5[0-35-9]|6[0-9]|7[0135678]|8[0-9])\\d{8}$"];
}

-(BOOL)testIDCard
{
    if(self.length < 18) return false;
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [self substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
//    //判断是否是18位，末尾是否是x
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    if(![identityCardPredicate evaluateWithObject:self]){
//        return NO;
//    }
//    //判断生日是否合法
//    NSRange range = NSMakeRange(6,8);
//    NSString *datestr = [self substringWithRange:range];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat : @"yyyyMMdd"];
//    if([formatter dateFromString:datestr]==nil){
//        return NO;
//    }
//    
//    //判断校验位
//    if(self.length==18)
//    {
//        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
//        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
//        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
//        for(int i=0;i<17;i++){
//            idCardWiSum+=[[self substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
//        }
//        
//        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
//        NSString *idCardLast=[self substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
//        
//        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
//        if(idCardMod==2){
//            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
//                return YES;
//            }else{
//                return NO;
//            }
//        }else{
//            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
//                return YES;
//            }else{
//                return NO;
//            }
//        }
//    }
//    return NO;
//    return [self predicateText:self withFormat:@"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$"];
}


/**
 判断是否是有效的中文名
 
 @param realName 名字
 @return 如果是在如下规则下符合的中文名则返回`YES`，否则返回`NO`
 限制规则：
 1. 首先是名字要大于2个汉字，小于8个汉字
 2. 如果是中间带`{•|·}`的名字，则限制长度15位（新疆人的名字有15位左右的，之前公司实名认证就遇到过），如果有更长的，请自行修改长度限制
 3. 如果是不带小点的正常名字，限制长度为8位，若果觉得不适，请自行修改位数限制
 *PS: `•`或`·`具体是那个点具体处理需要注意*
 */
-(BOOL)testChinese
{
    NSRange range1 = [self rangeOfString:@"·"];
    NSRange range2 = [self rangeOfString:@"•"];
    
    // 中文 ·
    // 英文 •
    if(range1.location != NSNotFound || range2.location != NSNotFound )
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([self length] < 2 || [self length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
    else
    {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([self length] < 2 || [self length] > 8)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}

-(BOOL)testVFCode
{
    return [self testNumberWithCount:6];
}

-(BOOL)testPayPassword
{
    return [self testNumberWithCount:6];
}

-(BOOL)testNumberWithCount:(NSInteger)count
{
    return [self testWithFormat:[NSString stringWithFormat:@"^\\d{%zd}$", count]];
}

-(BOOL)testNumberWithWord
{
    return [self testWithFormat:@"(?!^\\d+$)(?!^[a-zA-Z]+$)[a-zA-Z]{1}[0-9a-zA-Z]{1,}"];
}

-(BOOL)testMoney
{
    return [self testDecimalWithPlace:2];
}

-(NSRange)rangeWithFormat:(NSString *)regularExpress
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpress options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
        if (firstMatch)
            return [firstMatch rangeAtIndex:0];
    }
    
    return NSMakeRange(NSNotFound, 0);
}

@end
