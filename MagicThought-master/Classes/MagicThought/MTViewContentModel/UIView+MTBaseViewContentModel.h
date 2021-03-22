//
//  UIView+MTBaseViewContentModel.h
//  QXProject
//
//  Created by monda on 2019/12/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define viewContent(...) setObjects(mt_content(__VA_ARGS__))
#define cellContent(...) setObjects(mt_cellContent(__VA_ARGS__))
#define viewStateContent(...) setObjects(mt_stateContent(__VA_ARGS__))
#define viewVerifyContent(...) setObjects(mt_verifyContent(__VA_ARGS__))
#define imageShowContent(...) setObjects(mt_imageShowContent(__VA_ARGS__))
#define baseContentModel(...) setObjects(@[__VA_ARGS__].arrBind(@"baseContentModel"))

#define defaultViewContent(...) viewContent(mt_beDefault(),##__VA_ARGS__)
#define defaultCellContent(...) cellContent(mt_beDefault(),##__VA_ARGS__)
#define defaultViewStateContent(...) viewStateContent(mt_beDefault(),##__VA_ARGS__)
#define defaultViewVerifyContent(...) viewVerifyContent(mt_beDefault(),##__VA_ARGS__)
#define defaultImageShowContent(...) imageShowContent(mt_beDefault(),##__VA_ARGS__)


@class MTBaseViewContentModel;
@interface UIView (MTBaseViewContentModel)

/**view 的状态*/
@property (nonatomic,assign) NSUInteger viewState;

@property (nonatomic,strong) MTBaseViewContentModel* baseContentModel;

/**为了编译器识别 cellContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* cellContent;
/**为了编译器识别 defaultCellContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* defaultCellContent;


/**为了编译器识别 viewContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* viewContent;
/**为了编译器识别 defaultViewContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* defaultViewContent;

/**为了编译器识别 viewStateContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* viewStateContent;
/**为了编译器识别 defaultViewStateContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* defaultViewStateContent;


/**为了编译器识别 viewVerifyContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* viewVerifyContent;
/**为了编译器识别 defaultViewVerifyContent 宏*/
@property (nonatomic,strong, readonly) MTBaseViewContentModel* defaultViewVerifyContent;

/**IsClearOrder = Yes*/
-(void)clickWithClearData:(NSObject*)data;

-(void)viewEventWithView:(UIView*)view Data:(NSObject*)data;

-(void)setBaseModelConfig:(MTBaseViewContentModel*)baseContentModel;

-(MTBaseViewContentModel*)findBaseViewContentModel:(MTBaseViewContentModel*)baseViewContentModel Key:(NSString*)key For:(BOOL (^)(MTBaseViewContentModel* model))check;

@end

