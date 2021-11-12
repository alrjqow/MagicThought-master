//
//  MTLayoutButton.m
//  MagicThought-master
//
//  Created by apple on 2021/6/3.
//

#import "MTLayoutButton.h"
#import "UIView+Frame.h"
#import "MTConst.h"


@interface MTLayoutButton ()

@property (nonatomic,assign) BOOL isSizeToFit;

@end

@implementation MTLayoutButton

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self layoutIfNeeded];
}

-(void)sizeToFit
{
    self.isSizeToFit = YES;
    CGSize size = [self layoutSubviewsForWidth:0 Height:0];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    self.isSizeToFit = false;
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    CGFloat width = 0;
    CGFloat height = 0;
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat closeValue;
    CGFloat parallelValue;
    // closeValue
    {
        if(self.layoutType == MTLayoutButtonLayoutImageInLeft || self.layoutType == MTLayoutButtonLayoutImageInRight)
            closeValue = self.imageView.width + self.titleLabel.width;
        else
            closeValue = self.imageView.height + self.titleLabel.height;
            
        
        switch (self.layoutType) {
            case MTLayoutButtonLayoutImageInLeft:
            {
                self.imageView.x = 0;
                self.titleLabel.maxX = closeValue;
                self.titleLabel.maxX += self.xImageSpacing;
                break;
            }
            case MTLayoutButtonLayoutImageInRight:
            {
                self.titleLabel.x = 0;
                self.imageView.maxX = closeValue;
                self.imageView.maxX += self.xImageSpacing;
                break;
            }
            case MTLayoutButtonLayoutImageInTop:
            {
                self.imageView.y = 0;
                self.titleLabel.maxY = closeValue;
                self.titleLabel.maxY += self.yImageSpacing;
                break;
            }
            case MTLayoutButtonLayoutImageInBottom:
            {
                self.titleLabel.y = 0;
                self.imageView.maxY = closeValue;
                self.imageView.maxY += self.yImageSpacing;
                break;
            }
                
            default:
                break;
        }
        
        if(self.layoutType == MTLayoutButtonLayoutImageInLeft || self.layoutType == MTLayoutButtonLayoutImageInRight)
        {
            closeValue = (self.imageView.maxX > self.titleLabel.maxX ? self.imageView.maxX : self.titleLabel.maxX) -
            (self.imageView.x < self.titleLabel.x ? self.imageView.x : self.titleLabel.x);
            closeValue = ceil(closeValue);
            
            closeValue += self.padding.left;
            closeValue += self.padding.right;
            
            if(self.imageView.x < self.titleLabel.x)
                self.imageView.x = self.padding.left;
            else
                self.titleLabel.x = self.padding.left;
                
            if(self.imageView.maxX > self.titleLabel.maxX)
                self.imageView.maxX = closeValue - self.padding.right;
            else
                self.titleLabel.maxX = closeValue - self.padding.right;
        }
        else
        {
            closeValue = (self.imageView.maxY > self.titleLabel.maxY ? self.imageView.maxY : self.titleLabel.maxY) -
            (self.imageView.y < self.titleLabel.y ? self.imageView.y : self.titleLabel.y);
            closeValue = ceil(closeValue);
            
            closeValue += self.padding.top;
            closeValue += self.padding.bottom;
            
            if(self.imageView.y < self.titleLabel.y)
                self.imageView.y = self.padding.top;
            else
                self.titleLabel.y = self.padding.top;
                
            if(self.imageView.maxY > self.titleLabel.maxY)
                self.imageView.maxY = closeValue - self.padding.bottom;
            else
                self.titleLabel.maxY = closeValue - self.padding.bottom;
        }
    }
      
    // parallelValue
    {
        if(self.layoutType == MTLayoutButtonLayoutImageInLeft || self.layoutType == MTLayoutButtonLayoutImageInRight)
        {
            parallelValue = self.imageView.height > self.titleLabel.height ? self.imageView.height : self.titleLabel.height;
            
            self.titleLabel.centerY = self.imageView.centerY = half(parallelValue);
            self.imageView.centerY += self.yImageSpacing;
            
            parallelValue =
            (self.imageView.maxY > self.titleLabel.maxY ? self.imageView.maxY : self.titleLabel.maxY) -
            (self.imageView.y < self.titleLabel.y ? self.imageView.y : self.titleLabel.y);
            
            CGFloat realParallelValue = parallelValue;
            
            parallelValue += self.padding.top;
            parallelValue += self.padding.bottom;
            parallelValue = ceil(parallelValue);
            
            
            if(realParallelValue == self.imageView.height || realParallelValue == self.titleLabel.height)
            {
                self.titleLabel.centerY = self.imageView.centerY = half(parallelValue);
                self.imageView.centerY += self.yImageSpacing;
            }
            else
            {
                if(self.yImageSpacing > 0)
                {
                    self.imageView.maxY = parallelValue - self.padding.bottom;
                    self.titleLabel.y = self.padding.top;
                }
                else
                {
                    self.titleLabel.maxY = parallelValue - self.padding.bottom;
                    self.imageView.y = self.padding.top;
                }
            }
        }
        else
        {
            parallelValue = self.imageView.width > self.titleLabel.width ? self.imageView.width : self.titleLabel.width;
            
            self.titleLabel.centerX = self.imageView.centerX = half(parallelValue);
            self.imageView.centerX += self.xImageSpacing;
            
            parallelValue =
            (self.imageView.maxX > self.titleLabel.maxX ? self.imageView.maxX : self.titleLabel.maxX) -
            (self.imageView.x < self.titleLabel.x ? self.imageView.x : self.titleLabel.x);
            
            CGFloat realParallelValue = parallelValue;
            
            parallelValue += self.padding.left;
            parallelValue += self.padding.right;
            parallelValue = ceil(parallelValue);
            
            if(realParallelValue == self.imageView.width || realParallelValue == self.titleLabel.width)
            {
                self.titleLabel.centerX = self.imageView.centerX = half(parallelValue);
                self.imageView.centerX += self.xImageSpacing;
            }
            else
            {
                if(self.xImageSpacing > 0)
                {
                    self.imageView.maxX = parallelValue - self.padding.right;
                    self.titleLabel.x = self.padding.left;
                }
                else
                {
                    self.titleLabel.maxX = parallelValue - self.padding.right;
                    self.imageView.x = self.padding.left;
                }
            }
        }
    }
    
    if(self.layoutType == MTLayoutButtonLayoutImageInLeft || self.layoutType == MTLayoutButtonLayoutImageInRight)
    {
        width = closeValue;
        height = parallelValue;
    }
    else
    {
        width = parallelValue;
        height = closeValue;
    }

    if(self.isSizeToFit)
        return CGSizeMake(width, height);
    
    //x轴
    CGFloat offsetX = half(width - contentWidth);
    self.titleLabel.x -= offsetX;
    self.imageView.x -= offsetX;
    
    //y轴
    CGFloat offsetY = half(height - contentHeight);
    self.titleLabel.y -= offsetY;
    self.imageView.y -= offsetY;
    
    return CGSizeMake(contentWidth, contentHeight);
}

@end


@implementation MTLayoutImageInRightButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInRight;
}

@end


@implementation MTLayoutImageInTopButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInTop;
}

@end

@implementation MTLayoutImageInBottomButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInBottom;
}

@end


@interface MTCompressResistButton ()

@property (nonatomic,assign) BOOL isSizeToFit;

@end

@implementation MTCompressResistButton

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self layoutIfNeeded];
}

-(void)sizeToFit
{
    self.isSizeToFit = YES;
    CGSize size = [self layoutSubviewsForWidth:0 Height:0];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    self.isSizeToFit = false;
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    if(self.isSizeToFit)
        switch (self.layoutType) {
            case MTLayoutButtonLayoutImageInLeft:
            case MTLayoutButtonLayoutImageInRight:
            {
                contentWidth = self.imageView.width + self.titleLabel.height + self.xImageSpacing;
                contentHeight = self.imageView.height > self.titleLabel.height ? self.imageView.height : self.titleLabel.height;
                break;
            }
                
            case MTLayoutButtonLayoutImageInTop:
            case MTLayoutButtonLayoutImageInBottom:
            {
                contentWidth = self.imageView.width > self.titleLabel.width ? self.imageView.width : self.titleLabel.width;
                contentHeight = self.imageView.height + self.titleLabel.height + self.yImageSpacing;
                break;
            }
                
            default:
                break;
        }
    
    
    switch (self.layoutType) {
        case MTLayoutButtonLayoutImageInLeft:
        case MTLayoutButtonLayoutImageInRight:
        {
            self.titleLabel.width = contentWidth - self.imageView.width - self.xImageSpacing;
            self.imageView.centerY = self.titleLabel.centerY = half(contentHeight);
            break;
        }
            
        case MTLayoutButtonLayoutImageInTop:
        case MTLayoutButtonLayoutImageInBottom:
        {
            self.imageView.centerX = self.titleLabel.centerX = half(contentWidth);
            break;
        }
            
        default:
            break;
    }
    
    
    switch (self.layoutType) {
        case MTLayoutButtonLayoutImageInLeft:
        {
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            
            self.imageView.x = 0;
            self.titleLabel.x = self.imageView.maxX + self.xImageSpacing;
            break;
        }
            
        case MTLayoutButtonLayoutImageInRight:
        {
            self.titleLabel.x = 0;
            self.imageView.x = self.titleLabel.maxX + self.xImageSpacing;
            break;
        }
            
        case MTLayoutButtonLayoutImageInTop:
        {
            self.imageView.y = 0;
            self.titleLabel.y = self.imageView.maxY + self.yImageSpacing;
            break;
        }
            
        case MTLayoutButtonLayoutImageInBottom:
        {
            self.titleLabel.y = 0;
            self.imageView.y = self.titleLabel.maxY + self.yImageSpacing;
            break;
        }
            
        default:
            break;
    }

    return CGSizeMake(contentWidth, contentHeight);
}


@end

@implementation MTCompressResistInRightButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInRight;
}

@end


@implementation MTCompressResistInTopButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInTop;
}

@end

@implementation MTCompressResistInBottomButton

-(MTLayoutButtonLayoutType)layoutType
{
    return MTLayoutButtonLayoutImageInBottom;
}

@end

