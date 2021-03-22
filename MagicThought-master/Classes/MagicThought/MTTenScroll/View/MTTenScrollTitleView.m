//
//  MTTenScrollTitleView.m
//  DaYiProject
//
//  Created by monda on 2018/12/19.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTTenScrollTitleView.h"
#import "MTTenScrollModel.h"
#import "MTTenScrollView.h"
#import "MTTenScrollContentView.h"


#import "UIView+Frame.h"
#import "MTCloud.h"
#import "MTWordStyle.h"
#import "UILabel+Word.h"
#import "NSObject+ReuseIdentifier.h"

@interface MTTenScrollTitleCell ()

@property (nonatomic,assign) BOOL isSelected;

@end

@interface MTTenScrollTitleView ()<UIGestureRecognizerDelegate>

@property (nonatomic,weak) MTTenScrollTitleCell* selectedCell;

@property (nonatomic,strong) UILabel* fitLabel;

@end

@implementation MTTenScrollTitleView

+(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return layout;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.fitLabel = [UILabel new];
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    self.clipsToBounds = false;
    self.bounces = false;
    
    if([MTCloud shareCloud].currentViewController.navigationController)
        [self.panGestureRecognizer requireGestureRecognizerToFail:[MTCloud shareCloud].currentViewController.navigationController.interactivePopGestureRecognizer];
    [self addSubview:self.bottomLine];
    [self addTarget:self EmptyData:nil DataList:nil SectionList:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceiveNotification:) name:@"NotificationTenScrollViewScroll" object:nil];
}

-(void)whenDealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationTenScrollViewScroll" object:nil];
}

- (void)whenReceiveNotification:(NSNotification *)info
{
    self.scrollEnabled = [info.userInfo[@"canScroll"] boolValue];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bottomLine.maxY = self.height - 2;
}

#pragma mark - 代理

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger unknownCellIndex = [[self.model valueForKey:@"unknownCellIndex"] integerValue];
    NSInteger currentIndex = [[self.model valueForKey:@"currentIndex"] integerValue];
    
    MTTenScrollContentView* contentView = [self.model valueForKey:@"contentView"];
    if(indexPath.row == unknownCellIndex)
    {
        CGFloat currentIndex = contentView.offsetX / contentView.width;
        if((currentIndex - (NSInteger)currentIndex) != 0)
        {
            ((MTTenScrollTitleCell*)cell).isSelected = YES;
            cell.selected = false;
        }
        else if(unknownCellIndex != (NSInteger)currentIndex)
        {
            ((MTTenScrollTitleCell*)cell).isSelected = YES;
            cell.selected = false;
        }
    }
    
    if(indexPath.row == currentIndex)
    {
        BOOL isContentViewDragging = [[self.model valueForKey:@"isContentViewDragging"] boolValue];
        if(contentView.isRolling || isContentViewDragging)
        {
            BOOL isUnknownCell = [[self.model valueForKey:@"isUnknownCell"] boolValue];
            if(isUnknownCell)
            {
                ((MTTenScrollTitleCell*)cell).isSelected = YES;
                cell.selected = false;
                [self.model setValue:@(false) forKey:@"isUnknownCell"];
            }
            return;
        }
            
        self.selectedCell = (MTTenScrollTitleCell*)cell;
        ((MTTenScrollTitleCell*)cell).isSelected = YES;
        cell.selected = YES;
        
        self.bottomLine.width = self.model.titleViewModel.isEqualBottomLineWidth ? self.model.titleViewModel.bottomLineWidth : ((MTTenScrollTitleCell*)cell).title.width;
        self.bottomLine.centerX = cell.centerX;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.model.titleViewModel.isEqualCellWidth)
        return CGSizeMake(self.model.titleViewModel.cellWidth, collectionView.height);
    
    NSArray* titleList = [self.model valueForKey:@"titleList"];
    return CGSizeMake([[self.fitLabel setWordWithStyle:mt_WordStyleMake(self.model.titleViewModel.normalStyle.wordSize, titleList[indexPath.row], nil)] sizeThatFits:CGSizeMake(MAXFLOAT, collectionView.height)].width, collectionView.height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!collectionView)
    {
        [self changeSelectedCellWithIndexPath:indexPath isTap:false];
        return;
    }
    
    NSInteger currentIndex = [[self.model valueForKey:@"currentIndex"] integerValue];
    if(currentIndex == indexPath.row)
        return;

    BOOL isContentViewDragging = [[self.model valueForKey:@"isContentViewDragging"] boolValue];
    MTTenScrollContentView* contentView = [self.model valueForKey:@"contentView"];
    if(contentView.isRolling || isContentViewDragging)
        return;
            
    [self changeSelectedCellWithIndexPath:indexPath isTap:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(titleViewWillBeginDragging)];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate)
        return;
    
    [self.model performSelector:@selector(didTitleViewEndScroll)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(didTitleViewEndScroll)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.model performSelector:@selector(titleViewDidScroll)];
}

-(void)changeSelectedCellWithIndexPath:(NSIndexPath *)indexPath isTap:(BOOL)isTap
{
    MTTenScrollTitleCell* cell = (MTTenScrollTitleCell*)[self cellForItemAtIndexPath:indexPath];
     self.selectedCell.isSelected = YES;
     self.selectedCell.selected = false;
     self.selectedCell = cell;
    self.selectedCell.isSelected = YES;
    self.selectedCell.selected = YES;
    
    if(isTap)
    {
        [self.model setValue:@(indexPath.row) forKey:@"currentIndex"];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.bottomLine.width = self.model.titleViewModel.isEqualBottomLineWidth ? self.model.titleViewModel.bottomLineWidth : ((MTTenScrollTitleCell*)cell).title.width;
            self.bottomLine.centerX = cell.centerX;
        }];
        
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [self.model performSelector:@selector(didTitleViewSelectedItem)];
    }
}

#pragma mark - 手势代理

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    MTTenScrollView* superTenScrollView = [self.model valueForKey:@"superTenScrollView"];
    MTTenScrollContentView* contentView = [superTenScrollView.mt_tenScrollModel valueForKey:@"contentView"];
    return otherGestureRecognizer == contentView.panGestureRecognizer;
}

#pragma mark - 懒加载

-(void)setModel:(MTTenScrollModel *)model
{
    _model = model;
    
    [model setValue:self forKey:@"titleView"];
    
    self.backgroundColor = model.titleViewModel.titleViewBgColor;
    if(model.titleViewModel.bottomLineImage)
    {
        self.bottomLine.backgroundColor = [UIColor clearColor];
        self.bottomLine.image = model.titleViewModel.bottomLineImage;
    }
    else
        self.bottomLine.backgroundColor = model.titleViewModel.bottomLineColor;
    
    self.contentInset = UIEdgeInsetsMake(0, model.titleViewModel.margin, 0, model.titleViewModel.margin);
    NSArray* titleList = [model valueForKey:@"titleList"];
    [self reloadDataWithDataList:(NSArray*)model.bindCount(titleList.count).bind(@"MTTenScrollTitleCell") SectionList:@[mt_empty().bindSpacing(mt_collectionViewSpacingMake(model.titleViewModel.padding, model.titleViewModel.padding, UIEdgeInsetsZero))]];
    
    [self collectionView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:model.beginPage inSection:0]];
}

-(UIImageView *)bottomLine
{
    if(!_bottomLine)
    {
        _bottomLine = [UIImageView new];        
        _bottomLine.height = 2;
    }
    
    return _bottomLine;
}

@end




@implementation MTTenScrollTitleCell


-(void)whenGetResponseObject:(MTTenScrollModel *)object
{
    self.model = object;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.title = [UILabel new];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title sizeToFit];
    self.title.center = self.contentView.center;
}


-(void)setModel:(MTTenScrollModel *)model
{
    _model = model;
        
    self.isSelected = YES;
    BOOL isContentViewDragging = [[model valueForKey:@"isContentViewDragging"] boolValue];
    NSInteger currentIndex = [[model valueForKey:@"currentIndex"] integerValue];
    MTTenScrollContentView* contentView = [model valueForKey:@"contentView"];
    if(contentView.isRolling || isContentViewDragging)
        self.selected = false;
    else
        self.selected = currentIndex == self.indexPath.row;

    NSArray* titleList = [model valueForKey:@"titleList"];
    if(self.indexPath.row < titleList.count)
        self.title.text = titleList[self.indexPath.row];
    
    [self.title sizeToFit];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if(!self.isSelected)
        return;
        
    self.isSelected = false;
    
    NSString* text = self.title.text;
    
    BOOL wordStyleChange = [[self.model valueForKey:@"wordStyleChange"] boolValue];
    [self.title setWordWithStyle: (selected && wordStyleChange) ? self.model.titleViewModel.selectedStyle : self.model.titleViewModel.normalStyle];
    
    self.title.text = text;
    [self.title sizeToFit];
}

-(Class)classOfResponseObject
{
    return [MTTenScrollModel class];
}

@end
