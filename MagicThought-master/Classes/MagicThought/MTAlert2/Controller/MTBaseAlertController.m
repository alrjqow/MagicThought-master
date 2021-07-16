//
//  MTBaseAlertController.m
//  DaYiProject
//
//  Created by monda on 2018/9/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTBaseAlertController.h"

#import "MTConst.h"
#import "UIView+Frame.h"

NSString*  MTBaseAlertDismissOrder = @"MTBaseAlertDismissOrder_True";

@interface MTBaseAlertBlackView ()

@property (nonatomic,weak) MTBaseAlertController* alertController;

@end

@interface MTBaseAlertController ()

@property (nonatomic,assign) BOOL isDismiss;

@property (nonatomic,assign) CGFloat alertViewY;

@end

@implementation MTBaseAlertController

-(void)setupDefault
{
    [super setupDefault];
        
    self.view.backgroundColor = [UIColor clearColor];
    
    self.blackView.frame = self.view.bounds;
    self.blackView.backgroundColor = rgba(0, 0, 0, 0.3);
    self.blackView.alpha = self.type == MTBaseAlertTypeDefault || self.type == MTBaseAlertTypeDefault_NotBackgroundDismiss;
    
    self.animateTime = 0.25;
}

-(void)setupSubview
{
    [super setupSubview];
    
    [self setupAlertView];
    [self.view insertSubview:self.blackView atIndex:0];
    
    if(self.alertView)
    {
        switch (self.type) {
            case MTBaseAlertTypeUp:
            case MTBaseAlertTypeUp_NotBackgroundDismiss:
            case MTBaseAlertTypeUp_DismissTwice:
            case MTBaseAlertTypeUp_Frame:
            case MTBaseAlertTypeUp_Frame_NotBackgroundDismiss:
            {
                self.alertViewY = self.alertView.y;
                self.alertView.y = self.view.height;
                break;
            }

            default:
                break;
        }
                            
        [self.view addSubview:self.alertView];
    }
}

-(void)setupAlertView{}

#pragma mark - 弹出

-(void)alert
{
    self.isDismiss = self.type != MTBaseAlertTypeUp_DismissTwice;
        
    UIViewController* vc = self.rootAlertController;
    while (vc.presentedViewController) {vc = vc.presentedViewController;}
    
    switch (self.type) {
                
        case MTBaseAlertTypeUp_NotBackgroundDismiss:
        case MTBaseAlertTypeUp_DismissTwice:
        case MTBaseAlertTypeUp:
        case MTBaseAlertTypeUp_Frame:
        case MTBaseAlertTypeUp_Frame_NotBackgroundDismiss:
        {
//            NSLog(@"%@",self.alertView);
                [vc presentViewController:self animated:false completion:^{
                    [UIView animateWithDuration:self.animateTime animations:^{
                        
                        [self alerting];
                        self.blackView.alpha = 1;

                        self.alertView.y = self.type >= MTBaseAlertTypeUp_Frame ? self.alertViewY : (self.view.height - self.alertView.height);
                    } completion:^(BOOL finished) {
                        [self alertCompletion];
                    }];
                }];            
            break;
        }
            
        default:
        {
            [vc  presentViewController:self animated:YES completion:^{
                [self alertCompletion];
            }];
            break;
        }
    }
}

-(void)willAlert{}
-(void)alerting{}
-(void)alertCompletion{}

-(UIViewController *)rootAlertController
{
    return mt_rootViewController();
}

-(BOOL)navigationBarHidden{return YES;}

#pragma mark - 点击

#pragma mark - 消失

-(void)dismissWithAnimate
{
     [self dismiss:nil Completion:nil Animate:YES];
}

-(void)dismiss
{
    [self dismiss:nil Completion:nil Animate:false];
}

-(void)dismissBeforeWithAnimate:(MTBlock)before
{
    [self dismiss:before Completion:nil Animate:YES];
}

-(void)dismissBefore:(MTBlock)before
{
    [self dismiss:before Completion:nil Animate:false];
}

-(void)dismissCompletionWithAnimate:(MTBlock)completion
{
    [self dismiss:nil Completion:completion Animate:YES];
}

-(void)dismissCompletion:(MTBlock)completion
{
    [self dismiss:nil Completion:completion Animate:false];
}

-(void)dismiss:(MTBlock)before Completion:(MTBlock)completion
{
    [self dismiss:before Completion:completion Animate:false];
}

-(void)dismissWithAnimate:(MTBlock)before Completion:(MTBlock)completion
{
    [self dismiss:before Completion:completion Animate:YES];
}

-(void)dismiss:(MTBlock)before Completion:(MTBlock)completion Animate:(BOOL)animate
{
    [self dismissIndicator];
    switch (self.type) {
                            
        case MTBaseAlertTypeUp_NotBackgroundDismiss:
        case MTBaseAlertTypeUp_DismissTwice:
        case MTBaseAlertTypeUp:
        case MTBaseAlertTypeUp_Frame:
        case MTBaseAlertTypeUp_Frame_NotBackgroundDismiss:
        {
            [self alertTypeUpDismiss:before Completion:completion];
            break;
        }
            
        default:
        {
            if(before)
                before();
            [self dismissViewControllerAnimated:animate completion:^{
                [self dismissCompletion];
                if(completion)
                    completion();
            }];
            break;
        }
    }
}

-(void)dismissCompletion{}

-(void)alertTypeUpDismiss:(MTBlock)before Completion:(MTBlock)completion
{
    [UIView animateWithDuration:self.animateTime animations:^{
        self.blackView.alpha = 0;
        self.alertView.y = self.view.height;
    } completion:^(BOOL finished) {
         
        if(self.isDismiss)
        {
            if(before)
                before();
            [self dismissViewControllerAnimated:false completion:^{
                [self dismissCompletion];
                if(completion)
                    completion();
            }];
        }
        else
            [self dismissCompletion];
        self.isDismiss = YES;
    }];
}

#pragma mark - 懒加载

-(UIScrollView *)mtListView{return nil;}

-(void)setMt_order:(NSString *)mt_order
{
    if([mt_order containsString:@"MTBaseAlertDismissOrder"])
    {
        if([mt_order containsString:@"_True"])
            self.isDismiss = YES;
        if([mt_order containsString:@"_Close"])
            [super setMt_order:mt_order];
        [self dismissWithAnimate];
    }
    else
        [super setMt_order:mt_order];
}


#pragma mark - 生命周期

-(instancetype)init
{
    if(self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        _blackView = [MTBaseAlertBlackView new];
        _blackView.alertController = self;        
    }
    
    return self;
}


@end

@implementation MTBaseAlertBlackView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if(self.alertController.presentedViewController)
        return;
    if(!self.alertController.isVisible)
        return;
    
    switch (self.alertController.type) {
        case MTBaseAlertTypeUp:
        case MTBaseAlertTypeUp_DismissTwice:
        case MTBaseAlertTypeUp_Frame:
        {
            self.alertController.isDismiss = YES;
            [self.alertController dismissWithAnimate];
            break;
        }
        case MTBaseAlertTypeDefault_NotBackgroundDismiss:
        case MTBaseAlertTypeUp_NotBackgroundDismiss:
        case MTBaseAlertTypeUp_Frame_NotBackgroundDismiss:
            break;
            
        default:
        {
            [self.alertController dismissWithAnimate];
            break;
        }
    }
}

@end
