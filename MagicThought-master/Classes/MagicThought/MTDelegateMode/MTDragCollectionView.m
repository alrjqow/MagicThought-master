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

typedef NS_ENUM(NSUInteger, MTDragCollectionViewScrollDirection) {
    MTDragCollectionViewScrollDirectionNone = 0,
    MTDragCollectionViewScrollDirectionLeft,
    MTDragCollectionViewScrollDirectionRight,
    MTDragCollectionViewScrollDirectionUp,
    MTDragCollectionViewScrollDirectionDown
};

@interface MTDragCollectionView ()<MTDelegateProtocol>

@property (nonatomic,strong) UIView * snapshotView; //截屏得到的view
@property (nonatomic,weak) MTDragCollectionViewCell * originalCell;

@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;

@property (nonatomic, strong) CADisplayLink *edgeDisplayLink;

@property (nonatomic,assign) CGPoint startPoint; //记录上一次手势的位置

@end

@implementation MTDragCollectionView


-(void)doSomeThingForMe:(id)obj withOrder:(NSString *)order withItem:(id)item
{
    if([order isEqualToString:MTDragGestureOrder])
    {
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
            self.startPoint = [gestureRecognizer locationInView:self];
            
            [self setupDisplayLink];
            
            if([self.mt_delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
                [self.mt_delegate doSomeThingForMe:self withOrder:MTDragGestureBeganOrder];
            //移动
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            
            BOOL canChange = YES;
                        
            CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:self].x - self.startPoint.x;
            CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:self].y - self.startPoint.y;
            
            //设置截图视图位置
            _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
            self.startPoint = [gestureRecognizer locationOfTouch:0 inView:self];
            //计算截图视图和哪个cell相交
            for (MTDragCollectionViewCell *cell in [self visibleCells]) {
                //跳过隐藏的cell
                if ([self indexPathForCell:cell] == _indexPath) continue;
                
                //计算中心距
                CGFloat space = sqrtf(powf(_snapshotView.center.x - cell.center.x, 2) + powf(_snapshotView.center.y - cell.center.y, 2));
                
                //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
                if ((space <= _snapshotView.frame.size.width * 0.5) && (fabs(_snapshotView.center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                    _nextIndexPath = [self indexPathForCell:cell];
                                        
                    if([self.mtDragDelegate respondsToSelector:@selector(shouldChangeItemWithIndexPath:)])
                        canChange = [self.mtDragDelegate shouldChangeItemWithIndexPath:_nextIndexPath];
                    
                    if(!canChange)
                        continue;
                    
                    BOOL isTop = _indexPath.row > _nextIndexPath.row;
                    
                    if(self.dragItems)
                    {
                        if(isTop)
                            for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --)
                                [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                        else
                            for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++)
                                [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    }
                    
                    //移动
                    [self moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                    if(labs(_nextIndexPath.row - _indexPath.row) > 1)
                    {
                        NSInteger row = _nextIndexPath.row + (isTop ? 1 : -1);
                        
                        if(row < [self numberOfItemsInSection:0])
                        {
                            NSIndexPath* startIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
                            if(self.dragItems)
                            {
                                isTop = startIndexPath.row > _indexPath.row;
                                if(isTop)
                                    for (NSUInteger i = startIndexPath.item; i > _indexPath.item ; i --)
                                        [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                                else
                                    for (NSUInteger i = startIndexPath.item; i < _indexPath.item ; i ++)
                                        [self.dragItems exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                            }
                            
                            [self moveItemAtIndexPath:startIndexPath toIndexPath:_indexPath];
                        }
                    }
                    //设置移动后的起始indexPath
                    _indexPath = _nextIndexPath;
                    break;
                }
            }
            //停止
        }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            
            [self stopDisplayLink];
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


-(void)edgeScroll
{
    MTDragCollectionViewScrollDirection scrollDirection = MTDragCollectionViewScrollDirectionNone;
    if (self.bounds.size.height + self.contentOffset.y - _snapshotView.center.y < _snapshotView.bounds.size.height / 2 && self.bounds.size.height + self.contentOffset.y < self.contentSize.height) {
        scrollDirection = MTDragCollectionViewScrollDirectionDown;
    }
    if (_snapshotView.center.y - self.contentOffset.y < _snapshotView.bounds.size.height / 2 && self.contentOffset.y > 0) {
        scrollDirection = MTDragCollectionViewScrollDirectionUp;
    }
    if (self.bounds.size.width + self.contentOffset.x - _snapshotView.center.x < _snapshotView.bounds.size.width / 2 && self.bounds.size.width + self.contentOffset.x < self.contentSize.width) {
        scrollDirection = MTDragCollectionViewScrollDirectionRight;
    }
    
    if (_snapshotView.center.x - self.contentOffset.x < _snapshotView.bounds.size.width / 2 && self.contentOffset.x > 0) {
        scrollDirection = MTDragCollectionViewScrollDirectionLeft;
    }
    
    switch (scrollDirection) {
        case MTDragCollectionViewScrollDirectionLeft:{
            //这里的动画必须设为NO
            [self setContentOffset:CGPointMake(self.contentOffset.x - 4, self.contentOffset.y) animated:NO];
            _snapshotView.center = CGPointMake(_snapshotView.center.x - 4, _snapshotView.center.y);
            
            _startPoint.x -= 4;
        }
            break;
        case MTDragCollectionViewScrollDirectionRight:{
            [self setContentOffset:CGPointMake(self.contentOffset.x + 4, self.contentOffset.y) animated:NO];
            _snapshotView.center = CGPointMake(_snapshotView.center.x + 4, _snapshotView.center.y);
            _startPoint.x += 4;
            
        }
            break;
        case MTDragCollectionViewScrollDirectionUp:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 4) animated:NO];
            _snapshotView.center = CGPointMake(_snapshotView.center.x, _snapshotView.center.y - 4);
            _startPoint.y -= 4;
        }
            break;
        case MTDragCollectionViewScrollDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 4) animated:NO];
            _snapshotView.center = CGPointMake(_snapshotView.center.x, _snapshotView.center.y + 4);
            _startPoint.y += 4;
        }
            break;
        default:
            break;
    }
}

- (void)setupDisplayLink
{
    self.edgeDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(edgeScroll)];
    [self.edgeDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopDisplayLink
{
    [self.edgeDisplayLink invalidate];
    self.edgeDisplayLink = nil;
}

-(void)setMt_delegate:(id<MTDelegateProtocol>)mt_delegate
{
    [super setMt_delegate:mt_delegate];
    
    self.mtDragDelegate = (id) mt_delegate;
}

@end
