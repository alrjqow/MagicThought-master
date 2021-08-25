//
//  MTBigimageCellModel.m
//  QXProject
//
//  Created by monda on 2020/5/11.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTBigimageCellModel.h"

@implementation MTBigimageCellModel

#pragma mark - init

-(instancetype)init
{
    if(self = [super init])
    {
        self.bigImageCellClassName = @"MTImageShowCell_Big";
        self.bigImageCellSpacing = 10;
        self.animateTime = 0.25;
        self.maximumZoomScale = 3;        
    }
    
    return self;
}

-(void)setBigImageCellClassName:(NSString *)bigImageCellClassName
{
    if([NSClassFromString(bigImageCellClassName) isSubclassOfClass:NSClassFromString(@"MTImageShowCell_Big")])
        _bigImageCellClassName = bigImageCellClassName;
}

@end
