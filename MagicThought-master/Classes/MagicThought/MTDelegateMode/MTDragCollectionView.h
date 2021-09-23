//
//  MTDragCollectionView.h
//  MyTool
//
//  Created by 王奕聪 on 2017/4/19.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDelegateCollectionView.h"

extern NSString*  MTDragGestureOrder;
extern NSString*  MTDragGestureBeganOrder;
extern NSString*  MTDragGestureEndOrder;
extern NSString*  MTDragDeleteOrder;

@protocol MTDragCollectionViewDragDelegate<NSObject>

@optional

-(BOOL)shouldChangeItemWithIndexPath:(NSIndexPath*)indexPath;

- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2 Section:(NSInteger)section;

@end

@interface MTDragCollectionView : MTDelegateCollectionView

@property (nonatomic,weak) id<MTDragCollectionViewDragDelegate> mtDragDelegate;

@property(nonatomic,weak) NSArray<NSMutableArray*>* dragItems;

@end
