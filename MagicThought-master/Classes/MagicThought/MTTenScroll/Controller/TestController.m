//
//  TestController.m
//  DaYiProject
//
//  Created by monda on 2018/12/3.
//  Copyright © 2018 monda. All rights reserved.
//

#import "TestController.h"
#import "MTTenScrollContentView.h"
#import "MTTenScrollTitleView.h"
#import "MTTenScrollModel.h"
#import "MTTenScrollView.h"
#import "MTTenScrollViewCell.h"


#import "MTRefresh.h"
#import "MTConst.h"
#import "UIDevice+DeviceInfo.h"
#import "UIView+Frame.h"

#import "NSObject+ReuseIdentifier.h"

#import "MTBaseDataModel.h"

@interface UICollectionViewCell2 : MTDelegateCollectionViewCell

@end


@implementation UICollectionViewCell2

-(void)setupDefault
{
    [super setupDefault];
    
    UILabel* titile = [UILabel new];
    titile.text = @"adas";
    [titile sizeToFit];
    
    [self addSubview:titile];
}

@end

@interface TestSubController : MTViewController

@end

@implementation TestSubController

-(void)setupDefault
{
    [super setupDefault];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)whenGetTenScrollDataModel:(MTBaseDataModel *)model
{
    UIColor* color = (UIColor*)model.data;
    if(!color)
        color = [UIColor yellowColor];
    
    self.view.backgroundColor = color;
}

@end

@interface TestTableViewController : MTTenScrollListController

@end

@implementation TestTableViewController

-(void)whenGetTenScrollDataModel:(MTBaseDataModel *)model
{
    
}

-(NSArray *)dataList
{
    return (NSArray*)@"UICollectionViewCell2".bindCount(6).bindHeight(44);
    return (NSArray*)@"UITableViewCell".bindCount(6).bindHeight(44);
}

@end


@interface TestController ()

@end

@implementation TestController


#pragma mark - 懒加载

-(NSArray *)dataList
{
    return (NSArray*)@"UICollectionViewCell2".bindCount(0).bindHeight(44);
    return (NSArray*)@"UITableViewCell".bindCount(0).bindHeight(44);
}

-(NSArray *)tenScrollDataList
{
            return @[
                                mt_reuse([UIColor yellowColor]).bind(@"TestTableViewController").bindTag(@"头号"),
                                mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"头号1"),
                                mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
                                mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
                                mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
                                mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
                                mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"大头鱼"),
                                mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"大易有塑7"),
                                mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"大易有塑18"),
                                mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"手机号"),
                                mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"尾号"),
                                ];
    
    return @[
        mt_reuse([UIColor yellowColor]).bind(@"TestController2").bindTag(@"头号0"),
        mt_reuse([UIColor purpleColor]).bind(@"TestController2").bindTag(@"掌经号"),
        mt_reuse([UIColor redColor]).bind(@"TestController2").bindTag(@"精选视频"),
        mt_reuse([UIColor blueColor]).bind(@"TestController2").bindTag(@"生活"),
        mt_reuse([UIColor greenColor]).bind(@"TestController2").bindTag(@"好物"),
        mt_reuse([UIColor yellowColor]).bind(@"TestController2").bindTag(@"大头鱼")
    ]; 
}


@end



@interface TestController2 : MTTenScrollController


@end

@implementation TestController2


#pragma mark - 懒加载

-(NSArray *)dataList
{
    return (NSArray*)@"UITableViewCell".bindCount(0).bindHeight(44);
}

-(NSArray *)tenScrollDataList
{
//        return        @[
//                        mt_reuse([UIColor redColor]).bind(@"TestTableViewController").bindTag(@"XXX"),
//                        mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
//                        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
//                        mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
//                        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
//                        mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"大头鱼")
//                        ];
                  return      @[
                                    mt_reuse([UIColor yellowColor]).bind(@"TestController3").bindTag(@"头号"),
                                    mt_reuse([UIColor purpleColor]).bind(@"TestController3").bindTag(@"掌经号"),
                                    mt_reuse([UIColor redColor]).bind(@"TestController3").bindTag(@"精选视频"),
                                    mt_reuse([UIColor blueColor]).bind(@"TestController3").bindTag(@"生活"),
                                    mt_reuse([UIColor purpleColor]).bind(@"TestController3").bindTag(@"好物"),
                                    mt_reuse([UIColor yellowColor]).bind(@"TestController3").bindTag(@"大头鱼")
                                    ];
    return        @[
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"头号00000"),
        mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
        mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"大头鱼")
    ];
}

@end

@interface TestController3 : MTTenScrollController


@end

@implementation TestController3

#pragma mark - 懒加载

-(NSArray *)dataList
{
    return (NSArray*)@"UITableViewCell".bindCount(0).bindHeight(44);
}

-(NSArray *)tenScrollDataList
{
            return        @[
                            mt_reuse([UIColor redColor]).bind(@"TestTableViewController").bindTag(@"头号"),
                            mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
                            mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
                            mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
                            mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"好物"),
                            mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"大头鱼")
                            ];
        return      @[
                      mt_reuse([UIColor yellowColor]).bind(@"TestController4").bindTag(@"头号"),
                      mt_reuse([UIColor purpleColor]).bind(@"TestController4").bindTag(@"掌经号"),
                      mt_reuse([UIColor redColor]).bind(@"TestController4").bindTag(@"精选视频"),
                      mt_reuse([UIColor blueColor]).bind(@"TestController4").bindTag(@"生活"),
                      mt_reuse([UIColor greenColor]).bind(@"TestController4").bindTag(@"好物"),
                      mt_reuse([UIColor yellowColor]).bind(@"TestController4").bindTag(@"大头鱼")
                      ];
//    return        @[
//        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"头号1"),
//        mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
//        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
//        mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
//        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
//        mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"大头鱼")
//    ];
}

@end


@interface TestController4 : MTTenScrollController


@end

@implementation TestController4

#pragma mark - 懒加载

-(NSArray *)dataList
{
    return (NSArray*)@"UITableViewCell".bindCount(4).bindHeight(44);
}

-(NSArray *)tenScrollDataList
{
     return        @[
          mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"头号1"),
          mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
          mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
          mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
          mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
          mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"大头鱼")
      ];
    return      @[
        mt_reuse([UIColor yellowColor]).bind(@"TestController5").bindTag(@"头号"),
        mt_reuse([UIColor purpleColor]).bind(@"TestController5").bindTag(@"掌经号"),
        mt_reuse([UIColor redColor]).bind(@"TestController5").bindTag(@"精选视频"),
        mt_reuse([UIColor blueColor]).bind(@"TestController5").bindTag(@"生活"),
        mt_reuse([UIColor greenColor]).bind(@"TestController5").bindTag(@"好物"),
        mt_reuse([UIColor yellowColor]).bind(@"TestController5").bindTag(@"大头鱼")
    ];
    
    return @[
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"头号2"),
        mt_reuse([UIColor purpleColor]).bind(@"TestTableViewController").bindTag(@"掌经号"),
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
        mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
        mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"大头鱼")
    ];
}

@end


@interface TestController5 : MTTenScrollController


@end

@implementation TestController5

-(void)setupDefault
{
    [super setupDefault];
    
    self.tenScrollModel.tenScrollHeight = kScreenHeight_mt();
}

#pragma mark - 懒加载

-(NSArray *)dataList
{
    return (NSArray*)@"UITableViewCell".bindCount(0).bindHeight(44);
}

-(NSArray *)tenScrollDataList
{
        return        @[
                        mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"头号"),
                        mt_reuse([UIColor purpleColor]).bind(@"TestSubController").bindTag(@"掌经号"),
                        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
                        mt_reuse([UIColor blueColor]).bind(@"TestSubController").bindTag(@"生活"),
                        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
                        mt_reuse([UIColor yellowColor]).bind(@"TestSubController").bindTag(@"大头鱼")
                        ];
    return      @[
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"头号"),
        mt_reuse([UIColor purpleColor]).bind(@"TestTableViewController").bindTag(@"掌经号"),
        mt_reuse([UIColor redColor]).bind(@"TestSubController").bindTag(@"精选视频"),
        mt_reuse([UIColor blueColor]).bind(@"TestTableViewController").bindTag(@"生活"),
        mt_reuse([UIColor greenColor]).bind(@"TestSubController").bindTag(@"好物"),
        mt_reuse([UIColor yellowColor]).bind(@"TestTableViewController").bindTag(@"大头鱼")
    ];
}

@end


@interface MTPageTestController : UIViewController

@property (nonatomic,strong) NSNumber* index;

@end

@implementation MTPageTestController

-(void)whenDealloc
{
    NSLog(@"MTPageTestController销毁");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* label = [UILabel new];
    label.text = self.index.stringValue;
    [label sizeToFit];
    
    label.center = self.view.center;
    [self.view addSubview:label];
}

-(void)whenGetPageData:(NSNumber *)data
{
     self.index = data;
}

-(instancetype)setWithObject:(NSNumber *)obj
{
    self.index = obj;
    return self;
}

@end


@interface MTPageController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic,strong) NSArray<MTPageTestController*>* pageTestControllerArray;

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger nextIndex;

@property (nonatomic,weak) UIScrollView* scrollView;

@end

@implementation MTPageController

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
            [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
            break;
        }
    }
    
    [self setViewControllers:@[self.pageTestControllerArray[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat percentage = (scrollView.offsetX - self.view.width) / self.view.width;
                                                                                        
    NSLog(@"%lf === %zd",percentage, self.currentIndex);

//    [self.titleView setUplineViewSlideWhenScroll:percentage currentIndex:self.currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.pageTestControllerArray indexOfObject:(MTPageTestController*)viewController];
    index --;
    if(index < 0)
        index = self.pageTestControllerArray.count - 1;
    
    return self.pageTestControllerArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.pageTestControllerArray indexOfObject:(MTPageTestController*)viewController];
    index ++;
    if(index > self.pageTestControllerArray.count - 1)
        index = 0;
    
    return self.pageTestControllerArray[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
        
    self.nextIndex = [self.pageTestControllerArray indexOfObject:(MTPageTestController*)[pendingViewControllers firstObject]];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (completed) 
        self.currentIndex = self.nextIndex;
}

-(NSArray<MTPageTestController *> *)pageTestControllerArray
{
    if(!_pageTestControllerArray)
    {
        _pageTestControllerArray = @[
                            MTPageTestController.new(@(0)),
                            MTPageTestController.new(@(1)),
                            MTPageTestController.new(@(2)),
                            MTPageTestController.new(@(3))
        ];
    }
    
    return _pageTestControllerArray;
}

-(instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<UIPageViewControllerOptionsKey,id> *)options
{
    if(self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:navigationOrientation options:options]);
        
    return self;
}

@end

