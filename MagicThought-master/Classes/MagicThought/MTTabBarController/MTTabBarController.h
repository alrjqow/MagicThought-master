//
//  MTTabBarController.h
//  MagicThought
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import "NSObject+CommonProtocol.h"


@interface MTTabBarController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic,strong) UITabBar* tabBar_mt;

@property (nonatomic,strong,readonly) NSArray<NSDictionary*>* tabBarItemArr;

-(void)setupTabBarItemWithArray:(NSArray<UITabBarItem*>*)tabBarItemArray;

@end

