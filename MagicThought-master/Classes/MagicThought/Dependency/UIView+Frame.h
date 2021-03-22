//
//  UIView+Frame.h
//  BuDeJie
//
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat width;
@property CGFloat height;

@property CGFloat x;
@property CGFloat y;

@property CGFloat halfWidth;
@property CGFloat halfHeight;

@property CGFloat midX;
@property CGFloat midY;

@property CGFloat maxX;
@property CGFloat maxY;

@property CGFloat centerY;
@property CGFloat centerX;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic,assign) UIEdgeInsets margin;

+ (instancetype)viewFromXib;


@end


@interface UIScrollView (ContentOffset)

@property CGFloat offsetX;
@property CGFloat offsetY;

@end


@interface UIView (IsScrolling)

- (BOOL)isRolling;

@end
