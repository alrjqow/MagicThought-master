//
//  MTHostServiceModel.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/29.
//

#import "MTServiceModel.h"


@interface MTHostServiceModel : MTServiceModel

@property (nonatomic,strong) NSArray<NSString*>* hostNameList;

-(void)addHostSwitchButton;

@end

