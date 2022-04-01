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

typedef void (^MTUpdateLayoutSubviews)(id object, CGFloat contentWidth, CGFloat contentHeight);

typedef CGSize (^MTLayoutSubviews)(id object, CGFloat contentWidth, CGFloat contentHeight);

typedef void (^MTSetContentModel)(id object, MTViewContentModel* contentModel);

typedef MTSetupDefaultModel* (^MTUpdateUI)(MTSetupDefault updateUI);

typedef MTSetupDefaultModel* (^MTDrawRect)(MTSetupDefault drawRect);

typedef MTSetupDefaultModel* (^MTUpdateLayout)(MTUpdateLayoutSubviews updateLayoutSubviews);

typedef MTSetupDefaultModel* (^MTConfigDataSource)(MTSetupDefault configDataSourceModel);


@interface MTSetupDefaultModel : NSObject

@property (nonatomic,copy) MTSetupDefault setupDefault;

@property (nonatomic,copy) MTLayoutSubviews layoutSubviews;
@property (nonatomic,copy) MTUpdateLayoutSubviews updateLayoutSubviews;

@property (nonatomic,copy) MTSetContentModel setContentModel;
@property (nonatomic,copy) MTSetContentModel adjustSetContentModel;

@property (nonatomic,copy) MTSetupDefault updateUIClick;
@property (nonatomic,copy) MTSetupDefault adjustUpdateUIClick;

@property (nonatomic,copy) MTSetupDefault drawRectHandle;

@property (nonatomic,copy) MTSetupDefault configDataSourceModel;


@property (nonatomic,copy, readonly) MTUpdateUI updateUI;
@property (nonatomic,copy, readonly) MTUpdateLayout updateLayout;

@property (nonatomic,copy, readonly) MTConfigDataSource configDataSource;


@property (nonatomic,copy, readonly) MTDrawRect drawRect;

@end

CG_EXTERN MTSetupDefaultModel* mt_BaseCellDefaultModelMake(MTSetupDefault setupDefault, MTLayoutSubviews layoutSubviews, MTSetContentModel setContentModel);


