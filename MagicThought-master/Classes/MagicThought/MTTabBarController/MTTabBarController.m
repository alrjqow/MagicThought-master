//
//  MTTabBarController.m
//  MagicThought
//
//  Created by monda on 2019/11/29.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTTabBarController.h"
#import "MTTabBarItem.h"
#import "MTDelegateProtocol.h"
#import "NSObject+ReuseIdentifier.h"
#import "NSString+Exist.h"
#import "MJExtension.h"

@interface MTTabBarController ()

@end

@implementation MTTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefault];
}

-(void)setupDefault
{
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    
    [self setupChildController];
}

-(void)setupChildController
{
    NSArray<NSObject*>* tabBarItemArr = self.tabBarItemArr;
    NSArray<MTTabBarItem*>* arr = [MTTabBarItem mj_objectArrayWithKeyValuesArray:tabBarItemArr];

    [self setupTabBarItemWithArray:arr];
        
    for (NSInteger i = 0; i < arr.count; i++) {
        arr[i].mt_reuseIdentifier = tabBarItemArr[i].mt_reuseIdentifier;
    }
    
    for (MTTabBarItem* item in arr) {
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if(![item.mt_reuseIdentifier isExist])
            continue;
        
        Class c = NSClassFromString(item.mt_reuseIdentifier);
        if(![c isSubclassOfClass:[UIViewController class]])
            continue;
        
        UIViewController* vc;
        if([c isSubclassOfClass:[UINavigationController class]] && [item.rootController isExist])
        {
            Class c1 = NSClassFromString(item.rootController);
            if([c1 isSubclassOfClass:[UIViewController class]])
            {
                UIViewController* rootVc = c1.new;
                rootVc.title = item.title;
                UINavigationController* nvc = [[c alloc] initWithRootViewController:rootVc];
                nvc.tabBarItem = item;
                vc = nvc;
            }
        }
        else
        {
            vc = c.new;
            vc.title = item.title;
        }
        
        if([item.order isExist] && [vc respondsToSelector:@selector(getSomeThingForMe:withOrder:withItem:)])
            [vc getSomeThingForMe:self withOrder:item.order withItem:item.data];
        
        [self addChildViewController:vc];
    }
}

-(void)setupTabBarItemWithArray:(NSArray<UITabBarItem*>*)tabBarItemArray{}

#pragma mark - 懒加载

-(void)setTabBar_mt:(UITabBar *)tabBar_mt
{
    _tabBar_mt = tabBar_mt;
    [self setValue:tabBar_mt forKey:@"tabBar"];
    
    [self.view layoutIfNeeded];
}

@end
