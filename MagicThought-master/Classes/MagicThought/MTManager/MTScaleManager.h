//
//  MTScaleManager.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/25.
//

#import "MTManager.h"


@interface MTScaleManager : MTManager

@property (nonatomic,assign, readonly) CGFloat screenWidthScaleBase;

@property (nonatomic,assign, readonly) CGFloat screenHeightScaleBase;

@property (nonatomic,assign, readonly) CGFloat navigationBarHeightScaleBase;

+(instancetype)registerScaleManager;

@end

extern CGFloat kScreenWidthScale(CGFloat w);
extern CGFloat kScreenHeightScale(CGFloat h);
extern CGFloat kScreenHeightNoNavigtionBarScale(CGFloat h);

#define RegisterScaleManager(manager) typedef manager __MTScaleManager__;
#define RegisterScaleManagerConfirm @implementation MTScaleManager (registerScaleManager)\
+(instancetype)registerScaleManager{return kScaleManager_mt;}\
@end

#define ResignScaleManager [__MTScaleManager__ clear];
#define kScaleManager_mt [__MTScaleManager__ manager]
