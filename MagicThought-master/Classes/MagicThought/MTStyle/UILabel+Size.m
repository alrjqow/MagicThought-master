//
//  UILabel+Size.m
//  QXProject
//
//  Created by monda on 2020/3/20.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UILabel+Size.h"
#import "UIView+Frame.h"

@implementation UILabel (Size)

+(CGRect)getRectWithRect:(CGRect)rect WordStyle:(MTWordStyle*)wordStyle
{
    static UILabel* label;
    if(!label)
        label = [UILabel new];
                
    [label setWordWithStyle:wordStyle];
    label.numberOfLines = 0;
    
    label.frame = rect;
    [label sizeToFit];
    
    rect = label.frame;
    rect.size.width = ceilf(rect.size.width);
    rect.size.height = ceilf(rect.size.height);
    label.frame = rect;
    
    return label.frame;
}

@end


UILabel* stringLabel(void)
{
    static UILabel* stringLabel;
    
    if(!stringLabel)
        stringLabel = UILabel.new;
    
    return stringLabel;
}

@implementation NSString (WordSize)

-(CGFloat)calculateHeightWithWidth:(CGFloat)width WordStyle:(MTWordStyle*)wordStyle
{
    wordStyle.wordName = self;
    
    UILabel* label = stringLabel();    
    [label setWordWithStyle:wordStyle];

    label.width = width;
    [label sizeToFit];
    
    return label.height;
}

-(CGFloat)calculateWidthWithHeight:(CGFloat)height WordStyle:(MTWordStyle*)wordStyle
{
    UILabel* label = stringLabel();
    [label setWordWithStyle:wordStyle];

    label.height = height;
    [label sizeToFit];
    
    return label.width;
}


@end
