//
//  MTViewContentManager.m
//  QXProject
//
//  Created by monda on 2020/8/12.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTViewContentManager.h"

@implementation MTViewContentManager @end

@implementation UIView(WishViewContent)

-(NSInteger)wishContent{return 0;}

-(NSInteger)wishStateContent{return 0;}

-(NSInteger)wishDefaultContent{return 0;}

-(NSInteger)wishDefaultStateContent{return 0;}

-(BOOL)isAssistCell
{
    return [self.mt_order containsString:@"isAssistCell"];
}

@end

@implementation UIButton(WishViewContent) @end
@implementation UIImageView(WishViewContent) @end
@implementation UILabel(WishViewContent) @end
@implementation UITextField(WishViewContent) @end
@implementation UITextView(WishViewContent) @end



@implementation NSArray (WishViewContent)

-(NSArray*)extendWithArray:(NSArray*)array
{    
    NSMutableArray* newArray = [NSMutableArray array];
    
    [newArray addObjectsFromArray:self];
    [newArray addObjectsFromArray:array];
    return [newArray copy];
}

@end
