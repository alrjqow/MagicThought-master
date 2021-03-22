//
//  MTDelegateCollectionViewCell.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDelegateCollectionViewCell.h"


@implementation MTDelegateCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupDefault];
    }
    
    return self;
}

/**设置父类数据*/
-(void)setSuperResponseObject:(NSObject*)object
{
    if([object isKindOfClass:[super classOfResponseObject]])
        [super whenGetResponseObject:object];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self insertSubview:self.contentView atIndex:0];    
}

@end
