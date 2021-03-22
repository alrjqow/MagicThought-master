//
//  MTImageCell.m
//  QXProject
//
//  Created by 王奕聪 on 2020/1/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImageCell.h"

@implementation MTImageCell

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    [super layoutSubviewsForWidth:contentWidth Height:contentHeight];
    
    self.imageView.frame = self.contentView.bounds;
    
    return CGSizeZero;
}

@end
