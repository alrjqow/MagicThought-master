//
//  MTDragCollectionViewCell.m
//  MyTool
//
//  Created by 王奕聪 on 2017/4/19.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTDragCollectionViewCell.h"
#import "MTConst.h"

@interface MTDragCollectionViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIGestureRecognizer* dragGestureRecognizer;

@end

@implementation MTDragCollectionViewCell


-(void)setupDefault
{
    [super setupDefault];
    
    //给每个cell添加手势
    [self addGestureRecognizer:self.dragGestureRecognizer];
    self.isDragEnable = YES;
}

- (void)gestureAction:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.superview respondsToSelector:@selector(doSomeThingForMe:withOrder:withItem:)])
        [(UIView<MTDelegateProtocol>*)self.superview doSomeThingForMe:self withOrder:@"MTDragGestureOrder" withItem:gestureRecognizer];
}


-(void)setIsDragEnable:(BOOL)isDragEnable
{
    _isDragEnable = isDragEnable;
    
    self.dragGestureRecognizer.enabled = isDragEnable;
}

-(UIGestureRecognizer *)dragGestureRecognizer
{
    if(!_dragGestureRecognizer)
    {
        _dragGestureRecognizer = self.isLongPress ? [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)] : [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
        _dragGestureRecognizer.delegate = self;
    }
    
    return _dragGestureRecognizer;
}

@end
