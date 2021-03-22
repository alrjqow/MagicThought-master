//
//  MTRefreshRing.h
//  DaYiProject
//
//  Created by monda on 2018/10/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MTRefreshRing : UIScrollView

/**设置圆环大小*/
@property (nonatomic,assign) CGSize size;

/**触发刷新的暂停点，值为父控件坐标系下的Y值*/
@property (nonatomic,assign) CGFloat stopY;

@property (nonatomic,strong, readonly) UIImageView* imgView;

+(instancetype)addTarget:(UIScrollView*)scrollView RefreshingBlock:(void(^)(void))refreshingBlock EndRefresh:(void(^)(void))endRefreshingBlock;

- (void)startRefresh;

- (void)endRefresh;

/**结束时调用*/
-(void)clear;

@end


