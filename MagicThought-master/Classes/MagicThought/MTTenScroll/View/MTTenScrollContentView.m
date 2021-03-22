//
//  MTTenScrollContentView.m
//  DaYiProject
//
//  Created by monda on 2018/12/4.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTTenScrollContentView.h"
#import "MTTenScrollModel.h"
#import "MTTenScrollView.h"
#import "MTTenScrollController.h"

#import "MTDelegateCollectionViewCell.h"
#import "UIView+Frame.h"
#import "MTCloud.h"
#import "NSObject+ReuseIdentifier.h"
#import "UIView+ViewController.h"

@interface MTTenScrollContentCell : MTDelegateCollectionViewCell

@property (nonatomic,weak) MTTenScrollModel* model;

@property (nonatomic,weak) MTTenScrollModel* subModel;

@property (nonatomic,weak) UIView* preView;

@end


@interface MTTenScrollContentView ()<MTDelegateProtocol,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@end


@implementation MTTenScrollContentView

+(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return layout;
}

-(void)setupDefault
{
    [super setupDefault];
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    
    self.bounces = false;
    
    self.pagingEnabled = YES;
    
    if([MTCloud shareCloud].currentViewController.navigationController)
        [self.panGestureRecognizer requireGestureRecognizerToFail:[MTCloud shareCloud].currentViewController.navigationController.interactivePopGestureRecognizer];
    
    [self addTarget:self EmptyData:nil DataList:nil SectionList:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceiveNotification:) name:@"NotificationTenScrollViewScroll" object:nil];
}

-(void)whenDealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationTenScrollViewScroll" object:nil];
}

#pragma mark - 成员方法

- (void)whenReceiveNotification:(NSNotification *)info
{    
    self.scrollEnabled = [info.userInfo[@"canScroll"] boolValue];
}

#pragma mark - 懒加载

-(void)setModel:(MTTenScrollModel *)model
{
    _model = model;
    
    [model setValue:self forKey:@"contentView"];
    [self reloadDataWithDataList:(NSArray*)model.bindCount(model.dataList.count).bind(@"MTTenScrollContentCell")];
    
    self.tag = 1;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.tag)
    {
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.model.beginPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        self.tag = 0;
    }    
}

#pragma mark - 代理
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.model performSelector:@selector(didContentViewEndScrollWithDecelerate:) withObject:@(decelerate)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(didContentViewEndScrollWithDecelerate:) withObject:@(false)];    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(contentViewWillBeginDragging)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(contentViewDidScroll)];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{}

#pragma mark - 手势代理


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end




@interface MTTenScrollContentCell ()<UIGestureRecognizerDelegate>


@end

@implementation MTTenScrollContentCell

- (void)whenGetResponseObject:(MTTenScrollModel *)object
{
    self.model = object;
}

-(void)setModel:(MTTenScrollModel *)model
{
    _model = model;
    
    UIView* preView = [model performSelector:@selector(getViewByIndex:) withObject:@(self.indexPath.row)];
    preView.frame = self.contentView.bounds;
    preView.hidden = false;
    
    UIViewController* vc = preView.viewController;
    
    if([vc isKindOfClass:[MTTenScrollController class]])
    {
       [((MTTenScrollController*)vc).tenScrollModel setValue:@(self.indexPath.row) forKey:@"superIndex"];
        NSMutableDictionary* subModelList = [model valueForKey:@"subModelList"];
        subModelList[[NSString stringWithFormat:@"%zd", self.indexPath.row]] = ((MTTenScrollController*)vc).tenScrollModel;
        self.subModel = ((MTTenScrollController*)vc).tenScrollModel;
    }
    
    [self addSubview:preView];
    if(self.preView != preView)
    {
        self.preView.hidden = YES;
        self.preView = preView;
    }
}

-(Class)classOfResponseObject
{
    return [MTTenScrollModel class];
}

@end
