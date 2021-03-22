//
//  MTDelegateView.m
//  8kqw
//
//  Created by 王奕聪 on 2016/12/24.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import "MTDelegateView.h"
#import "MJExtension.h"

@implementation MTDelegateView


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupDefault];
    }
    
    return self;
}

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:NSClassFromString(@"MTBaseViewContentModel")] || [obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
        return [super setWithObject:obj];
     
    if(![obj isKindOfClass:self.classOfResponseObject])
    {
        if([obj isKindOfClass:[NSDictionary class]] && [self.classOfResponseObject isSubclassOfClass:[NSObject class]])
        {
            NSObject* model = [self.classOfResponseObject mj_objectWithKeyValues:obj];
            if(!model)
                return self;
            
            obj = [model copyBindWithObject:obj];
        }
        else
            return self;
    }
    
    [self whenGetResponseObject:obj];
    return self;
}

@end



