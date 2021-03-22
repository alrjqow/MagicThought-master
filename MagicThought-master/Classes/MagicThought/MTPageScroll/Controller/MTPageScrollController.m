//
//  MTPageScrollController.m
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageScrollController.h"
#import "UIView+Frame.h"

@interface MTPageScrollController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat prePercentage;

@property (nonatomic,assign) NSInteger nextIndex;
@property (nonatomic,assign) NSInteger finishIndex;

@property (nonatomic,weak) UIScrollView* scrollView;

@property (nonatomic,assign) BOOL isLeft;

@property (nonatomic,assign) BOOL isBounces;

@end

@implementation MTPageScrollController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    
    
    for (UIView* subView in self.view.subviews) {
        if([subView isKindOfClass:[UIScrollView class]])
        {
            self.scrollView = (UIScrollView*)subView;
            self.scrollView.delegate = self;
            if(self.navigationController)
                [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];            
            break;
        }
    }
            
//    if(self.currentIndex < self.pageControllerArray.count)
//        [self setViewControllers:@[self.pageControllerArray[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - 数据源

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.pageControllerArray indexOfObject:viewController];
    index --;
    if(index > self.pageControllerArray.count - 1 || index < 0)
    {
        return nil;
    }
                
    return self.pageControllerArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.pageControllerArray indexOfObject:viewController];
    index ++;
    if(index > self.pageControllerArray.count - 1 || index < 0)
    {
        return nil;
    }
            
    return self.pageControllerArray[index];
}

#pragma mark - 代理

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
                    
    self.nextIndex = [self.pageControllerArray indexOfObject:[pendingViewControllers firstObject]];
    self.currentIndex = self.nextIndex + (self.isLeft ? 1 : -1);
    
//    NSLog(@"willTransitionToViewControllers ==== %d ==== %zd === %zd", self.isLeft, self.currentIndex, self.nextIndex);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
            
    
//    NSLog(@"didFinishAnimating === %d === %d === %zd",finished, completed, [self.pageControllerArray indexOfObject:[previousViewControllers firstObject]]);
//    NSLog(@"didFinishAnimating === %d === %d === %zd",finished, completed, [self.pageControllerArray indexOfObject:[previousViewControllers firstObject]] + (self.isLeft ? -1 : 1));
    
    if(completed)
    {
        self.finishIndex = [self.pageControllerArray indexOfObject:[previousViewControllers firstObject]] + (self.isLeft ? -1 : 1);
        if(self.finishIndex == self.nextIndex && self.currentIndex != self.nextIndex)
        {
            CGFloat prePercentage = fabs(self.prePercentage);
            if(prePercentage < 0.85)
                return;
            self.currentIndex = self.nextIndex;
        }
    }
    else
    {
        self.currentIndex = [self.pageControllerArray indexOfObject:[previousViewControllers firstObject]];
    }
        
//    NSLog(@"didFinishAnimating ==== %d ==== %zd", self.isLeft, self.currentIndex);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"aaaa === %lf",scrollView.offsetX);
        
    CGFloat percentage = (scrollView.offsetX - self.view.width) / self.view.width;
    if(percentage < 0)
        self.isLeft = YES;
    if(percentage > 0)
        self.isLeft = false;
            
    if(self.currentIndex == 0)
    {
//        if(scrollView.offsetX < scrollView.width && self.isLeft)
//        {
//            self.isBounces = YES;
//            scrollView.offsetX = scrollView.width;
//            return;
//        }
//
//        if(scrollView.offsetX > scrollView.width && self.isBounces)
//        {
//            scrollView.offsetX = scrollView.width;
//            return;
//        }
    }
    if(self.currentIndex == (self.pageControllerArray.count - 1))
    {
//        if(scrollView.offsetX > scrollView.width && !self.isLeft)
//        {
//            self.isBounces = YES;
//            scrollView.offsetX = scrollView.width;
//            return;
//        }
//
//        if(scrollView.offsetX < scrollView.width && self.isBounces)
//           {
//               scrollView.offsetX = scrollView.width;
//               return;
//           }
    }
    
    if(percentage > -1 && percentage < 1 && percentage != 0)
    {
        self.prePercentage = percentage;
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
            [self.pageControllModel performSelector:@selector(pageScrollHorizontalViewDidScrollWithCurrentIndex:Percentage:) withObject:@(self.currentIndex) withObject:@(percentage)];
        #pragma clang diagnostic pop
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isBounces = false;
        
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.pageControllModel performSelector:@selector(pageScrollHorizontalViewBeginDragging)];
    #pragma clang diagnostic pop
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"scrollViewDidEndDragging");
    if(decelerate)
        return;
    
    self.isBounces = false;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.pageControllModel performSelector:@selector(pageScrollHorizontalViewEndDragging)];
    #pragma clang diagnostic pop
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isBounces = false;
    if(self.finishIndex == self.nextIndex && self.currentIndex != self.nextIndex)
        self.currentIndex = self.nextIndex;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.pageControllModel performSelector:@selector(pageScrollHorizontalViewEndDragging)];
    #pragma clang diagnostic pop    
//    NSLog(@"scrollViewDidEndDecelerating");
}

#pragma mark - getter、setter

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.pageControllModel setValue:@(currentIndex) forKey:@"currentIndex"];
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    scrollView.scrollsToTop = false;
    [self.pageControllModel setValue:scrollView forKey:@"pageScrollHorizontalView"];
}

-(void)setPageControllerArray:(NSArray<UIViewController *> *)pageControllerArray
{
    _pageControllerArray = pageControllerArray;
    
    if(self.currentIndex < pageControllerArray.count)
        [self setViewControllers:@[pageControllerArray[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
}

#pragma mark - init

-(instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<UIPageViewControllerOptionsKey,id> *)options
{
    if(self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:navigationOrientation options:options]);
        
    return self;
}

@end
