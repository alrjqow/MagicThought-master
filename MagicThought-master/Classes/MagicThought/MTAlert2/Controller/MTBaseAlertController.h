//
//  MTBaseAlertController.h
//  DaYiProject
//
//  Created by monda on 2018/9/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTListController.h"
#import "UIView+MTBaseViewContentModel.h"

typedef NS_ENUM(NSInteger, MTBaseAlertType)
{
    MTBaseAlertTypeDefault,
    MTBaseAlertTypeDefault_NotBackgroundDismiss,
    MTBaseAlertTypeUp,
    MTBaseAlertTypeUp_NotBackgroundDismiss,
    MTBaseAlertTypeUp_DismissTwice,
    MTBaseAlertTypeUp_Frame
};

CG_EXTERN NSString*  MTBaseAlertDismissOrder;

@interface MTBaseAlertBlackView : UIView @end

@interface MTBaseAlertController : MTListController<UITableViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) MTBaseAlertType type;

@property (nonatomic,strong) UIView* alertView;

@property (nonatomic,strong, readonly) MTBaseAlertBlackView* blackView;

@property (nonatomic,strong, readonly) UIViewController* rootAlertController;

@property (nonatomic,assign) CGFloat animateTime;

-(void)setupAlertView;

/**用来弹出*/
-(void)alert;
-(void)willAlert;
-(void)alerting;
-(void)alertCompletion;

/**用来消失*/
-(void)dismissCompletion;

-(void)dismiss;
-(void)dismissWithAnimate;

-(void)dismissBefore:(MTBlock)before;
-(void)dismissBeforeWithAnimate:(MTBlock)before;

-(void)dismissCompletion:(MTBlock)completion;
-(void)dismissCompletionWithAnimate:(MTBlock)completion;

-(void)dismiss:(MTBlock)before Completion:(MTBlock)completion;
-(void)dismissWithAnimate:(MTBlock)before Completion:(MTBlock)completion;

@end


