//
//  MTDelegatePickerViewCell.m
//  SimpleProject
//
//  Created by monda on 2019/6/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDelegatePickerViewCell.h"

#import "UILabel+Word.h"
#import "MTWordStyle.h"
#import "MTConst.h"

@implementation MTDelegatePickerViewCell

-(void)whenGetResponseObject:(NSObject *)object
{
    self.textLabel.textColor = self.indexPath.row == self.selectedRow ? hex(0x2976f4) : hex(0x333333);
}

-(void)setupDefault
{
    [super setupDefault];
    
    [self.textLabel setWordWithStyle:mt_WordStyleMake(12, nil, hex(0x333333))];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = self.contentView.bounds;
}


-(Class)classOfResponseObject
{
    return [NSString class];
}

@end
