//
//  UIView+Copy.m
//  MonDaProject
//
//  Created by monda on 2018/4/8.
//  Copyright © 2018年 monda. All rights reserved.
//

#import "UIView+Copy.h"

@implementation UIView (Copy)

- (instancetype)copyView
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}



@end
