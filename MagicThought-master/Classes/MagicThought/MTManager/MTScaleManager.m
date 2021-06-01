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
    if([MTScaleManager registerScaleManager].screenWidthScaleBase > 0)
        return w * kScreenWidth_mt() / [MTScaleManager registerScaleManager].screenWidthScaleBase;
    return w;
}

CGFloat kScreenHeightScale(CGFloat h)
{
    if([MTScaleManager registerScaleManager].screenHeightScaleBase > 0)
        return h * kScreenHeight_mt() / [MTScaleManager registerScaleManager].screenHeightScaleBase;
    return h;
}

CGFloat kScreenHeightNoNavigtionBarScale(CGFloat h)
{
    CGFloat base = [MTScaleManager registerScaleManager].screenHeightScaleBase - [MTScaleManager registerScaleManager].navigationBarHeightScaleBase;
    if(base > 0)
        return h * (kScreenHeight_mt() - kNavigationBarHeight_mt()) / base;
    
    return h;
}
