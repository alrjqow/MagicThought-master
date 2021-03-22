//
//  MTRefreshGifHeader.m
//  MonDaProject
//
//  Created by monda on 2018/6/15.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTRefreshGifHeader.h"
#import "UIView+Frame.h"
#import "NSString+Exist.h"
#import "MTConst.h"


@interface MTRefreshGifHeader ()

@property (nonatomic,strong) UIImageView* imgView;

@property (nonatomic,strong) CABasicAnimation* animation;

@end


@implementation MTRefreshGifHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview
{
    self.headerHeight = 54;
    self.labelLeftInset = 10;
    self.stateLabel.font = [UIFont systemFontOfSize:11];
    self.stateLabel.textColor = hex(0x666666);
//    [self setImages:@[[UIImage imageNamed:@"icon_reflesh"]] forState:MJRefreshStateIdle];
//    [self setImages:@[[UIImage imageNamed:@"icon_reflesh_down"]] forState:MJRefreshStatePulling];
//    [self setImages:@[[UIImage new]] forState:MJRefreshStateRefreshing];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    
    if (@available(iOS 8.2, *)) {
        self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightThin];
    } else {
        self.lastUpdatedTimeLabel.font = mt_font(11);        
    }

    [self addSubview:self.imgView];
}

-(void)setState:(MJRefreshState)state
{
    self.imgView.hidden = state != MJRefreshStateRefreshing;
    
//    state == MJRefreshStateRefreshing ? [self.imgView.layer addAnimation:self.animation forKey:@"refreshing"] : [self.imgView.layer removeAnimationForKey:@"refreshing"];
    
    [super setState:state];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.headerHeight;
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat refreshContentHeight = 50;
    CGFloat labelHeight = refreshContentHeight/2;
    
    self.lastUpdatedTimeLabel.height = labelHeight;
    self.lastUpdatedTimeLabel.maxY = self.height;
    
    self.stateLabel.height = labelHeight;
    self.stateLabel.maxY = self.lastUpdatedTimeLabel.y;
    
    [self.imgView sizeToFit];
    self.imgView.y = self.stateLabel.y;
    self.imgView.centerX = self.centerX;
    
    for(UIView* subView in self.subviews)
    {
        if(![subView isKindOfClass:[UIImageView class]])
            continue;
        if(subView == self.imgView)
            continue;
        
        subView.height *= 0.5;
        subView.width = self.halfWidth;
        subView.width -= (2 * 11 + 10);
        subView.centerY = self.stateLabel.centerY;
    }
}

#pragma mark - 懒加载

-(void)setLoadingIcon:(NSString *)loadingIcon
{
    _loadingIcon = loadingIcon;
    
    if([loadingIcon isExist])
        _imgView.image = [UIImage imageNamed:loadingIcon];
    
    [self layoutIfNeeded];
}

-(UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView = [UIImageView new];
        self.loadingIcon = self.loadingIcon;        
    }
    
    return _imgView;
}

-(CABasicAnimation *)animation
{
    if(!_animation)
    {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        //逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 0.8;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //一直自旋转
        animation.removedOnCompletion = NO;
        
        
        _animation = animation;
    }
    
    return _animation;
}



@end
