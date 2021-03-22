//
//  MTTabBarItem.h
//  MagicThought
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTabBarItem : UITabBarItem

@property (nonatomic,strong) NSString* order;

@property (nonatomic,strong) id data;

@property (nonatomic,strong) NSString* rootController;

@end

