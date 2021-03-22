//
//  NSObject+CommonProtocol.m
//  MDKit
//
//  Created by monda on 2019/6/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "NSObject+CommonProtocol.h"
#import <objc/runtime.h>

@implementation NSObject (CommonProtocol)

+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(mt_dealloc));
    method_exchangeImplementations(method1, method2);
}

- (void)mt_dealloc
{    
    [self whenDealloc];
    [self mt_dealloc];
}

- (void)setupDefault {}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight{return CGSizeZero;}

-(void)startRequest{}

-(void)setMt_delegate:(id<MTDelegateProtocol>)mt_delegate
{
    objc_setAssociatedObject(self, @selector(mt_delegate), mt_delegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<MTDelegateProtocol>)mt_delegate
{
    return objc_getAssociatedObject(self, _cmd);
}

-(id)valueForUndefinedKey:(NSString *)key{return nil;}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
