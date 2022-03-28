//
//  MTLoginServiceModel.h
//  MagicThought-master
//
//  Created by apple on 2022/3/11.
//

#import "MTServiceModel.h"
#import "MTConst.h"
#import "MTProjectArchitectureManager.h"
#import "MTTimeModel.h"
#import "MTTimer.h"

@interface MTLoginServiceModel : MTServiceModel

@property (nonatomic,strong) MTTimerModel* timerModel;

@property (nonatomic,assign) NSTimeInterval maxVfCodeTotalSecond;

@property (nonatomic,assign, readonly) NSTimeInterval isVfCodeOver;


propertyString(vfCodeIdentifier);

propertyBool(isAgree)

propertyString(tagIdentifier);

propertyString(userPhone)

propertyString(password)

propertyString(vfCode)

-(BOOL)canLogin;

-(void)startVfcodeCount;


//数据源
@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) NSArray* sectionList;


@end



extern NSString *const kIsUserPhone;
extern NSString *const kIsPassword;
extern NSString *const kIsVfcode;
extern NSString *const kIsLogin;
extern NSString *const kIsRegister;
extern NSString *const kIsForgetPassword;
extern NSString *const kIsGoback;

extern NSString *const kIsAgree;

extern NSString *const kIsGoToRegister;
extern NSString *const kIsGoToForgetPassword;
