//
//  MTTenScrollView.m
//  DaYiProject
//
//  Created by monda on 2018/12/26.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTTenScrollView.h"
#import "MTTenScrollViewDelegateModel.h"


@implementation MTTenScrollView

-(NSString *)viewModelClass
{
    return @"MTTenScrollViewDelegateModel";
}

@end

@implementation MTTenScrollViewX


-(NSString *)viewModelClass
{
    return @"MTTenScrollViewDelegateModel";
}

@end


@implementation MTDelegateTenScrollView

-(NSString *)viewModelClass
{
    return @"MTDelegateTenScrollViewDelegateModel";
}

@end

@implementation MTDelegateTenScrollViewX

-(NSString *)viewModelClass
{
    return @"MTDelegateTenScrollViewDelegateModel";
}

@end




@implementation UIScrollView (MTTenScrollModel)

-(void)setMt_tenScrollModel:(MTTenScrollModel *)mt_tenScrollModel
{
    ((MTTenScrollViewBaseDelegateModel*)self.viewModel).model = mt_tenScrollModel;
}

-(MTTenScrollModel *)mt_tenScrollModel
{
    return ((MTTenScrollViewBaseDelegateModel*)self.viewModel).model;
}

@end
