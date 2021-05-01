//
//  MTTabBarController.h
//  MagicThought
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import "NSObject+CommonProtocol.h"


@interface MTTabBarController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic,strong) NSString* tabBarName;

@property (nonatomic,strong) UIColor* normalColor;

@property (nonatomic,strong) UIColor* selectedColor;

@property (nonatomic,strong) UIFont* tabBarFont;

@property (nonatomic,strong,readonly) NSArray<NSDictionary*>* tabBarItemArr;

-(void)setupTabBarItemWithArray:(NSArray<UITabBarItem*>*)tabBarItemArray;

@end

