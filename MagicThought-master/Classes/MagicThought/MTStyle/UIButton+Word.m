//
//  UIButton+Word.m
//  MyTool
//
//  Created by 王奕聪 on 2017/4/11.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "UIButton+Word.h"


@implementation UIButton (Word)

-(instancetype)setWordWithStyle:(MTWordStyle*)style
{
    return [self setWordWithStyle:style State:UIControlStateNormal];
}

-(instancetype)setWordWithStyle:(MTWordStyle*)style State:(UIControlState)state
{
    self.titleLabel.lineBreakMode = style.wordLineBreakMode;
    self.titleLabel.numberOfLines = style.wordNumberOfLines;
    
    if(style.isAttributedWord)
    {
        [self setAttributedTitle:style.attributedWordName forState:state];
        [self sizeToFit];
        return self;
    }
    
    if(style.wordColor)
        [self setTitleColor:style.wordColor forState:state];
    
    if(style.wordSize)
    {
        if((style.wordBold && style.wordThin) || (!style.wordBold && !style.wordThin))
            self.titleLabel.font = [UIFont systemFontOfSize:style.wordSize];
        else if(style.wordBold)
            self.titleLabel.font = [UIFont boldSystemFontOfSize:style.wordSize];
        else if(style.wordThin)
        {
            if (@available(iOS 8.2, *))
                self.titleLabel.font = [UIFont systemFontOfSize:style.wordSize weight:UIFontWeightThin];
            else
                self.titleLabel.font = [UIFont systemFontOfSize:style.wordSize];
        }
    }
    
    self.titleLabel.textAlignment = style.wordHorizontalAlignment;
    [self setTitle:style.wordName forState:state];
    [self sizeToFit];
    return self;
}

@end
