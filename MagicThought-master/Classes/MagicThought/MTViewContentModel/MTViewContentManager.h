//
//  MTViewContentManager.h
//  QXProject
//
//  Created by monda on 2020/8/12.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTManager.h"
#import "MTBaseViewContentModel.h"

#define RegisterContentManager(manager) typedef manager __MTViewContentManager__;
#define ResignContentManager [__MTViewContentManager__ clear];

#define wishContent(arrayProperty, ...) setObjects(mt_contentByManager(arrayProperty,  ##__VA_ARGS__))

#define wishStateContent(arrayProperty, ...) setObjects( mt_stateContentByManager(arrayProperty, ##__VA_ARGS__))

#define wishVerifyContent(arrayProperty, ...) setObjects( mt_verifyContentByManager(arrayProperty, ##__VA_ARGS__))

/*-----------------------------------华丽分割线-----------------------------------*/

#define wishDefaultContent(arrayProperty, ...)  setObjects(mt_contentByManager(arrayProperty, mt_beDefault(), ##__VA_ARGS__))

#define wishDefaultStateContent(arrayProperty, ...) setObjects( mt_stateContentByManager(arrayProperty, mt_beDefault(), ##__VA_ARGS__))

#define wishDefaultVerifyContent(arrayProperty, ...) setObjects( mt_verifyContentByManager(arrayProperty, mt_beDefault(), ##__VA_ARGS__))

/*-----------------------------------华丽分割线-----------------------------------*/

#define mt_contentByManager(arrayProperty, ...) MTBaseViewContentModel.new.setObjects([[__MTViewContentManager__ manager].arrayProperty extendWithArray:@[__VA_ARGS__]])

#define mt_stateContentByManager(arrayProperty, ...) MTBaseViewContentStateModel.new.setObjects([[__MTViewContentManager__ manager].arrayProperty extendWithArray:@[__VA_ARGS__]])

#define mt_verifyContentByManager(arrayProperty, ...) MTTextVerifyModel.new.setObjects([[__MTViewContentManager__ manager].arrayProperty extendWithArray:@[__VA_ARGS__]])


#define mt_selectedContentByManager(arrayProperty, ...) mt_selected(mt_contentByManager(arrayProperty,  ##__VA_ARGS__))


#define createArray(property, ...) \
-(NSArray *)property{return @[__VA_ARGS__];}

@interface MTViewContentManager : MTManager @end


@interface UIView(WishViewContent)

/**为了编译器识别 wishViewContent 宏*/
@property (nonatomic,assign, readonly) NSInteger wishContent;

/**为了编译器识别 wishStateContent 宏*/
@property (nonatomic,assign, readonly) NSInteger wishStateContent;

/**为了编译器识别 wishDefaultContent 宏*/
@property (nonatomic,assign, readonly) NSInteger wishDefaultContent;

/**为了编译器识别 wishDefaultStateContent 宏*/
@property (nonatomic,assign, readonly) NSInteger wishDefaultStateContent;

@property (nonatomic,copy,readonly) UIView* (^setObjects) (NSObject* objects);

@property (nonatomic,assign,readonly) BOOL isAssistCell;

@end

@interface UIButton(WishViewContent)

@property (nonatomic,copy,readonly) UIButton* (^setObjects) (NSObject* objects);

@end

@interface UIImageView(WishViewContent)

@property (nonatomic,copy,readonly) UIImageView* (^setObjects) (NSObject* objects);

@end

@interface UILabel(WishViewContent)

@property (nonatomic,copy,readonly) UILabel* (^setObjects) (NSObject* objects);

@end

@interface UITextField(WishViewContent)

@property (nonatomic,copy,readonly) UITextField* (^setObjects) (NSObject* objects);

@end

@interface UITextView(WishViewContent)

@property (nonatomic,copy,readonly) UITextView* (^setObjects) (NSObject* objects);

@end

@interface NSArray (WishViewContent)

-(NSArray*)extendWithArray:(NSArray*)array;

@end
