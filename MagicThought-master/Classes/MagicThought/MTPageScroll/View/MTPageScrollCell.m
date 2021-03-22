//
//  MTPageScrollCell.m
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageScrollCell.h"
#import "MTPageControllModel.h"
#import "MTPageScrollCellViewModel.h"

@implementation MTPageScrollCell

-(void)whenGetResponseObject:(MTPageControllModel *)object
{
    ((MTPageScrollCellViewModel*)self.viewModel).model = object;
}

-(NSString *)viewModelClass
{
    return @"MTPageScrollCellViewModel";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
        
    [self.viewModel layoutSubviews];
}

-(Class)classOfResponseObject
{
    return [MTPageControllModel class];
}

@end


@implementation MTPageScrollCellX

-(void)whenGetResponseObject:(MTPageControllModel *)object
{
    ((MTPageScrollCellViewModel*)self.viewModel).model = object;
}

-(NSString *)viewModelClass
{
    return @"MTPageScrollCellViewModel";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
        
    [self.viewModel layoutSubviews];
}

-(Class)classOfResponseObject
{
    return [MTPageControllModel class];
}

@end
