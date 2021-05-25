//
//  MTScaleManager.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/25.
//

#import "MTScaleManager.h"
#import "MTConst.h"
@implementation MTScaleManager

@end

MTScaleManager* kScaleManager()
{
    return [NSClassFromString(@"__MTScaleManager__") manager];
}

CGFloat kScreenWidthScale(CGFloat w)
{
    if(kScaleManager().screenWidthScaleBase > 0)
        return w * kScreenWidth_mt() / kScaleManager().screenWidthScaleBase;
    return w;
}

CGFloat kScreenHeightScale(CGFloat h)
{
    if(kScaleManager().screenHeightScaleBase > 0)
        return h * kScreenHeight_mt() / kScaleManager().screenHeightScaleBase;
    return h;
}

CGFloat kScreenHeightNoNavigtionBarScale(CGFloat h)
{
    CGFloat base = kScaleManager().screenHeightScaleBase - kScaleManager().navigationBarHeightScaleBase;
    if(base > 0)
        return h * (kScreenHeight_mt() - kNavigationBarHeight_mt()) / base;
    
    return h;
}
