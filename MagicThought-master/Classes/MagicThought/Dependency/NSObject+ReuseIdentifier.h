//
//  NSObject+ReuseIdentifier.h
//  MTEasyController
//
//  Created by monda on 2018/4/23.
//  Copyright © 2018年 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef struct
{
    CGFloat minLineSpacing;
    CGFloat minItemSpacing;
    UIEdgeInsets sectionInset;
} MTDelegateCollectionViewSpacing;

@interface NSBindObject : NSObject @end

@interface NSReuseObject : NSObject

@property (nonatomic,strong) id _Nullable data;

@end

@interface NSWeakReuseObject : NSObject

@property (nonatomic,weak) id _Nullable data;

@end

CG_EXTERN NSString* _Nonnull MTClearNotificationOrder;
CG_EXTERN NSString* _Nonnull MTBanClickOrder;
CG_EXTERN NSString* _Nonnull MTBindNewObjectOrder;


CG_EXTERN MTDelegateCollectionViewSpacing mt_collectionViewSpacingMake(CGFloat minLineSpacing, CGFloat minItemSpacing,UIEdgeInsets sectionInset);

CG_EXTERN NSReuseObject* _Nonnull mt_reuse(id _Nullable data);
CG_EXTERN NSWeakReuseObject* mt_weakReuse(id _Nullable data);
CG_EXTERN NSReuseObject* _Nonnull mt_empty(void);

#define mt_bind NSBindObject.new

#define mt_content(...) MTBaseViewContentModel.new(__VA_ARGS__)
#define mt_cellContent(...) MTBaseCellModel.new(__VA_ARGS__)
#define mt_stateContent(...) MTBaseViewContentStateModel.new(__VA_ARGS__)
#define mt_verifyContent(...) MTTextVerifyModel.new(__VA_ARGS__)
#define mt_imageShowContent(...) MTImageShowViewContentModel.new(__VA_ARGS__)
#define new(...) new.setObjects(@[__VA_ARGS__])
#define objects(...) setObjects(@[__VA_ARGS__])
#define bindNotification(...) bindNotifications(@[__VA_ARGS__])

#define mt_defaultContent(...) mt_content(mt_beDefault(),##__VA_ARGS__)
#define mt_defaultStateContent(...) mt_stateContent(mt_beDefault(),##__VA_ARGS__)

#define mt_selectedContent(...) mt_selected(mt_content(__VA_ARGS__))
#define mt_highlightedContent(...) mt_highlighted(mt_content(__VA_ARGS__))
#define mt_disabledContent(...) mt_disabled(mt_content(__VA_ARGS__))
#define mt_placeholderContent(...) mt_placeholder(mt_content(__VA_ARGS__))
#define mt_headerContent(...) mt_header(mt_content(__VA_ARGS__))
#define mt_footerContent(...) mt_footer(mt_content(__VA_ARGS__))



typedef void (^MTClick)(id _Nullable object);
typedef void (^MTAutomaticDimensionSize)(CGSize size);
typedef void (^MTNotificationHandle)(NSNotification * _Nonnull notification);


@interface NSObject (ReuseIdentifier)

@property (nonatomic,strong) NSNumber* _Nullable mt_index;
@property (nonatomic,assign, readonly) NSInteger  mt_currentIndex;

@property (nonatomic,assign) NSInteger mt_tag;

@property (nonatomic,assign) BOOL mt_result;
@property (nonatomic,assign) BOOL mt_automaticDimension;

@property (nonatomic,strong) NSString* _Nullable mt_order;

@property (nonatomic,strong) NSString* _Nullable mt_tagIdentifier;

@property (nonatomic,strong) NSString* _Nullable mt_reuseIdentifier;

@property (nonatomic,strong) NSString* _Nullable mt_keyName;

@property (nonatomic,assign) CGFloat mt_itemHeight;

@property (nonatomic,strong) NSObject* _Nonnull mt_itemEstimateHeight;

@property (nonatomic,assign) CGSize mt_itemSize;
    
@property (nonatomic,assign) MTDelegateCollectionViewSpacing mt_spacing;

@property (nonatomic,assign) BOOL mt_open3dTouch;

@property (nonatomic,assign) BOOL mt_headerEmptyShow;

@property (nonatomic,copy) MTClick _Nullable mt_click;
@property (nonatomic,copy) MTAutomaticDimensionSize _Nullable mt_automaticDimensionSize;
@property (nonatomic,copy) MTNotificationHandle _Nullable mt_notificationHandle;


@end


typedef NSObject* _Nonnull (^AutomaticDimension) (void);
typedef NSObject* _Nonnull (^AutomaticDimensionSize) (MTAutomaticDimensionSize _Nullable mt_automaticDimensionSize);
typedef NSObject* _Nonnull (^BindNewObjectOrder) (void);
typedef NSObject* _Nonnull (^BindOrder) (NSString* _Nonnull order);
typedef NSObject* _Nonnull (^BindTagIdentifier) (NSString* _Nonnull tagIdentifier);
typedef NSObject* _Nonnull (^BindTag) (NSInteger tag);
typedef NSObject* _Nonnull (^BindIndex) (NSInteger index);
typedef NSObject* _Nonnull (^BindResult) (BOOL result);
typedef id _Nonnull (^BindKey) (NSString* _Nonnull keyName);
typedef id _Nonnull (^BindTagText) (NSString* _Nonnull tagIdentifier);
typedef  NSObject* _Nonnull  (^BindReuseIdentifier) (NSString* _Nonnull reuseIdentifier);
typedef NSObject* _Nonnull (^BindArrayReuseIdentifier) (NSString* _Nonnull reuseIdentifier);
typedef NSObject* _Nonnull (^BindRowHeight) (CGFloat height);
typedef NSObject* _Nonnull (^BindRowsHeight) (NSArray<NSNumber*>* _Nonnull heights);
typedef NSArray* _Nonnull (^BindCount) (NSInteger count);
typedef NSObject* _Nonnull (^BindItemSize) (CGSize itemSize);
typedef NSObject* _Nonnull (^BindArrayItemSize) (CGSize itemSize);
typedef NSObject* _Nonnull (^BindItemsSize) (NSArray<NSValue*>* _Nonnull itemSize);
typedef NSObject* _Nonnull (^BindItemSpacing) (MTDelegateCollectionViewSpacing spacing);
typedef NSObject* _Nonnull (^BindItemsSpacing) (NSArray<NSValue*>* _Nonnull spacing);
typedef NSObject* _Nonnull (^BindNotifications) (NSArray<NSString*>* _Nonnull notifications);
typedef NSObject* _Nonnull (^Bind3dTouch) (void);
typedef NSObject* _Nonnull (^BindHeaderEmptyShow) (void);
typedef NSObject* _Nonnull (^BindClick) (MTClick _Nullable);
typedef NSObject* _Nonnull (^WhenReceiveNotification) (MTNotificationHandle _Nullable);

@interface NSObject (BindReuseIdentifier)

@property (nonatomic,copy,readonly) BindClick _Nonnull bindClick;

@property (nonatomic,copy,readonly) BindOrder _Nonnull bindOrder;
@property (nonatomic,copy,readonly) BindOrder _Nonnull bindArrayOrder;

@property (nonatomic,copy,readonly) AutomaticDimension _Nonnull automaticDimension;
@property (nonatomic,copy,readonly) AutomaticDimensionSize _Nonnull automaticDimensionSize;
@property (nonatomic,copy,readonly) BindNewObjectOrder _Nonnull bindNewObjectOrder;

@property (nonatomic,copy,readonly) BindResult _Nonnull bindResult;
@property (nonatomic,copy,readonly) BindIndex _Nonnull bindIndex;
@property (nonatomic,copy,readonly) BindTag _Nonnull bindEnum;
@property (nonatomic,copy,readonly) BindTagText _Nonnull bindTagText;
@property (nonatomic,copy,readonly) BindTagIdentifier _Nonnull bindTag;

@property (nonatomic,copy,readonly) BindKey _Nonnull bindKey;

@property (nonatomic,copy,readonly) BindCount _Nonnull bindCount;

@property (nonatomic,copy,readonly) BindReuseIdentifier _Nonnull bind;

@property (nonatomic,copy,readonly) BindArrayReuseIdentifier _Nonnull arrBind;

@property (nonatomic,copy,readonly) BindRowHeight _Nonnull bindHeight;

@property (nonatomic,copy,readonly) BindRowsHeight _Nonnull bindRowsHeight;

@property (nonatomic,copy,readonly) BindItemSize _Nonnull bindSize;

@property (nonatomic,copy,readonly) BindArrayItemSize _Nonnull arrBindSize;

@property (nonatomic,copy,readonly) BindItemsSize _Nonnull bindItemsSize;

@property (nonatomic,copy,readonly) BindItemSpacing _Nonnull bindSpacing;

@property (nonatomic,copy,readonly) BindItemsSpacing _Nonnull bindItemsSpacing;
    
@property (nonatomic,copy,readonly) Bind3dTouch _Nonnull bind3dTouch;

@property (nonatomic,copy,readonly) BindHeaderEmptyShow _Nonnull bindHeaderEmptyShow;
 
@property (nonatomic,copy,readonly) id _Nonnull (^ _Nonnull setObjects) (NSObject* _Nullable objects);
- (instancetype _Nullable)setWithObject:(NSObject* _Nullable)obj;
- (instancetype _Nullable)copyBindWithObject:(NSObject* _Nullable)obj;
-(instancetype _Nullable)clearBind;

@end

@interface NSObject (Notification)

//@property (nonatomic,strong) NSArray<NSString*>* _Nullable mt_notifications;

@property (nonatomic,copy,readonly) BindNotifications _Nonnull bindNotifications;

@property (nonatomic,copy,readonly) WhenReceiveNotification _Nonnull whenReceiveNotification;

@end

@interface NSObject (Copy)

/**为了编译器识别 bindNotification 宏*/
@property (nonatomic,assign, readonly) NSInteger bindNotification;

/**为了编译器识别 objects 宏*/
@property (nonatomic,assign, readonly) NSInteger objects;

- (instancetype _Nullable)copyObject;

- (BOOL)isContainProperty:(NSString* _Nullable)propertyName;

@end



@interface NSArray (ReuseIdentifier)

@property (nonatomic,assign, readonly) BOOL isAllArray;

-(NSObject* _Nonnull)getDataByIndex:(NSInteger)index;

@end
