//
//  MTLoginServiceModel.m
//  MagicThought-master
//
//  Created by apple on 2022/3/11.
//

#import "MTLoginServiceModel.h"
#import "NSString+Exist.h"
#import "UIView+MBHud.h"


@implementation MTLoginServiceModel

emptyString(userPhone)

emptyString(password)

emptyString(vfCode)

-(BOOL)canLogin
{
    if([self.tagIdentifier containsString:kIsUserPhone] && ![self.userPhone isExist])
    {
        [self showCenterToast:@"请输入手机号码"];
        return false;
    }
    
    if([self.tagIdentifier containsString:kIsVfcode] && ![self.vfCode isExist])
    {
        [self showCenterToast:@"请输入短信验证码"];
        return false;
    }
    
    if([self.tagIdentifier containsString:kIsPassword] && ![self.password isExist])
    {
        [self showCenterToast:@"请输入登录密码"];
        return false;
    }
    
    return YES;
}

emptyString(tagIdentifier)

@end
