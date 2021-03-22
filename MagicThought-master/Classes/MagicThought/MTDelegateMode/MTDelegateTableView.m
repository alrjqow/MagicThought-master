//
//  MTDelegateTableView.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/8.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDelegateTableView.h"

@implementation MTDelegateTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
        [self setupDefault];
    }
    
    return self;
}

@end


