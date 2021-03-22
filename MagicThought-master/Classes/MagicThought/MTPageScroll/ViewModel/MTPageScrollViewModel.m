//
//  MTPageScrollViewModel.m
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageScrollViewModel.h"
#import "MJRefresh.h"
#import "UIView+MTBaseViewContentModel.h"
#import "MTContentModelPropertyConst.h"
#import "UIView+Frame.h"

@interface MTPageScrollDynamicItem : NSObject<UIDynamicItem>

@property (nonatomic, assign) CGPoint center;

@property (nonatomic, readonly) CGRect bounds;

@property (nonatomic, assign) CGAffineTransform transform;

@end

@implementation MTPageScrollDynamicItem

-(CGRect)bounds
{
    return CGRectMake(0, 0, 1, 1);
}

@end

@interface MTPageScrollViewBaseViewModel ()

@property (nonatomic,weak) UIScrollView* scrollView;

@end

@implementation MTPageScrollViewBaseViewModel

-(void)whenGetResponseObject:(NSObject *)object
{
    if([object isKindOfClass:[UIScrollView class]])
        self.scrollView = (UIScrollView*)object;
}

@end


@interface MTPageScrollViewModel ()

@property (nonatomic,strong) UIDynamicAnimator* animator;

@property (nonatomic,strong) MTPageScrollDynamicItem* pageScrollDynamicItem;

@end

@implementation MTPageScrollViewModel

#pragma mark - scrollView 代理

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
        
    if([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
        return false;
    
    return YES ;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollViewDidScroll:) withObject:scrollView];
    #pragma clang diagnostic pop
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animator removeAllBehaviors];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollViewBeginDragging)];
    #pragma clang diagnostic pop
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate)
    {
        [self simulateDecelerate];
        return;
    }
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollViewEndDragging)];
    #pragma clang diagnostic pop      
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollViewEndDragging)];
    #pragma clang diagnostic pop
}

#pragma mark - 模拟向下减速
-(void)simulateDecelerate
{
    CGPoint vPoint = [self.scrollView.panGestureRecognizer velocityInView:self.scrollView];
    if(vPoint.y >= 0)
        return;
    
    UIScrollView* pageScrollListView = [self.model valueForKey:@"pageScrollListView"];
    if(pageScrollListView.directionYTag <= 0)
        return;
    if(pageScrollListView.mj_footer.state == MJRefreshStatePulling ||
          pageScrollListView.mj_footer.state == MJRefreshStateRefreshing ||
          pageScrollListView.mj_footer.state == MJRefreshStateWillRefresh)
           return;
    
    __block CGFloat pageScrollListViewMaxOffsetY = (pageScrollListView.contentInset.top + pageScrollListView.contentInset.bottom + pageScrollListView.contentSize.height) - pageScrollListView.height;
        
    self.pageScrollDynamicItem.center = CGPointZero;
    UIDynamicItemBehavior* behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.pageScrollDynamicItem]];
    [behavior addLinearVelocity:CGPointMake(0, -vPoint.y) forItem:self.pageScrollDynamicItem];
    behavior.resistance = 2.0;
        
    __block CGPoint preItemCenter = CGPointZero;
    __weak __typeof(self) weakSelf = self;
    
    behavior.action = ^{
        
        CGFloat offsetY = weakSelf.pageScrollDynamicItem.center.y - preItemCenter.y;
        
        if(pageScrollListView.offsetY > pageScrollListViewMaxOffsetY)
            [self simulateScrollViewSpring:pageScrollListView MaxOffsetY:pageScrollListViewMaxOffsetY];
        else
            pageScrollListView.offsetY += offsetY;
        
        preItemCenter = weakSelf.pageScrollDynamicItem.center;        
    };
    
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:behavior];
}

#pragma mark - 模拟回弹
-(void)simulateScrollViewSpring:(UIScrollView*)pageScrollListView MaxOffsetY:(CGFloat)maxOffsetY
{
    if(pageScrollListView.directionYTag <= 0)
        return;
    if(maxOffsetY < 0)
        maxOffsetY = 0;
    
    [self.animator removeAllBehaviors];
    self.pageScrollDynamicItem.center = pageScrollListView.contentOffset;
    
    UIAttachmentBehavior* behavior = [[UIAttachmentBehavior alloc] initWithItem:self.pageScrollDynamicItem attachedToAnchor:CGPointMake(0, maxOffsetY)];
    behavior.length = 0;
    behavior.damping = 1;
    behavior.frequency = 2;
    
        __weak __typeof(self) weakSelf = self;
    behavior.action = ^{
        
        pageScrollListView.contentOffset = weakSelf.pageScrollDynamicItem.center;
    };
    
    [self.animator addBehavior:behavior];
}

#pragma mark - Getter、Setter

-(UIDynamicAnimator *)animator
{
    if(!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.scrollView];
    }
    
    return _animator;
}

- (MTPageScrollDynamicItem *)pageScrollDynamicItem
{
    if(!_pageScrollDynamicItem)
    {
        _pageScrollDynamicItem = [MTPageScrollDynamicItem new];
        _pageScrollDynamicItem.center = CGPointZero;
        _pageScrollDynamicItem.transform = CGAffineTransformIdentity;
    }
    
    return _pageScrollDynamicItem;
}

-(NSArray *)newDataList:(NSArray *)dataList
{
    NSMutableArray* arr = [NSMutableArray arrayWithArray:dataList];
    NSObject* pageScrollData = [self.model valueForKey:@"pageScrollData"];
    BOOL isAllArray = arr.isAllArray;
    
    if(pageScrollData)
        [arr addObject:isAllArray ? @[pageScrollData] : pageScrollData];
    
    if([self.model.delegate respondsToSelector:@selector(pageScrollTailDataList)] && (self.model.delegate.pageScrollTailDataList.count > 0))
    {
        if(isAllArray)
           [arr addObject:self.model.delegate.pageScrollTailDataList];
        else            
            [arr addObjectsFromArray:self.model.delegate.pageScrollTailDataList];
    }
    
    return [arr copy];
}

-(void)setModel:(MTPageControllModel *)model
{
    [super setModel:model];
        
    [model setValue:self.scrollView forKey:@"pageScrollView"];
}

-(MTPageControllModel *)model
{
    MTPageControllModel* model = [super model];
    if(!model)
    {
        model = [MTPageControllModel new];
        [model setValue:self.scrollView forKey:@"pageScrollView"];
    }
    
    return model;
}

@end

@implementation MTPageScrollListViewModel

-(void)setupDefault
{
    [super setupDefault];
    
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollListViewDidScroll:) withObject:scrollView];
    #pragma clang diagnostic pop    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollListViewBeginDragging:) withObject:scrollView];
    #pragma clang diagnostic pop
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate)
        return;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollListViewEndDragging)];
    #pragma clang diagnostic pop
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.model performSelector:@selector(pageScrollListViewEndDragging)];
    #pragma clang diagnostic pop
}



@end
