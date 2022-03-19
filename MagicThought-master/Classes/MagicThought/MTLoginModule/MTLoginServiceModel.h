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

@end

