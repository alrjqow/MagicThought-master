//
//  UILabel+Size.h
//  QXProject
//
//  Created by monda on 2020/3/20.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UILabel+Word.h"

@interface UILabel (Size)

+(CGRect)getRectWithRect:(CGRect)rect WordStyle:(MTWordStyle*)wordStyle;

@end

