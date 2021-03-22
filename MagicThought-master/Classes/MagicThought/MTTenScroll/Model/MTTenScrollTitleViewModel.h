//
//  MTTenScrollTitleViewModel.h
//  DaYiProject
//
//  Created by monda on 2018/12/20.
//  Copyright © 2018 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    
    /**默认滚动时根据移动的cell宽度变化*/
    MTTenScrollTitleViewBottomLineDefault,
    
    /**粘性变化*/
    MTTenScrollTitleViewBottomLineStickiness
        
} MTTenScrollTitleViewBottomLineStyle;

@class MTWordStyle;
@interface MTTenScrollTitleViewModel : NSObject

@property (nonatomic,strong) MTWordStyle* normalStyle;

@property (nonatomic,strong) MTWordStyle* selectedStyle;

@property (nonatomic,assign) CGFloat margin;

@property (nonatomic,assign) CGFloat padding;

/**要开启才能用下面的属性*/
@property (nonatomic,assign) BOOL isEqualBottomLineWidth;
/**固定下划线高度*/
@property (nonatomic,assign) CGFloat bottomLineWidth;
/**下划线变化样式*/
@property (nonatomic,assign) MTTenScrollTitleViewBottomLineStyle bottomLineStyle;

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

@end


