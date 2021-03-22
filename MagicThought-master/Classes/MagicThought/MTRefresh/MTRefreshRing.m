//
//  MTRefreshRing.m
//  DaYiProject
//
//  Created by monda on 2018/10/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTRefreshRing.h"
#import "UIView+Frame.h"

@interface MTRefreshRing ()

@property (nonatomic,weak) UIScrollView* scrollView;

/**设置触发刷新的最大偏移量*/
@property (nonatomic,assign) CGFloat maxOffsetY;

/**是否正在刷新*/
@property (nonatomic,assign) BOOL isRefreshing;

/**是否在准备执行结束动画时受到拖拽*/
@property (nonatomic,assign) BOOL isEndRefreshDragging;

@property (nonatomic,strong) CABasicAnimation* animation;

@property (nonatomic,copy) void (^refreshingBlock)(void);
@property (nonatomic,copy) void (^endRefreshingBlock)(void);

@end


@implementation MTRefreshRing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            CGFloat offsetY = strongSelf.scrollView.contentOffset.y + strongSelf.scrollView.contentInset.top;
            if(!strongSelf.scrollView.isDragging && strongSelf.isEndRefreshDragging && offsetY == 0)
            {
                [strongSelf endRefresh2];
            }
            
            if(strongSelf.isRefreshing || strongSelf.isEndRefreshDragging)
                return;
            
            CGPoint oldPoint;
            [(NSValue*)[change objectForKey:NSKeyValueChangeOldKey] getValue:&oldPoint];
            
            CGPoint newPoint;
            [(NSValue*)[change objectForKey:NSKeyValueChangeNewKey ] getValue:&newPoint];
            
            [strongSelf setContentOffset:CGPointMake(0, offsetY <= strongSelf.maxOffsetY ? strongSelf.maxOffsetY : offsetY)];
            
            if (oldPoint.y < newPoint.y) {
                strongSelf.imgView.transform = CGAffineTransformRotate(strongSelf.imgView.transform,
                                                                       -0.2);
            } else if (oldPoint.y > newPoint.y) {
                strongSelf.imgView.transform = CGAffineTransformRotate(strongSelf.imgView.transform,
                                                                       0.2);
            }
                        
            if(!strongSelf.scrollView.isDragging && offsetY <= strongSelf.maxOffsetY && strongSelf.maxOffsetY != 0)
                [strongSelf startRefresh];
        });
    });
}

- (void)startRefresh
{
    [self setContentOffset:CGPointMake(0, self.maxOffsetY)];
    self.isRefreshing = YES;
    [self.imgView.layer addAnimation:self.animation forKey:@"refreshing"];
    
    if(self.refreshingBlock)
        self.refreshingBlock();
}

- (void)endRefresh
{
    __weak typeof(self) weakSelf = self;
    if(weakSelf.scrollView.isDragging)
    {
        weakSelf.isEndRefreshDragging = YES;
        return;
    }
    [weakSelf endRefresh2];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        if(weakSelf.scrollView.isDragging)
//        {
//            weakSelf.isEndRefreshDragging = YES;
//            return;
//        }
//        [weakSelf endRefresh2];
//    });
}

-(void)endRefresh2
{
    if(self.endRefreshingBlock)
        self.endRefreshingBlock();
    [UIView animateWithDuration:0.2 animations:^{
        [self setContentOffset:CGPointZero];
        
    } completion:^(BOOL finished) {
        //结束动画
        [self.imgView.layer removeAnimationForKey:@"refreshing"];
        
        //当回到原始位置后，转角也回到原始位置
        self.imgView.transform = self.transform;
        self.isRefreshing = false;
        self.isEndRefreshDragging = false;
    }];
}

#pragma mark - 懒加载

-(CABasicAnimation *)animation
{
    if(!_animation)
    {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        //逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: -M_PI *2];
        animation.duration  = 0.8;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //一直自旋转
        
        _animation = animation;
    }
    
    return _animation;
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    if(_scrollView)
    {
        @try {
            [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        } @catch (NSException *e) {}
    }
    
    _scrollView = scrollView;
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

-(void)setSize:(CGSize)size
{
    _size = size;
    
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    self.imgView.frame = self.bounds;
    self.contentSize = size;
}

-(void)setStopY:(CGFloat)stopY
{
    _stopY = stopY;
    self.maxOffsetY = -(stopY - self.y - self.halfHeight);
}

#pragma mark - 生命周期

+(instancetype)addTarget:(UIScrollView*)scrollView RefreshingBlock:(void(^)(void))refreshingBlock EndRefresh:(void(^)(void))endRefreshingBlock
{
    MTRefreshRing* view = [MTRefreshRing new];
    view.scrollView = scrollView;
    view.refreshingBlock = refreshingBlock;
    view.endRefreshingBlock = endRefreshingBlock;
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.clipsToBounds = false;
        
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_refresh"]];
        [self addSubview:self.imgView];
        
        self.size = CGSizeMake(20, 20);
    }
    
    return self;
}

-(void)dealloc
{
    [self clear];
}

-(void)clear
{
    @try {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *e) {}
}

@end
