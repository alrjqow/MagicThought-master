//
//  MTPageControllModel.h
//  QXProject
//
//  Created by monda on 2020/4/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTPageTitleControllModel.h"
#import "MTDelegateProtocol.h"

typedef enum : NSInteger {
    
    /**默认把刷新至于最顶*/
    MTPageControllModelScrollTypeDefault,
    
    /**顶层标题栏固定,使刷新能置于标题底部*/
    MTPageControllModelScrollTypeTitleFixed,
    
} MTPageControllModelScrollType;

@protocol MTPageControllModelDelegate

@optional
-(void)pageViewDidEndScroll;

@end

@class MTPageScrollListController;
@interface MTPageControllModel : NSObject

@property (nonatomic,assign) MTPageControllModelScrollType scrollType;

@property (nonatomic,weak) NSObject<MTPageControllModelDelegate, MTDelegateViewDataProtocol>* delegate;

@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) MTPageTitleControllModel* titleControllModel;

@property (nonatomic,assign) CGFloat pageSumHeight;

/**contentView固定的偏移值*/
@property (nonatomic,assign) CGFloat contentViewFixOffset;

@property (nonatomic,assign) NSInteger beginPage;

@property (nonatomic,assign, readonly) NSInteger currentPage;

@property (nonatomic,weak, readonly) MTPageScrollListController* currentPageScrollListController;

/**点击了标题*/
-(void)pageTitleViewDidSelectItemAtIndex:(NSInteger)selectedIndex;

#pragma mark - 交互相关

@property (nonatomic,weak, readonly) UIScrollView* pageScrollView;
@property (nonatomic,weak, readonly) UIScrollView* pageScrollListView;

// MTPageScrollView 的滚动方法
-(void)pageScrollViewDidScroll:(UIScrollView *)pageScrollView;

// MTPageScrollListView 的滚动方法
-(void)pageScrollListViewDidScroll:(UIScrollView *)pageScrollListView;

// 水平滚动结束
- (void)pageScrollHorizontalViewDidEndDragging;

@end


@interface UIViewController (MTPageControllModel)

-(void)whenGetPageData:(NSObject *)data;

@end
