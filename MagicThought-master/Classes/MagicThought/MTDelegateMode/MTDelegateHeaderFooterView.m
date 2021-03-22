//
//  MTDelegateHeaderFooterView.m
//  8kqw
//
//  Created by 王奕聪 on 2017/5/16.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTDelegateHeaderFooterView.h"


@implementation MTDelegateHeaderFooterView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
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

@end
