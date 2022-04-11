
//
//  MTPopupController.m
//  QDDProject
//
//  Created by 王奕聪 on 2022/4/9.
//  Copyright © 2022 seenovation. All rights reserved.
//

#import "MTPopupController.h"
#import "Masonry.h"
#import "MTCloud.h"
#import "UIView+Circle.h"

@interface MTPopupController ()

@property (nonatomic,strong) UIView* blackView;

@property (nonatomic,strong) UIViewController* contentViewController;

@property (nonatomic,strong, readonly) UIView* contentView;


@end

@implementation MTPopupController

-(void)dealloc
{
    NSLog(@"MTPopupController销毁");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.contentView];
}


-(void)popup
{
    self.view.backgroundColor = hexa(0x000000, 0);
    self.contentView.centerX = half(self.view.width);
    self.contentView.y = self.view.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.backgroundColor = hexa(0x000000, 0.4);
        self.contentView.maxY = self.view.height;
    }];
}

-(void)dismissPopup
{
    self.view.backgroundColor = hexa(0x000000, 0.4);
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.y = self.view.height;
        self.view.backgroundColor = hexa(0x000000, 0);
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        
        NSInteger count = 0;
        for (UIViewController* subController in self.parentViewController.childViewControllers)
            if([subController isKindOfClass:MTPopupController.class])
                count ++;
        
        if(count < 2)
            [MTCloud shareCloud].currentViewController = self.parentViewController;
        
        [self removeFromParentViewController];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissPopup];
}

-(UIView *)contentView{return self.contentViewController.view;}

@end





@implementation UIViewController (MTPopupController)
 

-(void)popupController:(UIViewController*)controller LayoutPopup:(void (^)(UIView* popupView,  UIView* contentView))layoutPopup
{
    MTListController* listController = (id) controller;
    if([listController isKindOfClass:MTListController.class])
    {
        if(!listController.navigationBarHidden)
        {
            [listController.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.right.equalTo(listController.view);
                make.top.equalTo(listController.view).offset(-kStatusBarHeight_mt());
                make.height.equalTo(@(kNavigationBarHeight_mt()));
            }];
        }
        
        [listController.mtListView mas_makeConstraints:^(MASConstraintMaker *make) {
                     
            make.top.equalTo(listController.navigationBarHidden ? listController.view : listController.navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(listController.view);
        }];
    }
    
    MTPopupController* popupController = MTPopupController.new;
    popupController.contentViewController = controller;
    
    [popupController addChildViewController:controller];
    
    if([self.parentViewController isKindOfClass:MTPopupController.class])
        [self.parentViewController.parentViewController addChildViewController:popupController];
    else
        [self addChildViewController:popupController];
       
    [popupController.parentViewController.view addSubview:popupController.view];
    
    
    CGSize size = controller.popupSize;
    if(size.width && size.height)
        controller.view.bounds = CGRectMake(0, 0, size.width, size.height);    
 
    MTBorderStyle* popupBorder = controller.popupBorder;
    if(popupBorder)
        [controller.view becomeCircleWithBorder:popupBorder];
    
    if(layoutPopup)
        layoutPopup(popupController.view, controller.view);
        
    
    [popupController popup];
}

-(void)dismissPopup
{
    MTPopupController* popupController = (id) self.parentViewController;
    if([popupController isKindOfClass: MTPopupController.class])
       [popupController dismissPopup];
}

-(CGSize)popupSize{return CGSizeZero;}

-(MTBorderStyle *)popupBorder{return nil;}

@end
