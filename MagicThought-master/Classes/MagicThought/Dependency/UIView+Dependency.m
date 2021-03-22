//
//  UIView+Dependency.m
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIView+Dependency.h"
#import "NSObject+ReuseIdentifier.h"
#import "UIView+Frame.h"
#import "objc/runtime.h"
#import "UIView+Delegate.h"

@interface UIButton()

@property (nonatomic,assign) BOOL autoClick;

@end

@implementation UIButton (Click)

-(BindClick)bindClick
{
    if(!self.autoClick)
    {
        self.autoClick = YES;
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return [super bindClick];
}

-(void)buttonClick
{
    if(self.mt_click)
        self.mt_click(self.mt_order);
}

- (void)clearClick
{
    self.autoClick = false;
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTarget:(nullable id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setAutoClick:(BOOL)autoClick
{
    objc_setAssociatedObject(self, @selector(autoClick), @(autoClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)autoClick
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end




@implementation UIButton (HighLight)

-(void)noHighLight
{
     [self addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}

-(void)resetHighLight
{
    [self removeTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
}

@end

@implementation MTButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutSubviewsForWidth:self.width Height:self.height];
}

@end
