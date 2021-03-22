//
//  AnimateController.m
//  DaYiProject
//
//  Created by monda on 2019/1/14.
//  Copyright © 2019 monda. All rights reserved.
//

#import "AnimateController.h"
#import "UIViewControllerTransitionModel.h"
#import "MTCardStyle1Transitioning.h"
#import "UIButton+Word.h"
#import "MTWordStyle.h"

@interface AnimateController ()

@property (nonatomic,strong) UIViewControllerTransitionModel* model;

@end

@implementation AnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    UIButton* btn = [UIButton new];
    [btn setWordWithStyle:mt_WordStyleMake(13, @"push", [UIColor blackColor])];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    
    [self.view addSubview:btn];
}

-(void)click
{
//    if([self.navigationController isKindOfClass:[MTNavigationController class]])
//        ((MTNavigationController*)self.navigationController).isFullScreenPop = !((MTNavigationController*)self.navigationController).isFullScreenPop;
    [self.navigationController pushViewController:[AnimateController new] animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@",self.view.gestureRecognizers);
}

-(UIViewControllerTransitionModel *)model
{
    if(!_model)
    {
        UIViewControllerTransitionModel* model = [UIViewControllerTransitionModel new];
        model.pushTransition = [MTCardStyle1TransitioningPush new];
        model.popTransition = [MTCardStyle1TransitioningPop new];
        
        _model = model;
    }

    return _model;
}

-(UIViewControllerTransitionModel *)mt_transitionModel
{
    return self.model;
}

@end



@interface AnimateNavigationController ()

@property (nonatomic,strong) AnimateNavigationDelegate* animateNavigationDelegate;

@end
@implementation AnimateNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animateNavigationDelegate = [AnimateNavigationDelegate new];
    self.animateNavigationDelegate.navigation = self;
    self.delegate = self.animateNavigationDelegate;
    
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self.animateNavigationDelegate action:NSSelectorFromString(@"edgePanAction:")];
//    edgePan.edges = UIRectEdgeLeft;
//    [viewController.view addGestureRecognizer:edgePan];

    
    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc]initWithTarget:self.animateNavigationDelegate   action:NSSelectorFromString(@"edgePanAction:")];
        [viewController.view addGestureRecognizer:edgePan];
    

    
    [super pushViewController:viewController animated:animated];
}

@end



@implementation AnimateNavigationDelegate


static BOOL isLeft = false;
- (void)edgePanAction:(UIScreenEdgePanGestureRecognizer *)gesture{
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    
    _isInteraction = gesture.state == UIGestureRecognizerStateBegan;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self.navigation popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
//            NSLog(@"%lf",rate);
            isLeft = (0.5 + rate) < 0.5;
            [self updateInteractiveTransition: 0.5 + rate * 0.5];
            break;
        }
        case UIGestureRecognizerStateEnded:
            
            if ((isLeft && rate <= -0.2f) || (!isLeft && rate >= 0.2f))
                [self finishInteractiveTransition];
            else
                if ((isLeft && velocity < -1000) || (!isLeft && velocity > 1000))
                    [self finishInteractiveTransition];
                else
                    [self cancelInteractiveTransition];
            break;
            
        default:
            [self cancelInteractiveTransition];
            break;
    }
}

-(void)cancelInteractiveTransition
{
    [self updateInteractiveTransition: 0.5];
    
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    fromView.hidden = false;

    for(UIView* subview in self.transitionContext.containerView.subviews)
    {
        if([subview isKindOfClass:NSClassFromString(@"_UIReplicantView")])
        {
            [self.transitionContext.containerView bringSubviewToFront:fromView];
            subview.hidden = YES;
            break;
        }
    }
    
    [super cancelInteractiveTransition];
}

-(void)finishInteractiveTransition
{
    if(isLeft)
    {
        [self updateInteractiveTransition: 0];
        
        for(UIView* subview in self.transitionContext.containerView.subviews)
        {
            if([subview isKindOfClass:NSClassFromString(@"_UIReplicantView")])
            {
                subview.hidden = YES;
                break;
            }
        }
    }
    
    [super finishInteractiveTransition];
}

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    [super startInteractiveTransition:transitionContext];    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
//    navigationController.delegate = nil;
    _isPop = operation == UINavigationControllerOperationPop;
    if(operation == UINavigationControllerOperationPush)
        return [AnimateNavigationTransitioningPush new];
    else if(operation == UINavigationControllerOperationPop)
    {
        AnimateNavigationTransitioningPop* pop = [AnimateNavigationTransitioningPop new];
        pop.isInteraction = self.isInteraction;
        return pop;
    }
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return  _isInteraction && _isPop ? self : nil;
}

@end


@implementation AnimateNavigationTransitioningPush

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 1.5);
    [transitionContext.containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [UIView animateWithDuration:0.3 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end


@implementation AnimateNavigationTransitioningPop

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView addSubview:snapShot];
    snapShot.frame = transitionContext.containerView.bounds;
    snapShot.layer.anchorPoint = CGPointMake(0.5, 1.5);
    snapShot.layer.position = CGPointMake(snapShot.bounds.size.width * 0.5, snapShot.bounds.size.height * 1.5);
    
    snapShot.transform = self.isInteraction ? CGAffineTransformMakeRotation(-M_PI_2) : CGAffineTransformIdentity;
    
    fromView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{

//        NSLog(@"doing");

        snapShot.transform = CGAffineTransformMakeRotation(self.isInteraction ? M_PI_2 : M_PI_4);
    } completion:^(BOOL finished) {
        
//        NSLog(@"completion");
        fromView.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end



