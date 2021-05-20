//
//  MTPageControllModel.m
//  QXProject
//
//  Created by monda on 2020/4/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageControllModel.h"
#import "MTPageScrollView.h"
#import "MTPageTitleView.h"
#import "MTPageScrollController.h"
#import "MTContentModelPropertyConst.h"
#import "UILabel+Size.h"

@interface MTPageControllModel ()
{
    NSArray* _dataList;
}

@property (nonatomic,strong) MTPageScrollController* pageScrollController;
@property (nonatomic,weak) MTPageTitleView* pageTitleView;
@property (nonatomic,weak) UIScrollView* pageScrollHorizontalView;

@property (nonatomic,assign) NSInteger preCurrentIndex;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign, readonly) NSInteger maxIndex;
@property (nonatomic,assign) NSInteger unknownCellIndex;

@property (nonatomic,strong,readonly) NSObject* pageScrollData;

@property (nonatomic, strong) NSMutableArray *pageControllerArray;

@property (nonatomic,strong) NSMutableArray* cellWidthList;
@property (nonatomic,strong) NSMutableArray* cellCenterXList;
@property (nonatomic,strong) NSMutableArray* selectedCellWidthList;

/**固定样式*/
@property (nonatomic,assign) BOOL wordStyleChange;
@property (nonatomic,assign) BOOL isUnknownCell;
@property (nonatomic,assign) BOOL isPageScrollHorizontalViewDragging;

@property (nonatomic,assign, readonly) NSInteger pageScrollViewMaxOffsetYWithoutTitleHeight;

/**水平与垂直滚动控制*/
@property (nonatomic,assign) BOOL horizontalScrollEnable;
@property (nonatomic,assign) BOOL verticalScrollEnable;

@end

@implementation MTPageControllModel

#pragma mark - init

-(instancetype)init
{
    if(self = [super init])
    {
        self.wordStyleChange = YES;
        self.pageControllerArray = [NSMutableArray array];
        self.cellWidthList = [NSMutableArray arrayWithObject:@(0)];
        self.cellCenterXList = [NSMutableArray arrayWithObject:@(0)];
        self.selectedCellWidthList = [NSMutableArray arrayWithObject:@(0)];
    }
    
    return self;
}

#pragma mark - pageScrollView 代理

-(void)pageScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    if(self.scrollType == MTPageControllModelScrollTypeTitleFixed)
    {
        if(self.pageScrollListView.offsetY > 0)
            pageScrollView.offsetY = self.pageScrollViewMaxOffsetY;
            
        return;
    }
        
    if(pageScrollView.offsetY > self.pageScrollViewMaxOffsetY)
        pageScrollView.offsetY = self.pageScrollViewMaxOffsetY;
        
    if(self.pageScrollListView.offsetY > 0)
        pageScrollView.offsetY = self.pageScrollViewMaxOffsetY;
}

- (void)pageScrollViewBeginDragging
{
    self.horizontalScrollEnable = false;
}

- (void)pageScrollViewEndDragging
{
    self.horizontalScrollEnable = YES;
}

#pragma mark - pageScrollListView 代理

-(void)pageScrollListViewWillAppear:(UIScrollView*)pageScrollListView
{
    pageScrollListView.scrollEnabled = YES;
    if(self.pageScrollView.offsetY < self.pageScrollViewMaxOffsetY)
        pageScrollListView.offsetY = 0;
}

-(void)pageScrollListViewDidAppear:(UIScrollView*)pageScrollListView
{
    _pageScrollListView = pageScrollListView;
}

-(void)pageScrollListViewDidDisappear:(UIScrollView*)pageScrollListView
{
    if(self.pageScrollListView == pageScrollListView)
        _pageScrollListView = nil;
}

-(void)pageScrollListViewDidScroll:(UIScrollView *)pageScrollListView
{
    if(self.scrollType == MTPageControllModelScrollTypeTitleFixed)
    {
        if(self.pageScrollView.offsetY > 0 && self.pageScrollView.offsetY < self.pageScrollViewMaxOffsetY)
            pageScrollListView.offsetY = 0;
        return;
    }
        
        
//    NSLog(@"%lf",pageScrollListView.offsetY);
    
    if(pageScrollListView.offsetY < 0)
        pageScrollListView.offsetY = 0;
        
    if(self.pageScrollView.offsetY < self.pageScrollViewMaxOffsetY)
        pageScrollListView.offsetY = 0;
}

- (void)pageScrollListViewBeginDragging:(UIScrollView *)pageScrollListView
{
    self.horizontalScrollEnable = false;
}

- (void)pageScrollListViewEndDragging
{
    self.horizontalScrollEnable = YES;
}

#pragma mark - 点击标题

-(void)pageTitleViewDidSelectItemAtIndex:(NSInteger)selectedIndex
{
    if(self.isPageScrollHorizontalViewDragging)
        return;
    
    if(selectedIndex == self.currentIndex)
        return;
    
    if(self.currentIndex >= self.pageControllerArray.count)
    {
        self.currentIndex = selectedIndex;
        [self reloadPageTitleView];
        return;
    }
                    
    self.pageScrollController.currentIndex = selectedIndex;
    [self reloadPageTitleView];
    
    [self.pageScrollController setValue:@(selectedIndex) forKey:@"finishIndex"];
    [self.pageScrollController setViewControllers:@[self.pageControllerArray[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    
    if([self.delegate respondsToSelector:@selector(pageViewDidEndScroll)])
        [self.delegate pageViewDidEndScroll];
}

-(void)setPageTitleViewDataForIndex:(NSInteger)index ViewState:(NSInteger)viewState
{
    if(index >= self.titleControllModel.dataSourceModel.dataList.count)
        return;
    
    NSDictionary* dict = self.titleControllModel.dataSourceModel.dataList[index];
    if(![dict isKindOfClass:[NSDictionary class]])
        return;
    
    MTBaseViewContentModel* titleModel = dict[kTitle];
    if(![titleModel isKindOfClass:[MTBaseViewContentModel class]])
        return;
            
    titleModel.viewState = viewState;
}

-(void)reloadPageTitleView
{
    self.pageTitleView.backgroundColor = self.titleControllModel.titleViewBgColor;
    if(self.titleControllModel.bottomLineImage)
        self.pageTitleView.bottomLine.image = self.titleControllModel.bottomLineImage;
    else
        self.pageTitleView.bottomLine.backgroundColor = self.titleControllModel.bottomLineColor;
         
    self.pageTitleView.bottomLine.width = self.titleControllModel.isEqualBottomLineWidth ? self.titleControllModel.bottomLineWidth :  [self.selectedCellWidthList[self.currentIndex] floatValue];
    if(self.titleControllModel.isEqualBottomLineWidth)
        self.pageTitleView.bottomLine.height = self.titleControllModel.bottomLineHeight;
       
    self.pageTitleView.bottomLine.maxY = self.pageTitleView.height - self.titleControllModel.bottomLineBottomMargin;
    
    self.pageTitleView.bottomLine.centerX = [self.cellCenterXList[self.currentIndex] floatValue];
            
    self.pageTitleView.contentInset = UIEdgeInsetsMake(0, self.titleControllModel.margin, 0, self.titleControllModel.margin);
            
    [self.pageTitleView reloadDataWithDataList:self.titleControllModel.dataSourceModel.dataList SectionList:self.titleControllModel.dataSourceModel.sectionList];
    
    [self.pageTitleView layoutIfNeeded];
}

#pragma mark - pageScrollHorizontalView 代理
- (void)pageScrollHorizontalViewDidScrollWithCurrentIndex:(NSNumber*)currentIndex0 Percentage:(NSNumber*)percentage0
{    
    NSInteger currentIndex = currentIndex0.integerValue;
    CGFloat percentage = percentage0.floatValue;
//    NSLog(@"qqqq ==== %lf === %zd",percentage, currentIndex);
    if(percentage < 0)
    {
        percentage = 1 - fabs(percentage);
        currentIndex--;
    }
    
    if(percentage < 0)
        percentage = 0;
    if(percentage > 1)
        percentage = 1;
    
    NSInteger nextIndex = currentIndex + 1;
    if(nextIndex > self.maxIndex)
        nextIndex = self.maxIndex;
    if(currentIndex < 0)
        currentIndex = 0;
        
//    if(percentage == 0)
//        NSLog(@"1111 ==== %lf",percentage);
//    NSLog(@"%lf === %zd === %zd",percentage, currentIndex, nextIndex);
    
    if(currentIndex >= self.cellCenterXList.count || currentIndex >= self.cellWidthList.count)
        return;
        
    CGFloat beginCenterX = [self.cellCenterXList[currentIndex] floatValue];
//    CGFloat beginWidth = [self.cellWidthList[currentIndex] floatValue];
    CGFloat beginWidth = [self.selectedCellWidthList[currentIndex] floatValue];
    
    if(nextIndex >= self.cellCenterXList.count || nextIndex  >= self.cellWidthList.count)
        return;
    CGFloat nextCenterX = [self.cellCenterXList[nextIndex] floatValue];
//    CGFloat nextWidth = [self.cellWidthList[nextIndex] floatValue];
    CGFloat nextWidth = [self.selectedCellWidthList[nextIndex] floatValue];
            
    MTPageTitleCell* currentCell = (MTPageTitleCell*)[self.pageTitleView cellForItemAtIndexPath:[NSIndexPath indexPathForRow: currentIndex inSection:0]];
    if(![currentCell isKindOfClass:[MTPageTitleCell class]])
        return;
    
    MTPageTitleCell* nextCell = (MTPageTitleCell*)[self.pageTitleView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:nextIndex  inSection:0]];
    if(![nextCell isKindOfClass:[MTPageTitleCell class]])
        return;
    
    if(currentCell || nextCell)
    {
        if(!currentCell || !nextCell)
        {
            if(!currentCell)
            {
                self.unknownCellIndex = currentIndex;
            }
            
            if(!nextCell)
            {
                self.unknownCellIndex = nextIndex;
            }
        }
        
        if(self.wordStyleChange)
        {
            [self colorChangeCurrentTitleCell:currentCell nextCell:nextCell changeScale:percentage];
            [self fontSizeChangeCurrentTitleCell:currentCell nextCell:nextCell changeScale:percentage];
        }
    }
    else
        self.isUnknownCell = YES;

    [self transitionBottomLineFrameWithCurrentCellCenterX:beginCenterX NextCellCenterX:nextCenterX CurrentCellWidth:beginWidth NextCellWidth:nextWidth Rate:percentage];
    
    if(currentIndex != self.preCurrentIndex)
    {
        self.preCurrentIndex = currentIndex;
        [self.pageTitleView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)pageScrollHorizontalViewBeginDragging
{
    self.isPageScrollHorizontalViewDragging = YES;
    self.verticalScrollEnable = false;
    if(self.currentIndex != self.pageScrollController.currentIndex)
        self.currentIndex = self.pageScrollController.currentIndex;
}

- (void)pageScrollHorizontalViewEndDragging
{
    self.isPageScrollHorizontalViewDragging = false;
    self.verticalScrollEnable = YES;

    [self pageScrollHorizontalViewDidEndDragging];
    if([self.delegate respondsToSelector:@selector(pageViewDidEndScroll)])
       [self.delegate pageViewDidEndScroll];
}

- (void)pageScrollHorizontalViewDidEndDragging{}

#pragma mark - 下划线变化
-(void)transitionBottomLineFrameWithCurrentCellCenterX:(CGFloat)currentCellCenterX NextCellCenterX:(CGFloat)nextCellCenterX CurrentCellWidth:(CGFloat)currentCellWidth NextCellWidth:(CGFloat)nextCellWidth Rate:(CGFloat)rate
{
    switch (self.titleControllModel.bottomLineStyle) {
        case MTPageTitleViewBottomLineStickiness:
        {
            [self transitionBottomLineFrameStickinessWithCurrentCellCenterX:currentCellCenterX NextCellCenterX:nextCellCenterX CurrentCellWidth:currentCellWidth NextCellWidth:nextCellWidth Rate:rate];
            break;
        }
            
        default:
        {
            self.pageTitleView.bottomLine.centerX = currentCellCenterX + (nextCellCenterX - currentCellCenterX) * rate;
            
            if(!self.titleControllModel.isEqualBottomLineWidth)
                self.pageTitleView.bottomLine.width = currentCellWidth + (nextCellWidth - currentCellWidth)*rate;
            break;
        }
    }
}

#pragma mark - 粘性下划线变化
-(void)transitionBottomLineFrameStickinessWithCurrentCellCenterX:(CGFloat)currentCellCenterX NextCellCenterX:(CGFloat)nextCellCenterX CurrentCellWidth:(CGFloat)currentCellWidth NextCellWidth:(CGFloat)nextCellWidth Rate:(CGFloat)rate
{
    CGFloat beginWidth = self.titleControllModel.isEqualBottomLineWidth ? self.titleControllModel.bottomLineWidth : currentCellWidth;
    CGFloat maxWidth = nextCellCenterX - currentCellCenterX;
    CGFloat endWidth = self.titleControllModel.isEqualBottomLineWidth ? self.titleControllModel.bottomLineWidth : nextCellWidth;
    
    CGFloat lineRate;
    if(rate <= 0.5)
        lineRate = 2 * rate;
    else
        lineRate = 1 - 2 * (rate - 0.5);
        
    CGFloat bottomLineX;
    CGFloat bottomLineW;
    if(rate <= 0.5)
    {
        bottomLineW = beginWidth + (maxWidth - beginWidth) * lineRate;
        CGFloat beginX = currentCellCenterX - beginWidth * 0.5;
        bottomLineX = beginX + (currentCellCenterX - beginX) * lineRate;
    }
    else
    {
        bottomLineW = endWidth + (maxWidth - endWidth) * lineRate;
        CGFloat endX = nextCellCenterX + endWidth * 0.5;
        CGFloat endRate = 2 * (rate - 0.5);
        CGFloat maxX = nextCellCenterX + (endX - nextCellCenterX) * endRate;
        bottomLineX = maxX - bottomLineW;
    }
    
    self.pageTitleView.bottomLine.x = bottomLineX;
    self.pageTitleView.bottomLine.width = bottomLineW;
}

#pragma mark - 文字颜色渐变

- (void)colorChangeCurrentTitleCell:(MTPageTitleCell *)currentCell nextCell:(MTPageTitleCell *)nextCell changeScale:(CGFloat)scale {
    
    if(currentCell == nextCell)
        return;
    
    //选中颜色
    CGFloat sel_red;
    CGFloat sel_green;
    CGFloat sel_blue;
    CGFloat sel_alpha;
    
    //未选中的颜色
    CGFloat de_sel_red = 0.0;
    CGFloat de_sel_green = 0.0;
    CGFloat de_sel_blue = 0.0;
    CGFloat de_sel_alpha = 0.0;
    
    
    if ([self.titleControllModel.selectedStyle.wordColor getRed:&sel_red green:&sel_green blue:&sel_blue alpha:&sel_alpha] && [self.titleControllModel.normalStyle.wordColor getRed:&de_sel_red green:&de_sel_green blue:&de_sel_blue alpha:&de_sel_alpha]) {
        //颜色的变化的大小
        CGFloat red_changge = sel_red - de_sel_red;
        CGFloat green_changge = sel_green - de_sel_green;
        CGFloat blue_changge = sel_blue - de_sel_blue;
        CGFloat alpha_changge = sel_alpha - de_sel_alpha;
        //颜色变化
        
        
        nextCell.textLabel.textColor = [UIColor colorWithRed:(de_sel_red + red_changge * scale) green: (de_sel_green + green_changge * scale) blue:(de_sel_blue + blue_changge * scale) alpha: (de_sel_alpha + alpha_changge * scale)];
        
        currentCell.textLabel.textColor = [UIColor colorWithRed:sel_red - red_changge * scale
                                                      green:sel_green - green_changge * scale
                                                       blue:sel_blue - blue_changge * scale
                                                      alpha:sel_alpha - alpha_changge * scale];
    }
}

#pragma mark - 文字大小变化
- (void)fontSizeChangeCurrentTitleCell:(MTPageTitleCell *)currentCell nextCell:(MTPageTitleCell *)nextCell changeScale:(CGFloat)scale
{
    if(currentCell == nextCell)
        return;
    
    CGFloat fontSizeOffset = self.titleControllModel.selectedStyle.wordSize - self.titleControllModel.normalStyle.wordSize;
    
    CGFloat currentFontSize = self.titleControllModel.selectedStyle.wordSize - fontSizeOffset * scale;
    CGFloat nextFontSize = self.titleControllModel.normalStyle.wordSize + fontSizeOffset * scale;
    
    //    NSLog(@"%zd --- %lf",currentCell.indexPath.row,currentFontSize);
    //    NSLog(@"%zd +++ %lf",nextCell.indexPath.row,nextFontSize);
    
    if (@available(iOS 8.2, *)) {
        
        CGFloat currentFontWeight = self.titleControllModel.selectedStyle.wordBold ? UIFontWeightBold : (self.titleControllModel.selectedStyle.wordThin ? UIFontWeightThin : UIFontWeightRegular);
        
        CGFloat nextFontWeight = self.titleControllModel.normalStyle.wordBold ? UIFontWeightBold : (self.titleControllModel.selectedStyle.wordThin ? UIFontWeightThin : UIFontWeightRegular);
        
        CGFloat fontWeightOffset = currentFontWeight - nextFontWeight;
        
        currentCell.textLabel.font = [UIFont systemFontOfSize:currentFontSize weight:(currentFontWeight - fontWeightOffset * scale)];
        nextCell.textLabel.font = [UIFont systemFontOfSize:nextFontSize weight:(nextFontWeight + fontWeightOffset * scale)];
    } else {
        
        currentCell.textLabel.font = mt_font(currentFontSize);
        nextCell.textLabel.font = mt_font(nextFontSize);
    }
    
    [currentCell.textLabel sizeToFit];
    [nextCell.textLabel sizeToFit];
}

-(void)resetModelData
{
    _dataList = nil;
    self.titleControllModel.dataSourceModel.dataList = nil;
}

#pragma mark - Getter、Setter

-(void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    [self.cellCenterXList removeAllObjects];
    [self.cellWidthList removeAllObjects];
    [self.selectedCellWidthList removeAllObjects];
        
    CGFloat titleViewX = 0;
    NSMutableArray* titleViewSectionList;
    
    if(!self.titleControllModel.dataSourceModel.dataList && [self.delegate respondsToSelector:@selector(pageScrollTitleDataList)] && (self.delegate.pageScrollTitleDataList.count > 0))
        self.titleControllModel.dataSourceModel.dataList = self.delegate.pageScrollTitleDataList;
    if(!self.titleControllModel.dataSourceModel.dataList)
        titleViewSectionList = [NSMutableArray array];
    
        __weak __typeof(self) weakSelf = self;
    NSMutableArray* pageControllerArray = [NSMutableArray array];
    for(NSInteger index = 0; index < dataList.count; index++)
    {
        NSObject* obj = dataList[index];

        CGFloat cellWidth = self.titleControllModel.isEqualCellWidth ? self.titleControllModel.cellWidth : [UILabel getRectWithRect:CGRectMake(0, 0, 0, self.titleControllModel.titleViewHeight) WordStyle:mt_WordStyleMake(self.titleControllModel.normalStyle.wordSize, obj.mt_tagIdentifier, nil)].size.width;
        titleViewX += cellWidth;
                
        [self.cellWidthList addObject:@(cellWidth)];
        [self.selectedCellWidthList addObject:@([UILabel getRectWithRect:CGRectMake(0, 0, 0, self.titleControllModel.titleViewHeight) WordStyle:mt_WordStyleMake(self.titleControllModel.selectedStyle.wordSize, obj.mt_tagIdentifier, nil)].size.width)];
        [self.cellCenterXList addObject:@(titleViewX - cellWidth * 0.5)];
  
        if(titleViewSectionList)
        {
            MTBaseViewContentStateModel* titleModel = [MTBaseViewContentStateModel new];
            if(obj.mt_tagIdentifier)
                titleModel.text = obj.mt_tagIdentifier;
            if(self.titleControllModel.normalStyle)
                titleModel.wordStyle = self.titleControllModel.normalStyle;
            if(self.titleControllModel.selectedStyle)
                titleModel.selected = mt_content(self.titleControllModel.selectedStyle);
            
            [titleViewSectionList addObject:@{
                kTitle : titleModel
            }.bind(@"MTPageTitleCell")
             .bindSize(CGSizeMake(self.titleControllModel.isEqualCellWidth ? self.titleControllModel.cellWidth : cellWidth, self.titleControllModel.titleViewHeight))
             .bindClick(^(NSIndexPath* indexPath){
                [weakSelf pageTitleViewDidSelectItemAtIndex:indexPath.row];
            })];
        }
                  
        if(index != dataList.count - 1)
            titleViewX += self.titleControllModel.padding;
            
        NSString* mt_reuseIdentifier = obj.mt_reuseIdentifier;
        Class c;
        if(mt_reuseIdentifier)
            c = NSClassFromString(mt_reuseIdentifier);
        else
        {
            if([obj isKindOfClass:[NSString class]])
                c = NSClassFromString((NSString*)obj);
        }
        
        UIViewController* vc;
        if([c isSubclassOfClass:[UIViewController class]])
        {
            UIViewController* vc0;
            if(index < self.pageControllerArray.count)
                vc0 = self.pageControllerArray[index];
            vc = [vc0 isKindOfClass:c] ? vc0 : c.new;
            if([vc isKindOfClass:NSClassFromString(@"MTPageScrollListController")])
            {
                UIScrollView* listView = [vc valueForKey:@"mtListView"];
                [listView setValue:self forKey:@"mt_pageControllModel"];
            }
            [vc whenGetPageData:[obj isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)obj).data : ([obj isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)obj).data : obj)];
        }
        else
            vc = UIViewController.new;
        
        [pageControllerArray addObject:vc];
    }
    self.pageControllerArray = pageControllerArray;
    
    if(titleViewSectionList.count)
        self.titleControllModel.dataSourceModel.dataList = titleViewSectionList;
        
    self.beginPage = self.beginPage;    
    self.pageScrollController.pageControllerArray = self.pageControllerArray;
}

-(NSArray *)dataList
{
    if(!_dataList && [self.delegate respondsToSelector:@selector(pageScrollDataList)] && (self.delegate.pageScrollDataList.count > 0))
    {
        self.dataList = self.delegate.pageScrollDataList;
    }
    
    return _dataList;
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    [self setPageTitleViewDataForIndex:_currentIndex ViewState:kDefault];
    _currentIndex = currentIndex;
    _currentPage = currentIndex;
    [self setPageTitleViewDataForIndex:_currentIndex ViewState:kSelected];
}

-(NSObject *)pageScrollData
{
    if(self.pageSumHeight < 0)
        return nil;
    NSString* cellClass;
    if([self.pageScrollView isKindOfClass:[MTPageScrollView class]])
        cellClass = @"MTPageScrollCell";
    if([self.pageScrollView isKindOfClass:[MTPageScrollViewX class]])
        cellClass = @"MTPageScrollCellX";
    
    if(!cellClass)
        return nil;
    
    NSObject* pageScrollData = mt_weakReuse(self).bind(cellClass).bindHeight(self.pageSumHeight);
    return self.dataList ? pageScrollData : pageScrollData;
}

-(MTPageTitleControllModel *)titleControllModel
{
    if(!_titleControllModel)
    {
        _titleControllModel = [MTPageTitleControllModel new];
    }
    
    return _titleControllModel;
}

-(CGFloat)pageSumHeight
{
    return _pageSumHeight ? _pageSumHeight : (self.pageScrollView.height + self.titleControllModel.titleViewHeight);
}

-(NSInteger)pageScrollViewMaxOffsetY
{
    NSInteger pageScrollViewMaxOffsetY = self.pageScrollView.contentSize.height - self.pageSumHeight;
    return pageScrollViewMaxOffsetY;
}

-(NSInteger)pageScrollViewMaxOffsetYWithoutTitleHeight
{
    return self.pageScrollViewMaxOffsetY + (_pageSumHeight ? 0 : self.titleControllModel.titleViewHeight);
}

-(MTPageScrollController *)pageScrollController
{
    if(!_pageScrollController)
    {
        _pageScrollController = [MTPageScrollController new];
        _pageScrollController.pageControllModel = self;
    }
    
    return _pageScrollController;
}

-(NSInteger)maxIndex
{
    NSInteger maxIndex = self.titleControllModel.dataSourceModel.dataList.count - 1;
    if(maxIndex < 0)
        maxIndex = 0;
    
    return maxIndex;
}

-(void)setScrollType:(MTPageControllModelScrollType)scrollType
{
    _scrollType = scrollType;
    switch (scrollType) {
        case MTPageControllModelScrollTypeTitleFixed:
        {
            self.pageScrollView.bounces = false;
            break;
        }
                        
        default:
            break;
    }
}

-(void)setHorizontalScrollEnable:(BOOL)horizontalScrollEnable
{
    _horizontalScrollEnable = horizontalScrollEnable;
    
    self.pageScrollHorizontalView.scrollEnabled = horizontalScrollEnable;
}

-(void)setVerticalScrollEnable:(BOOL)verticalScrollEnable
{
    _verticalScrollEnable = verticalScrollEnable;
    
    self.pageScrollView.scrollEnabled = verticalScrollEnable;
    self.pageScrollListView.scrollEnabled = verticalScrollEnable;
}

-(void)setPageTitleView:(MTPageTitleView *)pageTitleView
{
    _pageTitleView = pageTitleView;
    pageTitleView.pageControllModel = self;
    
    [self reloadPageTitleView];
}

-(void)setBeginPage:(NSInteger)beginPage
{
    _beginPage = beginPage;
    
    self.pageScrollController.currentIndex = beginPage;
    [self.pageScrollController setValue:@(beginPage) forKey:@"finishIndex"];
}

-(void)setPageScrollHorizontalView:(UIScrollView *)pageScrollHorizontalView
{
    _pageScrollHorizontalView = pageScrollHorizontalView;
    
    if([self.delegate isKindOfClass:[UIViewController class]])
    {
        UIViewController* controller = (UIViewController*)self.delegate;
        if(controller.navigationController)
            [pageScrollHorizontalView.panGestureRecognizer requireGestureRecognizerToFail:controller.navigationController.interactivePopGestureRecognizer];
    }
}

-(MTPageScrollListController *)currentPageScrollListController
{
    if(self.currentPage < self.pageControllerArray.count)
        return self.pageControllerArray[self.currentPage];
    return nil;
}

@end


@implementation UIViewController (MTPageControllModel)

-(void)whenGetPageData:(NSObject *)data{}

@end
