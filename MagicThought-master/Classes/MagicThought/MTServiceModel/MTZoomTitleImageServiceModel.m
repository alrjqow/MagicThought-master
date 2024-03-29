//
//  MTZoomTitleImageServiceModel.m
//  XHProject
//
//  Created by apple on 2021/9/9.
//

#import "MTZoomTitleImageServiceModel.h"
#import "UIDevice+DeviceInfo.h"

@interface MTZoomTitleImageServiceModel ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView* imageView;

@property (nonatomic,assign) CGFloat imageViewY;
@property (nonatomic,assign) CGFloat imageViewX;

@property (nonatomic,strong) UIView* bottomZoomView;

@property (nonatomic,strong) UIView* topZoomView;

@property (nonatomic,strong) UIView* shadowCardView;
@property (nonatomic,assign) CGFloat shadowCardViewY;

@end

@implementation MTZoomTitleImageServiceModel

-(void)setShadowCardViewWithLayout:(void (^)(UIView* shadowCardView))layout
{
    if(layout)
        layout(self.shadowCardView);
    self.shadowCardViewY = self.shadowCardView.y;
    [self.controller.view insertSubview:self.shadowCardView atIndex:0];
}

-(void)setTitleImageZoomWithLayout:(void (^)(UIImageView* imageView))layout
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
        
    if(layout)
        layout(self.imageView);
    self.imageView.bindHeight(self.imageView.height);
    self.imageViewX = self.imageView.x;
    self.imageViewY = self.imageView.y;
        
    [self.controller.view insertSubview:self.imageView atIndex:0];
}

-(void)setTitleImageZoom:(NSString*)image
{
    self.imageView.image = [UIImage imageNamed:image];
    
    [self.imageView sizeToFit];
    CGFloat scale = self.imageView.height / self.imageView.width;
    self.imageView.bounds = CGRectMake(0, 0, kScreenWidth_mt(), scale * kScreenWidth_mt());
    self.imageView.bindHeight(self.imageView.height);
    self.imageView.x = self.imageView.y = 0;
    
    [self.controller.view insertSubview:self.imageView atIndex:0];
}

-(void)setTopZoomWithColor:(UIColor *)backgroundColor BaseHeight:(CGFloat)baseHeight
{
    self.topZoomView.backgroundColor = backgroundColor;
    self.topZoomView.bindHeight(baseHeight);
    [self.controller.view insertSubview:self.topZoomView atIndex:0];
    self.topZoomView.frame = CGRectMake(0, 0, self.controller.view.width, baseHeight);
}

-(void)setBottomZoomWithColor:(UIColor *)backgroundColor
{
    self.bottomZoomView.backgroundColor = backgroundColor;
    [self.controller.view insertSubview:self.bottomZoomView atIndex:0];
    self.bottomZoomView.frame = CGRectMake(0, 0, self.controller.view.width, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    _shadowCardView.y = self.shadowCardViewY - scrollView.offsetY - scrollView.contentInset.top;
    
    CGFloat maxOffsetY = scrollView.contentSize.height - scrollView.height - (kIsHairScreen() ? 34 : 0);
    if(scrollView.contentSize.height < scrollView.height)
        maxOffsetY = 0;
    
    if((maxOffsetY >= 0 || !scrollView.contentSize.height) && scrollView.offsetY >= maxOffsetY)
    {
        _bottomZoomView.height = scrollView.offsetY - maxOffsetY;
        _bottomZoomView.maxY = self.controller.view.height;
    }
            
    if(scrollView.offsetY <= -scrollView.contentInset.top)
    {
        _imageView.height = _imageView.mt_itemHeight - scrollView.offsetY - scrollView.contentInset.top;
        _imageView.x = self.imageViewX;
        _imageView.y = self.imageViewY;        
        
        _topZoomView.height =  _topZoomView.mt_itemHeight - scrollView.offsetY - scrollView.contentInset.top;
        _topZoomView.x = _topZoomView.y = 0;
    }
}

-(UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = (id) UIImageView.new;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imageView;
}

-(UIView *)bottomZoomView
{
    if(!_bottomZoomView)
    {
        _bottomZoomView = UIView.new;
    }
    
    return _bottomZoomView;
}

-(UIView *)topZoomView
{
    if(!_topZoomView)
    {
        _topZoomView = UIView.new;
    }
    
    return _topZoomView;
}

-(UIView *)shadowCardView
{
    if(!_shadowCardView)
    {
        _shadowCardView = UIView.new;
    }
    
    return _shadowCardView;
}

@end
