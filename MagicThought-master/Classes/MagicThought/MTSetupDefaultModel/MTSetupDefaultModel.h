//
//  MTSetupDefaultModel.h
//  MagicThought-master
//
//  Created by apple on 2022/3/10.
//

#import <UIKit/UIKit.h>
#import "MTViewContentModel.h"


@class MTSetupDefaultModel;

typedef void (^MTSetupDefault)(id object);

typedef void (^MTLayoutSubviews)(id object, CGFloat contentWidth, CGFloat contentHeight);

typedef void (^MTSetContentModel)(id object, MTViewContentModel* contentModel);

typedef MTSetupDefaultModel* (^MTUpdateUI)(MTSetupDefault updateUI);

@interface MTSetupDefaultModel : NSObject

@property (nonatomic,copy) MTSetupDefault setupDefault;

@property (nonatomic,copy) MTLayoutSubviews layoutSubviews;

@property (nonatomic,copy) MTSetContentModel setContentModel;

@property (nonatomic,copy) MTSetupDefault updateUIClick;

@property (nonatomic,copy, readonly) MTUpdateUI updateUI;

@end

CG_EXTERN MTSetupDefaultModel* mt_BaseCellDefaultModelMake(MTSetupDefault setupDefault, MTLayoutSubviews layoutSubviews, MTSetContentModel setContentModel);


