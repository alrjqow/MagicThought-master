//
//  MTPageControl.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import "MTPageControl.h"
#import "UIView+Frame.h"
#import "UIView+Circle.h"
#import "MTConst.h"


@implementation MTPageControl

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.pointSize = CGSizeMake(18, 2);
        self.pointMargin = 10;
        self.selectBorderStyle = mt_BorderStyleMake(0, 0, nil).fill([UIColor whiteColor]);
        self.normalBorderStyle = mt_BorderStyleMake(0, 0, nil).fill(hex(0xF0F0F0));
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    

    if(!self.pointSize.width || !self.pointSize.height)
        return;
    
    BOOL isSelectedPointSize = self.selectedPointSize.width && self.selectedPointSize.height;
        
    NSInteger x = self.halfWidth - ((self.numberOfPages - (isSelectedPointSize ? 1 : 0)) * self.pointSize.width + (isSelectedPointSize ? self.selectedPointSize.width : 0) + (self.numberOfPages - 1) * self.pointMargin) * 0.5;
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
        
        CGSize pointSize = self.pointSize;
        if(self.currentPage == i && self.selectedPointSize.width && self.selectedPointSize.height)
            pointSize = self.selectedPointSize;
                
        subView.width = pointSize.width;
        subView.height = pointSize.height;
                
        subView.x = x;
        x = subView.maxX + self.pointMargin;
        
        subView.layer.cornerRadius = 0;
        if(!subView.subviews.count)
            [subView addSubview:[UIView new]];
        else
        {
            subView.subviews.firstObject.frame = subView.bounds;
            
            [subView.subviews.firstObject becomeCircleWithBorder:self.currentPage == i ? self.selectBorderStyle : self.normalBorderStyle];
        }
    }
}

@end
