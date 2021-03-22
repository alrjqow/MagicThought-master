//
//  UILabel+LineSpacing.h
//  8kqw
//
//  Created by 王奕聪 on 16/10/8.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpacing)

/**富文本行高*/
-(void)setAttrLineSpacing:(CGFloat)space;

-(void)setLineSpacingFloat:(CGFloat)space;
-(void)setLineSpacing:(CGFloat)space WithWordSpacing:(CGFloat)fontSpacing;

@end
