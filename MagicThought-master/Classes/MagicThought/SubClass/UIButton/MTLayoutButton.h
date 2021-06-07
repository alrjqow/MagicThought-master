//
//  MTLayoutButton.h
//  MagicThought-master
//
//  Created by apple on 2021/6/3.
//

#import "UIView+Delegate.h"
#import "UIView+Dependency.h"

typedef enum : NSUInteger {
    MTLayoutButtonLayoutImageInLeft,
    MTLayoutButtonLayoutImageInRight,
    MTLayoutButtonLayoutImageInTop,
    MTLayoutButtonLayoutImageInBottom,
} MTLayoutButtonLayoutType;


@interface MTLayoutButton : MTButton

@property (nonatomic,assign) MTLayoutButtonLayoutType layoutType;

@property (nonatomic,assign) UIEdgeInsets padding;

@property (nonatomic,assign) CGFloat xImageSpacing;
@property (nonatomic,assign) CGFloat yImageSpacing;


@end

@interface MTLayoutImageInRightButton : MTLayoutButton @end

@interface MTLayoutImageInTopButton : MTLayoutButton @end

@interface MTLayoutImageInBottomButton : MTLayoutButton @end
