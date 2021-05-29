//
//  MTHostManager.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/29.
//

#import "MTManager.h"


@interface MTHostManager : MTManager

@property (nonatomic,assign) NSInteger hostNum;

@end

#define RegisterHostManager(manager) typedef manager __MTHostManager__;
#define ResignHostManager [__MTHostManager__ clear];
#define kHostManager_mt [__MTHostManager__ manager]
