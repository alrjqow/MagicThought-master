//
//  UIImage+PropertyExtension.m
//  8kqw
//
//  Created by 王奕聪 on 2017/6/14.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "UIImage+PropertyExtension.h"
#import <objc/runtime.h>

@implementation UIImage (PropertyExtension)

static const void* kId = "Id";
static const void* klocalIdentifier = "localIdentifier";

-(void)setLocalIdentifier:(NSString *)localIdentifier
{
    objc_setAssociatedObject(self, klocalIdentifier, localIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)localIdentifier
{
    return  objc_getAssociatedObject(self, klocalIdentifier);
}


-(void)setId:(NSString *)Id
{
    objc_setAssociatedObject(self, kId, Id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)Id
{
    return  objc_getAssociatedObject(self, kId);
}


@end
