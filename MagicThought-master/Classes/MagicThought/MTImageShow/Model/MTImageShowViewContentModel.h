//
//  MTImageShowViewContentModel.h
//  QXProject
//
//  Created by monda on 2020/5/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTViewContentModel.h"
#import "MTImageShowControllModel.h"


@interface MTImageShowViewContentModel : MTBaseViewContentStateModel

@property (nonatomic,weak) MTImageShowControllModel* imageShowControllModel;

@end


@interface MTBigimageCellContentModel : MTViewContentModel

@property (nonatomic,weak) MTImageShowControllModel* imageShowControllModel;

@end
CG_EXTERN NSString* kImageShowControllModel;

