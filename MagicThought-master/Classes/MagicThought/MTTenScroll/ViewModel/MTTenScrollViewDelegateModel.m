//
//  MTTenScrollViewDelegateModel.m
//  MagicThought
//
//  Created by monda on 2019/11/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTTenScrollViewDelegateModel.h"
#import "MTTenScrollModel.h"
#import "MTDynamicItem.h"

#import "UIView+Frame.h"

#import <MJRefresh/MJRefresh.h>

@interface MTTenScrollViewBaseDelegateModel ()

@property (nonatomic,weak) UIScrollView* scrollView;

@end


@interface MTTenScrollViewDelegateModel ()

@property (nonatomic,strong) UIDynamicAnimator* animator;

@property (nonatomic,strong) MTDynamicItem* item;

@end

@implementation MTTenScrollViewDelegateModel

-(void)setupDefault
{
    [super setupDefault];
    
    if (@available(iOS 11.0, *))
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.scrollView];
}

#pragma mark - 代理

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animator removeAllBehaviors];
    
    [self.model performSelector:@selector(tenScrollViewWillBeginDragging)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(tenScrollViewDidScroll)];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    UIScrollView* currentView = [self.model valueForKey:@"currentView"];
    if([currentView.viewModel isKindOfClass:self.class])
    {
        if(!decelerate)
        {
            [self.model performSelector:@selector(tenScrollViewEndScroll)];
        }
    }
    else
        [self simulateDecelerate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIScrollView* currentView = [self.model valueForKey:@"currentView"];
    if(![currentView.viewModel isKindOfClass:self.class])
    {
        if(currentView.dragging || currentView.decelerating)
            return;
    }        
    
    [self.model performSelector:@selector(tenScrollViewEndScroll)];
}

#pragma mark - 模拟向下减速
-(void)simulateDecelerate
{
    UIScrollView* currentView = [self.model valueForKey:@"currentView"];
    if(currentView.directionYTag <= 0)
    {
        [self.model performSelector:@selector(tenScrollViewEndScroll)];
        return;
    }
    if(currentView.mj_footer.state == MJRefreshStatePulling ||
       currentView.mj_footer.state == MJRefreshStateRefreshing ||
       currentView.mj_footer.state == MJRefreshStateWillRefresh)
    {
        [self.model performSelector:@selector(tenScrollViewEndScroll)];
        return;
    }

    
    [self.animator removeAllBehaviors];
    self.item.center = CGPointZero;
    
    CGPoint vPoint = [self.scrollView.panGestureRecognizer velocityInView:self.scrollView];
    if(vPoint.y > 0)
    {
        [self.model performSelector:@selector(tenScrollViewEndScroll)];
        return;
    }
        
    
    UIDynamicItemBehavior* behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.item]];
    [behavior addLinearVelocity:CGPointMake(0, -vPoint.y) forItem:self.item];
    behavior.resistance = 2.0;
        
    __block CGPoint lastCenter = CGPointZero;
    __weak __typeof(self) weakSelf = self;
    
    behavior.action = ^{
        
        CGFloat currentY = weakSelf.item.center.y - lastCenter.y;
        CGFloat maxCurrentViewOffsetY = (currentView.contentInset.top + currentView.contentInset.bottom + currentView.contentSize.height) - currentView.height;
        CGFloat currentViewOffsetY = currentView.offsetY;
        if(currentView.offsetY > maxCurrentViewOffsetY)
            [self simulateCurrentViewSpring:currentView];
        else
        {
            currentViewOffsetY += currentY;
            currentView.offsetY = currentViewOffsetY;
        }
        
        lastCenter = weakSelf.item.center;
        [self.model performSelector:@selector(tenScrollViewEndScroll)];
    };
    [self.animator addBehavior:behavior];
}

#pragma mark - 模拟回弹
-(void)simulateCurrentViewSpring:(UIScrollView*)currentView
{
    if(currentView.directionYTag <= 0)
        return;
    CGFloat maxCurrentViewOffsetY = (currentView.contentInset.top + currentView.contentInset.bottom + currentView.contentSize.height) - currentView.height;
    if(maxCurrentViewOffsetY < 0)
        maxCurrentViewOffsetY = 0;
    
    [self.animator removeAllBehaviors];
    self.item.center = currentView.contentOffset;
    
    UIAttachmentBehavior* behavior = [[UIAttachmentBehavior alloc] initWithItem:self.item attachedToAnchor:CGPointMake(0, maxCurrentViewOffsetY)];
    behavior.length = 0;
    behavior.damping = 1;
    behavior.frequency = 2;
    
        __weak __typeof(self) weakSelf = self;
    behavior.action = ^{
        
        currentView.contentOffset = weakSelf.item.center;
    };
    
    [self.animator addBehavior:behavior];
}

-(NSArray *)newDataList:(NSArray *)dataList
{
    NSMutableArray* arr = [NSMutableArray arrayWithArray:dataList];
    [arr addObject:[self.model valueForKey:@"tenScrollData"]];
    
    return [arr copy];
}

/*
 * 是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
        
    if([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
        return false;
    
    return YES ;
}

#pragma mark - 懒加载

-(MTDynamicItem *)item
{
    if(!_item)
    {
        _item = [MTDynamicItem new];
        _item.center = CGPointZero;
        _item.transform = CGAffineTransformIdentity;
    }
    
    return _item;
}

-(void)setModel:(MTTenScrollModel *)model
{
    [super setModel:model];
        
    [model setValue:self.scrollView forKey:@"tenScrollView"];
}

-(MTTenScrollModel *)model
{
    MTTenScrollModel* model = [super model];
    if(!model)
    {
        model = [MTTenScrollModel new];
        [model setValue:self.scrollView forKey:@"tenScrollView"];
    }
    
    return model;
}

@end


@implementation MTDelegateTenScrollViewDelegateModel

-(void)setupDefault
{
    [super setupDefault];
    
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.model setValue:scrollView forKey:@"currentView"];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(tenScrollTableViewScrollDidScroll)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(tenScrollTableViewEndScroll)];
}


@end


@implementation MTTenScrollViewBaseDelegateModel

-(void)whenGetResponseObject:(NSObject *)object
{
    if([object isKindOfClass:[UIScrollView class]])
        self.scrollView = (UIScrollView*)object;
}

@end
