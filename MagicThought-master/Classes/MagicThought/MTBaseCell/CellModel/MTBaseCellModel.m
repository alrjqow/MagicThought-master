//
//  MTBaseCellModel.m
//  QXProject
//
//  Created by monda on 2019/12/6.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseCellModel.h"

@implementation MTBaseCellModel

-(void)setupDefault
{
    [super setupDefault];
    
    // -1 表示不作任何修改
    self.sepLineWidth = -1;
//    self.accessoryMarginRight = -1;
}

@end



NSString*  MTEmptyBaseCellRefreshOrder = @"MTEmptyBaseCellRefreshOrder";
@implementation MTEmptyBaseCellModel

-(NSString *)refreshOrder
{
    return MTEmptyBaseCellRefreshOrder;
}

@end




