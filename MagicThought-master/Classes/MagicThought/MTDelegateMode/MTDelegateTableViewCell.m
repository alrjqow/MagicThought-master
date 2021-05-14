//
//  MTDelegateTableViewCell.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDelegateTableViewCell.h"
#import "MTConst.h"

@implementation MTDelegateTableViewCell


/**设置父类数据*/
-(void)setSuperResponseObject:(NSObject*)object
{
    if([object isKindOfClass:[super classOfResponseObject]])
       [super whenGetResponseObject:object];
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupDefault];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self insertSubview:self.contentView atIndex:0];    
    for (UIView* subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"_UISystemBackgroundView")])
        {
            [self insertSubview:self.contentView aboveSubview:subView];
            break;
        }
    }
}

-(NSIndexPath *)indexPath
{
    if(!_indexPath)
    {
        _indexPath = NSIndexPath.new;
    }
    
    return _indexPath;
}

@end

