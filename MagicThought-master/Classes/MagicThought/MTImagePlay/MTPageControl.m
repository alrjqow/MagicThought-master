//
//  MTPageControl.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import "MTPageControl.h"
#import "UIView+Frame.h"
#import "MTConst.h"


@implementation MTPageControl

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.pointSize = CGSizeMake(18, 2);
        self.pointMargin = 10;
        self.selectColor = [UIColor whiteColor];
        self.normalColor = hex(0xF0F0F0);
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(CGSizeEqualToSize(self.pointSize, CGSizeZero))
        return;
    
    
    NSInteger x = self.halfWidth - (self.numberOfPages * self.pointSize.width + (self.numberOfPages - 1) * self.pointMargin) * 0.5;
    UIView* contentView;
    if (@available(iOS 14.0, *))
    {
        for (NSInteger i = 0; i < self.subviews.count; i++)
        {
            UIView* subView = self.subviews[i];
            if([subView isKindOfClass:NSClassFromString(@"_UIPageControlContentView")])
            {
                contentView = subView;
                break;
            }
        }
        for (NSInteger i = 0; i < contentView.subviews.count; i++)
        {
            UIView* subView = contentView.subviews[i];
            if([subView isKindOfClass:NSClassFromString(@"_UIPageControlIndicatorContentView")])
            {
                contentView = subView;
                break;
            }
        }
    }
    if(!contentView)
        contentView = self;
    else
        x = [contentView convertPoint:CGPointMake(x, 0) fromView:self].x;
    
    for (NSInteger i = 0; i < contentView.subviews.count; i++)
    {
        UIView* subView = contentView.subviews[i];
        
        subView.width = self.pointSize.width;
        subView.height = self.pointSize.height;
                
        subView.x = x;
        x = subView.maxX + self.pointMargin;
        
        subView.layer.cornerRadius = 0;
        if(!subView.subviews.count)
            [subView addSubview:[UIView new]];
        else
        {
            subView.subviews.firstObject.frame = subView.bounds;
            subView.subviews.firstObject.backgroundColor = self.currentPage == i ? self.selectColor : self.normalColor;
        }
    }
}

@end
