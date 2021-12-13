//
//  MTBaseViewContentModel.h
//  QXProject
//
//  Created by monda on 2019/12/10.
//  Copyright © 2019 monda. All rights reserved.
//

#import <Photos/Photos.h>
#import "NSObject+CommonProtocol.h"
#import "NSObject+ReuseIdentifier.h"
#import "MTWordStyle.h"
#import "MTBorderStyle.h"
#import "MTConst.h"

typedef NS_ENUM(NSInteger, MTViewContentVerticalAlignment) {
    MTViewContentVerticalCenter        = 0,
    MTViewContentVerticalTop           = 1,
    MTViewContentVerticalBottom        = 2,
    MTViewContentVerticalFill          = 3,
};

typedef NS_ENUM(NSInteger, MTViewContentHorizontalAlignment) {
    MTViewContentHorizontalCenter = 0,
    MTViewContentHorizontalLeft   = 1,
    MTViewContentHorizontalRight  = 2,
    MTViewContentHorizontalFill   = 3,
};

//优先选择 cssClass
@interface MTBaseViewContentModel : NSObject

/**view 的背景色*/
@property (nonatomic,strong) UIColor* backgroundColor;

/**view 的状态*/
@property (nonatomic,assign) NSInteger viewState;

/**view 的内容*/
@property (nonatomic,strong) NSString* text;

/**view 的 wordstyle*/
@property (nonatomic,strong) MTWordStyle* wordStyle;

/**view 的 borderstyle*/
@property (nonatomic,strong) MTBorderStyle* borderStyle;

/**view 的 shadowStyle*/
@property (nonatomic,strong) MTShadowStyle* shadowStyle;

/**view 的 jianBianStyle*/
@property (nonatomic,strong) MTJianBianStyle* jianBianStyle;

/**view 的 cssclass*/
@property (nonatomic,strong) NSString* cssClass;

/**view 的 文本颜色*/
@property (nonatomic,strong) UIColor* textColor;

/**图片*/
@property (nonatomic,strong) UIImage* image;

/**图片名*/
@property (nonatomic,strong) NSString* imageURL;

/**是否下载完图片刷新数据*/
@property (nonatomic,assign) BOOL reloadWebImage;


/**图片或视频*/
@property (nonatomic,strong) PHAsset* asset;

/**视频*/
@property (nonatomic,strong) AVURLAsset* videoAsset;

/**图片*/
@property (nonatomic,strong) id placeholderImage;

/**背景图片名*/
@property (nonatomic,strong) UIImage* image_bg;

/**外边距*/
@property (nonatomic,strong) NSValue* margin;

/**内边距*/
@property (nonatomic,strong) NSValue* padding;

/**是否隐藏*/
@property (nonatomic,strong) NSNumber* isHidden;

/**垂直对齐方式*/
@property (nonatomic,strong) NSNumber* verticalAlignment;

/**水平对齐方式*/
@property (nonatomic,strong) NSNumber* horizontalAlignment;

/**清除按钮类型*/
@property (nonatomic,strong) NSNumber* clearButtonMode;

/**确定按钮类型*/
@property (nonatomic,strong) NSNumber* returnKeyType;

/**键盘类型*/
@property (nonatomic,strong) NSNumber* keyboardType;

/**用户交互*/
@property (nonatomic,strong) NSNumber* userInteractionEnabled;

/**是否作为默认model*/
@property (nonatomic,strong) NSObject* beDefault;

/**最大宽度*/
@property (nonatomic,strong) NSNumber* maxWidth;

/**最小宽度*/
@property (nonatomic,strong) NSNumber* minWidth;

/**最大高度*/
@property (nonatomic,strong) NSNumber* maxHeight;

/**最小高度*/
@property (nonatomic,strong) NSNumber* minHeight;

/**扩展数据*/
@property (nonatomic,strong) NSObject* externData;

@property (nonatomic,strong) NSNumber* noHighLight;


/*-----------------------------------判断用-----------------------------------*/

@property (nonatomic,assign, readonly) BOOL isDefaultOriginModel;

-(void)webImageReload;

@end


@interface MTBaseViewContentStateModel : MTBaseViewContentModel

@property (nonatomic,strong) MTBaseViewContentModel* highlighted;
@property (nonatomic,strong) MTBaseViewContentModel* disabled;
@property (nonatomic,strong) MTBaseViewContentModel* selected;
@property (nonatomic,strong) MTBaseViewContentModel* placeholder;
@property (nonatomic,strong) MTBaseViewContentModel* header;
@property (nonatomic,strong) MTBaseViewContentModel* footer;

@end

CG_EXTERN MTBaseViewContentModel* _Nonnull mt_highlighted(MTBaseViewContentModel* _Nullable model);
CG_EXTERN MTBaseViewContentModel* _Nonnull mt_disabled(MTBaseViewContentModel* _Nullable model);
CG_EXTERN MTBaseViewContentModel* _Nonnull mt_selected(MTBaseViewContentModel* _Nullable model);
CG_EXTERN MTBaseViewContentModel* _Nonnull mt_placeholder(MTBaseViewContentModel* _Nullable model);
CG_EXTERN MTBaseViewContentModel* _Nonnull mt_header(MTBaseViewContentModel* _Nullable model);
CG_EXTERN MTBaseViewContentModel* _Nonnull mt_footer(MTBaseViewContentModel* _Nullable model);

CG_EXTERN NSObject* _Nonnull mt_beDefault(void);

CG_EXTERN NSObject* _Nonnull mt_userInteractionEnabled(BOOL userInteractionEnabled);

CG_EXTERN NSObject* _Nonnull mt_verticalAlignment(MTViewContentVerticalAlignment verticalAlignment);
CG_EXTERN NSObject* _Nonnull mt_horizontalAlignment(MTViewContentHorizontalAlignment horizontalAlignment);

CG_EXTERN NSObject* _Nonnull mt_clearButtonMode(UITextFieldViewMode clearButtonMode);
CG_EXTERN NSObject* _Nonnull mt_returnKeyType(UIReturnKeyType returnKeyType);
CG_EXTERN NSObject* _Nonnull mt_keyboardType(UIKeyboardType keyboardType);

CG_EXTERN NSObject* _Nonnull mt_closeSepLine(BOOL isCloseSepLine);
CG_EXTERN NSObject* _Nonnull mt_isArrow(BOOL isArrow);
CG_EXTERN NSValue* _Nonnull mt_margin(UIEdgeInsets margin);
CG_EXTERN NSValue* _Nonnull mt_padding(UIEdgeInsets padding);
CG_EXTERN NSObject* _Nonnull mt_hidden(BOOL hidden);
CG_EXTERN NSObject* _Nonnull mt_noHighLight(BOOL noHighLight);
CG_EXTERN NSObject* _Nonnull mt_maxWidth(CGFloat maxWidth);
CG_EXTERN NSObject* _Nonnull mt_maxHeight(CGFloat maxHeight);
CG_EXTERN NSObject* _Nonnull mt_minWidth(CGFloat minWidth);
CG_EXTERN NSObject* _Nonnull mt_minHeight(CGFloat minHeight);

CG_EXTERN NSString* _Nonnull mt_css(NSString* _Nullable str);
CG_EXTERN NSObject* _Nonnull mt_textColor(UIColor* _Nullable color);
CG_EXTERN NSObject* _Nonnull mt_image_bg(NSObject* _Nullable img_bg);
CG_EXTERN NSObject* _Nonnull mt_image_url(NSString* _Nullable imageURL);
CG_EXTERN NSObject* _Nonnull mt_reloadWebImage(id _Nonnull imageURL);
CG_EXTERN NSObject* _Nonnull mt_placeholderImage(id _Nullable placeholderImage);


CG_EXTERN NSObject* _Nonnull mt_externData(NSObject* _Nonnull externData);
