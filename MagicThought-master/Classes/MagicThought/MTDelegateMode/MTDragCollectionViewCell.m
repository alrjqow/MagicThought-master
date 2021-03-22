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

@property (nonatomic,strong) UIPanGestureRecognizer* pan;

@end

@implementation MTDragCollectionViewCell


-(void)setupDefault
{
    [super setupDefault];
    
    //给每个cell添加一个长按手势
    UIPanGestureRecognizer * longPress =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    self.pan = longPress;
    
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
    
    self.pan.enabled = isDragEnable;
}


@end
