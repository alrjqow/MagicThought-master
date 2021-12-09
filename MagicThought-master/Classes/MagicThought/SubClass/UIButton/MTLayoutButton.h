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

@property (nonatomic,assign) CGFloat sizeFitWidth;
@property (nonatomic,assign) CGFloat sizeFitHeight;


@end

@interface MTLayoutImageInRightButton : MTLayoutButton @end

@interface MTLayoutImageInTopButton : MTLayoutButton @end

@interface MTLayoutImageInBottomButton : MTLayoutButton @end


@interface MTCompressResistButton : MTButton

@property (nonatomic,assign) MTLayoutButtonLayoutType layoutType;

@property (nonatomic,assign) UIEdgeInsets padding;

@property (nonatomic,assign) CGFloat xImageSpacing;
@property (nonatomic,assign) CGFloat yImageSpacing;

@end


@interface MTCompressResistInRightButton : MTCompressResistButton @end

@interface MTCompressResistInTopButton : MTCompressResistButton @end

@interface MTCompressResistInBottomButton : MTCompressResistButton @end
