//
//  MTHostManager.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/29.
//

#import "MTManager.h"

@interface MTHostManager : MTManager

@property (nonatomic,assign) NSInteger hostNum;

+(instancetype)registerHostManager;

@end

#define RegisterMTHostManager(className) RegisterHostManager(MTHostManager, className)

#define RegisterHostManager(manager, className) typedef manager __MTHostManager__; \
@interface MTHostManager(HostModel) \
@property (nonatomic,strong, readonly) className* currentHostModel; \
@end

#define RegisterHostManagerConfirm @implementation MTHostManager (registerHostManager)\
+(instancetype)registerHostManager{return kHostManager_mt;}\
@end

#define ResignHostManager [__MTHostManager__ clear];
#define kHostManager_mt [__MTHostManager__ manager]
