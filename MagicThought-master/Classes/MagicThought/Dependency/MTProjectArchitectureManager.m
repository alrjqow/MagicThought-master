//
//  MTProjectArchitectureManager.m
//  MagicThought-master
//
//  Created by apple on 2022/3/8.
//

#import "MTProjectArchitectureManager.h"

@implementation MTProjectArchitectureManager

-(void)setupDefault
{
    self.baseSystemNavigationBarHidden = YES;
    self.vfCodeTotalSecond = 60;
}

-(UIColor*)baseBackgroundColor
{
    if(!_baseBackgroundColor)
    {
        _baseBackgroundColor = [UIColor whiteColor];
    }
    
    return _baseBackgroundColor;
}

-(UIColor*)basePageScrollListBackgroundColor
{
    if(!_basePageScrollListBackgroundColor)
    {
        _basePageScrollListBackgroundColor = [UIColor clearColor];
    }
    
    return _baseBackgroundColor;
}

-(NSString*)baseNavigationBarClassName
{
    if(!_baseNavigationBarClassName)
    {
        _baseNavigationBarClassName = @"MTNavigationBar";
    }
    
    return _baseNavigationBarClassName;
}

-(BOOL)isOnline{return [[(id)[UIApplication sharedApplication].delegate valueForKey:@"isOnline"] boolValue];}

@end


NSString *const kHostOnlineNum = @"mtHostOnlineNum";
