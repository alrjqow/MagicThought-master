//
//  MTNavigationBar.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/4/23.
//

#import "MTNavigationBar.h"
#import "MTConst.h"
#import "UIView+Frame.h"

@implementation MTNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth_mt(), kNavigationBarHeight_mt())];        
    return self;
}

-(void)setupDefault
{
    [super setupDefault];
    
    _navigationBarCenterY = kStatusBarHeight_mt() + (self.height - kStatusBarHeight_mt()) * 0.5;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.button.defaultViewContent();
    self.button2.defaultViewContent();
    self.textLabel.defaultViewContent();
}

-(void)setButton2:(UIButton *)button2
{
    [self.button2 removeFromSuperview];
    
    [super setButton2:button2];
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    if(!self.button.width || !self.button.height)
       [self.button sizeToFit];
    self.button.center = CGPointMake(self.button.halfWidth, self.navigationBarCenterY);
    
    if(!self.button2.width || !self.button2.height)
        [self.button2 sizeToFit];
    self.button2.center = CGPointMake(contentWidth - self.button2.halfWidth, self.navigationBarCenterY);
     
    self.textLabel.hidden = false;
     [self.textLabel sizeToFit];
     CGFloat maxWidth = contentWidth - self.button.width - self.button2.width;
     if(self.textLabel.width > maxWidth)
         self.textLabel.width = maxWidth;
         
     self.textLabel.centerX = half(contentWidth);
     self.textLabel.centerY = self.navigationBarCenterY;
    return CGSizeMake(contentWidth, contentHeight);
}

@end
