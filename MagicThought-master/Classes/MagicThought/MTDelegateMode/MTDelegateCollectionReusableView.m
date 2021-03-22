//
//  MTDelegateCollectionReusableView.m
//  MonDaProject
//
//  Created by monda on 2018/6/19.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDelegateCollectionReusableView.h"


@interface MTDelegateCollectionReusableViewLayer : CALayer @end

@implementation MTDelegateCollectionReusableViewLayer
- (CGFloat) zPosition {
    return 0;
}
@end

@implementation MTDelegateCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
            [self setupDefault];
    }
    
    return self;
}


/**设置父类数据*/
-(void)setSuperResponseObject:(NSObject*)object
{
    if([object isKindOfClass:[super classOfResponseObject]])
        [super whenGetResponseObject:object];
}

+(Class)layerClass
{
return [MTDelegateCollectionReusableViewLayer class];
}

@end
