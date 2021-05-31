//
//  MTScaleManager.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/25.
//

#import "MTScaleManager.h"
#import "MTConst.h"
@implementation MTScaleManager

+(instancetype)registerScaleManager{return [self manager];}

@end

CGFloat kScreenWidthScale(CGFloat w)
{
    if(kScaleManager_mt.screenWidthScaleBase > 0)
        return w * kScreenWidth_mt() / kScaleManager_mt.screenWidthScaleBase;
    return w;
}

CGFloat kScreenHeightScale(CGFloat h)
{
    if(kScaleManager_mt.screenHeightScaleBase > 0)
        return h * kScreenHeight_mt() / kScaleManager_mt.screenHeightScaleBase;
    return h;
}

CGFloat kScreenHeightNoNavigtionBarScale(CGFloat h)
{
    CGFloat base = kScaleManager_mt.screenHeightScaleBase - kScaleManager_mt.navigationBarHeightScaleBase;
    if(base > 0)
        return h * (kScreenHeight_mt() - kNavigationBarHeight_mt()) / base;
    
    return h;
}
