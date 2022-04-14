//
//  MTAlertView.m
//  QDDProject
//
//  Created by 王奕聪 on 2022/4/14.
//  Copyright © 2022 seenovation. All rights reserved.
//

#import "MTAlertView.h"
#import "NSString+Exist.h"

@implementation MTAlertTipsView

-(void)setupDefault
{
    [super setupDefault];
    
    self.textLabel.defaultViewContent();
    self.detailTextLabel.defaultViewContent();
    
    self.button.defaultViewContent();
    self.button2.defaultViewContent();
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    contentWidth = kScreenWidth_mt() - doubles(50);
 
    [self.textLabel sizeToFit];
    [self.detailTextLabel sizeToFit];
        
    self.textLabel.y = [self getViewY:self.textLabel Spacing:0];

    self.detailTextLabel.numberOfLines = 1;
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.numberOfLines = 0;
    
    if(self.detailTextLabel.width > contentWidth - doubles(self.contentMargin))
        contentWidth = self.detailTextLabel.width + doubles(self.contentMargin);
    
    if(contentWidth > kScreenWidth_mt() - doubles(32))
        contentWidth = kScreenWidth_mt() - doubles(32);
        
    self.detailTextLabel.width = contentWidth - doubles(self.contentMargin);
    [self.detailTextLabel sizeToFit];
            
    self.detailTextLabel.y = [self getViewY:self.detailTextLabel Spacing:!self.textLabel.hidden];
        
    self.textLabel.centerX = self.detailTextLabel.centerX = half(contentWidth);
    
      
    CGFloat y = [self getViewY:self.button Spacing:!self.textLabel.hidden + !self.detailTextLabel.hidden];
    
    if([self.button.titleLabel.text isExist] && [self.button2.titleLabel.text isExist])
    {
        CGFloat width = half(contentWidth - doubles(self.buttonMargin) - self.spacingBetweenButtonAndButton);
                
        self.button.frame = CGRectMake(self.buttonMargin, y, width, self.buttonHeight);
        self.button2.frame = CGRectMake(self.button.maxX + self.spacingBetweenButtonAndButton, y, width, self.buttonHeight);
    }
    else
        self.button.frame = self.button2.frame = CGRectMake(self.buttonMargin, y, contentWidth - doubles(self.buttonMargin), self.buttonHeight);
        
    contentHeight = self.button.maxY + [self spacing:!self.textLabel.hidden + !self.detailTextLabel.hidden + (self.buttonHeight != 0)];
    
    return CGSizeMake(contentWidth, contentHeight);
}

-(CGFloat)getViewY:(UIView*)view Spacing:(NSInteger)index
{
    return [self getPreViewMaxY:view] + [self spacing:index];
}

-(CGFloat)spacing:(NSInteger)index
{
    return self.ySpacingArray.count > index ? self.ySpacingArray[index].integerValue : 0;
}

-(CGFloat)getPreViewMaxY:(UIView*)currentView
{
    NSArray* subViews = @[self.textLabel, self.detailTextLabel, self.button];
    
    UIView* preView;
    for (UIView* subView  in subViews) {
        
        if(subView == currentView)
            break;
        
        if(subView == self.button)
        {
            if(self.buttonHeight)
                preView = subView;
        }
        else
        {
            if(!subView.hidden)
                preView = subView;
        }
    }
        
    return preView ? preView.maxY : 0;
}

@end
