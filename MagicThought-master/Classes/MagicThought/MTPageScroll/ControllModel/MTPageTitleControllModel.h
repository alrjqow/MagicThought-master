//
//  MTPageTitleControllModel.h
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTConst.h"
#import "MTWordStyle.h"
#import "MTBorderStyle.h"
#import "MTDataSourceModel.h"

typedef enum : NSInteger {
    
    /**默认滚动时根据移动的cell宽度变化*/
    MTPageTitleViewBottomLineDefault,
    
    /**粘性变化*/
    MTPageTitleViewBottomLineStickiness
        
} MTPageTitleViewBottomLineStyle;

@interface MTPageTitleControllModel : NSObject

@property (nonatomic,strong) MTWordStyle* normalStyle;

@property (nonatomic,strong) MTWordStyle* selectedStyle;

@property (nonatomic,assign) CGFloat margin;

@property (nonatomic,assign) CGFloat padding;

/**要开启才能用下面的属性*/
@property (nonatomic,assign) BOOL isEqualBottomLineWidth;
/**固定下划线宽度*/
@property (nonatomic,assign) CGFloat bottomLineWidth;
/**固定下划线高度*/
@property (nonatomic,assign) CGFloat bottomLineHeight;
/**下划线延伸的宽度*/
@property (nonatomic,assign) CGFloat bottomLinePadding;

/**固定下划线距离底部距离*/
@property (nonatomic,assign) CGFloat bottomLineBottomMargin;

/**下划线边框*/
@property (nonatomic,strong) MTBorderStyle* bottomLineBorderStyle;

/**下划线阴影*/
@property (nonatomic,strong) MTShadowStyle* bottomLineShadowStyle;

/**下划线变化样式*/
@property (nonatomic,assign) MTPageTitleViewBottomLineStyle bottomLineStyle;

/**要开启才能用下面的属性*/
@property (nonatomic,assign) BOOL isEqualCellWidth;
/**固定下划线高度*/
@property (nonatomic,assign) CGFloat cellWidth;

@property (nonatomic,strong) UIColor* bottomLineColor;
@property (nonatomic,strong) UIImage* bottomLineImage;

/**标题高度*/
@property (nonatomic,assign) CGFloat titleViewHeight;

/**标题背景*/
@property (nonatomic,strong) UIColor* titleViewBgColor;

@property (nonatomic,strong) MTDataSourceModel* dataSourceModel;

@end

