//
//  MTDragCollectionView.m
//  MyTool
//
//  Created by 王奕聪 on 2017/4/19.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDragCollectionView.h"
#import "MTDragCollectionViewCell.h"
#import "MTConst.h"

NSString*  MTDragGestureOrder = @"MTDragGestureOrder";
NSString*  MTDragGestureBeganOrder = @"MTDragGestureBeganOrder";
NSString*  MTDragGestureEndOrder = @"MTDragGestureEndOrder";
NSString*  MTDragDeleteOrder = @"MTDragDeleteOrder";

@interface MTDragCollectionView ()<MTDelegateProtocol>

@property (nonatomic,strong) UIView * snapshotView; //截屏得到的view
@property (nonatomic,weak) MTDragCollectionViewCell * originalCell;

@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;


@end

@implementation MTDragCollectionView



-(void)doSomeThingForMe:(id)obj withOrder:(NSString *)order withItem:(id)item
{
    if([order isEqualToString:MTDragGestureOrder])
    {
        //记录上一次手势的位置
        static CGPoint startPoint;
        UIGestureRecognizer* gestureRecognizer = (UIGestureRecognizer *)item;
        //触发长按手势的cell
        MTDragCollectionViewCell * cell = (MTDragCollectionViewCell *)obj;//gestureRecognizer.view;
        
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {            
            //开始长按
            if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
                
                self.scrollEnabled = NO;
            }
            
            
            //获取cell的截图
            _snapshotView  = [cell snapshotViewAfterScreenUpdates:YES];
            _snapshotView.center = cell.center;
            [self addSubview:_snapshotView];
            _indexPath = [self indexPathForCell:cell];
            _originalCell = cell;
            _originalCell.hidden = YES;
            startPoint = [gestureRecognizer locationInView:self];
            
            if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
                [self.mt_delegate doSomeThingForMe:self withOrder:MTDragGestureBeganOrder];
            //移动
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:self].x - startPoint.x;
            CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:self].y - startPoint.y;
            
            //设置截图视图位置
            _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
            startPoint = [gestureRecognizer locationOfTouch:0 inView:self];
            //计算截图视图和哪个cell相交
            for (MTDragCollectionViewCell *cell in [self visibleCells]) {
                //跳过隐藏的cell
                if ([self indexPathForCell:cell] == _indexPath) continue;
                
                //计算中心距
                CGFloat space = sqrtf(powf(_snapshotView.center.x - cell.center.x, 2) + powf(_snapshotView.center.y - cell.center.y, 2));
                
                //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
                if ((space <= _snapshotView.frame.size.width * 0.5) && (fabs(_snapshotView.center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                    _nextIndexPath = [self indexPathForCell:cell];
                    
                    if (self.dragItems)
                    {
                        if( _nextIndexPath.item > _indexPath.item) {
                            for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++) {
                                [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                            }
                        }else{
                            for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --) {
                                [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                            }
                        }
                    }
                    
                    //移动
                    [self moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                    //设置移动后的起始indexPath
                    _indexPath = _nextIndexPath;
                    break;
                }
            }
            //停止
        }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            self.scrollEnabled = YES;
            [_snapshotView removeFromSuperview];
            _originalCell.hidden = NO;
            if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
                [self.mt_delegate doSomeThingForMe:self withOrder:MTDragGestureEndOrder];
        }
    }
}

-(void)doSomeThingForMe:(id)obj withOrder:(NSString *)order
{
    if([order isEqualToString:MTDragDeleteOrder])
    {
        MTDragCollectionViewCell * cell = (MTDragCollectionViewCell *)obj;
        
        if (self.dragItems)
            [self.dragItems removeObjectAtIndex:cell.indexPath.item];        
        [self deleteItemsAtIndexPaths:@[cell.indexPath]];
    }
}


@end
