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
#import "UIColor+Image.h"
#import "MJExtension.h"
#import "MTProjectArchitectureManager.h"

@interface MTTabBarController ()

@end

@implementation MTTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefault];
    [self startRequest];
}

-(void)setupDefault
{
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    
    [self setupTabBar];
    
    self.tabBar.translucent = self.tabBarTranslucent;
    
    if(self.selectedColor)
        self.tabBar.tintColor = self.selectedColor;

    if(self.normalColor)
    {
        if (@available(iOS 10.0, *)) {
            self.tabBar.unselectedItemTintColor = self.normalColor;
        } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:self.normalColor} forState:UIControlStateNormal];
        }
    }

    if(self.tabBarFont)
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:self.tabBarFont} forState:UIControlStateNormal];

    UIImage* image = self.tabBarColor ? [self.tabBarColor changeToImageWithSize:self.tabBar.bounds.size] : nil;
    if(image)
    {
        if (@available(iOS 15.0, *)) {
            UITabBarAppearance * appearance = [UITabBarAppearance new];
            appearance.backgroundImage = image;
            self.tabBar.standardAppearance = appearance;
        }
        else
            [self.tabBar setBackgroundImage:image];
    }
        
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance * appearance = [UITabBarAppearance new];
        appearance.backgroundImage = image ? image : [UIImage new];
        self.tabBar.scrollEdgeAppearance = appearance;
    }
            
    [self setupChildController];
        
    if(kArchitectureManager_mt.isOnline)
        return;
        
    [self.hostServiceModel addHostSwitchButton:self.hostNameList];
}

-(NSArray<NSString *> *)hostNameList{return kArchitectureManager_mt.hostNameList;}

-(void)setupTabBar
{
    if(!self.tabBarName)
        return;
    
    Class c = NSClassFromString(self.tabBarName);
    if(![c isSubclassOfClass:[UITabBar class]])
        return;
    
    UITabBar* tabBar = c.new;
    [self setValue:tabBar forKey:@"tabBar"];
//    [self.view layoutIfNeeded];
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
//                rootVc.title = item.title;
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

-(NSArray<NSDictionary *> *)tabBarItemArr{return kArchitectureManager_mt.baseTabBarItemArr;}

-(UIColor *)normalColor{return kArchitectureManager_mt.baseNormalColor;}

-(UIColor *)selectedColor{return kArchitectureManager_mt.baseSelectedColor;}

-(UIFont *)tabBarFont{return kArchitectureManager_mt.baseTabBarFont;}

-(UIColor *)tabBarColor{return kArchitectureManager_mt.baseTabBarColor;}

-(BOOL)tabBarTranslucent{return kArchitectureManager_mt.baseTabBarTranslucent;}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [viewControllerToPresent setValue:self forKey:@"previousController"];
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(MTHostServiceModel *)hostServiceModel
{
    if(!_hostServiceModel)
    {
        _hostServiceModel = MTHostServiceModel.new(self);
    }
    
    return _hostServiceModel;
}

@end
