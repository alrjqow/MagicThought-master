//
//  MTImageShowCell.m
//  QXProject
//
//  Created by monda on 2020/5/11.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImageShowCell.h"

@interface MTImageShowCell_Big ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView* scrollView;

@property (nonatomic,strong) UITapGestureRecognizer* singleTap;
@property (nonatomic,strong) UITapGestureRecognizer* doubleTap;
@property (nonatomic,strong) UILongPressGestureRecognizer* longPress;

@end

@implementation MTImageShowCell_Big

-(void)setupDefault
{
    [super setupDefault];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:self.singleTap];
    [self.imageView addGestureRecognizer:self.doubleTap];
    [self.imageView addGestureRecognizer:self.longPress];
        
    [self.scrollView addSubview:self.imageView];
    [self addSubview:self.scrollView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.scrollView.width = self.contentView.width -  self.imageShowControllModel.bigimageCellModel.bigImageCellSpacing;
    
    if(!CGSizeEqualToSize(self.imageView.image.size, CGSizeZero))
        self.imageView.bounds = CGRectMake(0,  0, self.scrollView.width, self.imageView.image.size.height / self.imageView.image.size.width * self.scrollView.width);
    
    if(self.imageView.height <= self.scrollView.height)
        self.imageView.center = self.scrollView.center;
    else
        self.imageView.center = CGPointMake(self.scrollView.centerX, self.imageView.halfHeight);
}

#pragma mark - 单击

-(void)singleTapEvent
{
    [self.imageShowControllModel bigImageSingleTap:self.singleTap];
}

#pragma mark - 双击

-(void)doubleTapEvent
{
    [self.imageShowControllModel bigImageDoubleTap:self.doubleTap];
}

#pragma mark - 长按
-(void)longPressEvent
{
    [self.imageShowControllModel bigImageLongPress:self.longPress];
}

#pragma mark - 拖拽
-(void)panEvent
{
    [self.imageShowControllModel bigImagePan:self.scrollView.panGestureRecognizer WithImageView:self.imageView];    
}

#pragma mark - 缩放
- (void)pinchEvent
{
    switch (self.scrollView.pinchGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.scrollView.panGestureRecognizer.enabled = false;
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.scrollView.panGestureRecognizer.enabled = YES;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 代理

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.imageShowControllModel performSelector:@selector(resizeImageViewForZooming:CellSize:) withObject:self.imageView withObject:NSStringFromCGSize(self.frame.size)];
    #pragma clang diagnostic pop
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
      #pragma clang diagnostic ignored "-Wundeclared-selector"
          [self.imageShowControllModel performSelector:@selector(bigImageViewBeginDragging:) withObject:self.imageView];
      #pragma clang diagnostic pop    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.imageShowControllModel bigImage:self.imageView EndDraggingWithDecelerate:decelerate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.imageShowControllModel performSelector:@selector(bigImageViewDidEndDecelerating:) withObject:self.imageView];
    #pragma clang diagnostic pop
}

#pragma mark - Getter、Setter

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
           
    [contentModel setValue:self forKey:@"bigCell"];
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    self.scrollView.maximumZoomScale = self.imageShowControllModel.bigimageCellModel.maximumZoomScale;
    self.scrollView.panGestureRecognizer.maximumNumberOfTouches = 1;
    self.imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.imageShowControllModel performSelector:@selector(resizeImageViewForZooming:CellSize:) withObject:self.imageView withObject:NSStringFromCGSize(self.frame.size)];
#pragma clang diagnostic pop
    
    [self layoutSubviews];
}

-(Class)classOfResponseObject
{
    return [MTBigimageCellContentModel class];
}

-(MTImageShowControllModel *)imageShowControllModel
{
    return ((MTBigimageCellContentModel*)self.baseContentModel).imageShowControllModel;
}

-(UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
                        
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 1.1;
        _scrollView.delegate = self;
        
        if (@available(iOS 11.0, *))
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                
        [_scrollView.panGestureRecognizer addTarget:self action:@selector(panEvent)];
        [_scrollView.pinchGestureRecognizer addTarget:self action:@selector(pinchEvent)];
    }
    
    return _scrollView;
}

-(UILongPressGestureRecognizer *)longPress
{
    if(!_longPress)
    {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent)];
    }
    
    return _longPress;
}

-(UITapGestureRecognizer *)doubleTap
{
    if(!_doubleTap)
    {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapEvent)];
        _doubleTap.numberOfTapsRequired = 2;
    }
    
    return _doubleTap;
}

-(UITapGestureRecognizer *)singleTap
{
    if(!_singleTap)
    {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapEvent)];
        [_singleTap requireGestureRecognizerToFail:self.doubleTap];
    }
    
    return _singleTap;
}

@end
