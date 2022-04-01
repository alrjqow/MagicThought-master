//
//  MTNavigationBar.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/4/23.
//

#import "MTProjectArchitectureManager.h"
#import "MTNavigationBar.h"
#import "MTConst.h"
#import "UIView+Frame.h"

@implementation MTNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth_mt(), kNavigationBarHeight_mt())];
    _navigationBarCenterY = kStatusBarHeight_mt() + (self.height - kStatusBarHeight_mt()) * 0.5;
    
    return self;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self button];
    [self button2];
    [self textLabel];
    
    if(kArchitectureManager_mt.baseNavigationBarSetupDefault)
        kArchitectureManager_mt.baseNavigationBarSetupDefault(self);
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
    
    CGSize size = CGSizeMake(contentWidth, contentHeight);
    if(self.setupDefaultModel && self.setupDefaultModel.layoutSubviews)
        size = self.setupDefaultModel.layoutSubviews(self, contentWidth, contentHeight);
            
    return size;
}

@end
