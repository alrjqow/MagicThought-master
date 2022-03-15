//
//  MTLoginServiceModel.h
//  MagicThought-master
//
//  Created by apple on 2022/3/11.
//

#import "MTServiceModel.h"
#import "MTConst.h"
#import "MTProjectArchitectureManager.h"


@interface MTLoginServiceModel : MTServiceModel

propertyString(tagIdentifier);

propertyString(userPhone)

propertyString(password)

propertyString(vfCode)

-(BOOL)canLogin;


@end

