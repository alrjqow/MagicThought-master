//
//  MTLoginServiceModel.m
//  MagicThought-master
//
//  Created by apple on 2022/3/11.
//

#import "MTLoginServiceModel.h"
#import "NSString+Exist.h"
#import "UIView+MBHud.h"
#import "MTConst.h"


@implementation MTLoginServiceModel

-(void)dealloc
{
    [self.timerModel stop];
    [self.timerModel removeObserver:self];
}

-(void)setupDefault
{
    self.maxVfCodeTotalSecond = kArchitectureManager_mt.vfCodeTotalSecond;
}

-(void)startVfcodeCount
{
    if(![self.userPhone isExist])
    {
        [self showCenterToast:@"请输入手机号码"];
        return;
    }
    
    [MTTimer setCurrentVfCodeTimeStamp:self.vfCodeIdentifier];
    [self.timerModel start];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if(self.isVfCodeOver < 0)
        return;
    
    [kUserDefaults_mt() removeObjectForKey:self.vfCodeIdentifier];
    [self.timerModel stop];
}

-(NSTimeInterval)isVfCodeOver
{
    return [MTTimer didValueBetweenCurrentZoneTimeStampAndLastStamp:[kUserDefaults_mt() integerForKey:self.vfCodeIdentifier] IsOver:self.maxVfCodeTotalSecond];
}

-(BOOL)canLogin
{
    if([self.tagIdentifier containsString:kIsAgree] && !self.isAgree)
    {
        [self showCenterToast:@"请同意用户协议"];
        return false;
    }
    
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

emptyString(userPhone)

emptyString(password)

emptyString(vfCode)

-(NSString *)vfCodeIdentifier
{
    if(!_vfCodeIdentifier)
    {
        _vfCodeIdentifier = getVfCodeIdentifier_mt([NSString stringWithFormat:@"%@_%@", NSStringFromClass(self.controller.class), self.mt_tagIdentifier]);
    }
    
    return _vfCodeIdentifier;
}

-(MTTimerModel *)timerModel
{
    if(!_timerModel)
    {
        _timerModel = mt_timer();
        _timerModel.timeInterval = 1;
        [_timerModel addObserver:self];
    }
    
    return _timerModel;
}

@end


NSString *const kIsUserPhone = @"mtIsUserPhone";
NSString *const kIsPassword = @"mtIsPassword";
NSString *const kIsVfcode = @"mtIsVfcode";
NSString *const kIsLogin = @"mtIsLogin";
NSString *const kIsRegister = @"mtIsRegister";
NSString *const kIsForgetPassword = @"mtIsForgetPassword";
NSString *const kIsAgree = @"mtIsAgree";
NSString *const kIsGoback = @"mtIsGoback";

NSString *const kIsGoToRegister = @"mtIsGoToRegister";
NSString *const kIsGoToForgetPassword = @"mtIsGoToForgetPassword";
