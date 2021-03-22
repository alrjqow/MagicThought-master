//
//  UILabel+Size.m
//  QXProject
//
//  Created by monda on 2020/3/20.
//  Copyright © 2020 monda. All rights reserved.
//

#import "UILabel+Size.h"

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
