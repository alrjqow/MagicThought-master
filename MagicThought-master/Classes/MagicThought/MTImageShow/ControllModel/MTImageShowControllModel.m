//
//  MTImageShowControllModel.m
//  QXProject
//
//  Created by monda on 2020/5/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImageShowControllModel.h"
#import "UIImage+Save.h"
#import "UIView+MTBaseViewContentModel.h"
#import "NSObject+ReuseIdentifier.h"
#import "MTViewContentModel.h"
#import "NSString+Exist.h"
#import "SDWebImageManager.h"
#import <MJExtension/MJExtension.h>
#import <Photos/Photos.h>

@interface MTImageShowControllModel ()
{
    MTAlertBigImageController* _bigImageController;
}
@property (nonatomic,strong) NSMutableDictionary<NSNumber*, UIView*>* imageViewMap;

@property (nonatomic,strong) UIImageView* beginImageView;

@end

@implementation MTImageShowControllModel

#pragma mark - 大图单击

-(void)bigImageSingleTap:(UITapGestureRecognizer*)tap
{
    if([self.delegate respondsToSelector:@selector(bigImageSingleTap:)])
    {
        [self.delegate bigImageDoubleTap:tap];
        return;
    }
        
    [self bigImageDismissView:tap.view];
}

#pragma mark - 大图拖拽

-(void)bigImagePan:(UIPanGestureRecognizer *)pan WithImageView:(UIImageView *)imageView
{
    if([self.delegate respondsToSelector:@selector(bigImagePan:WithImageView:)])
    {
        [self.delegate bigImagePan:pan WithImageView:imageView];
        return;
    }
     
    [self imageDidPan:pan WithImageView:imageView];
}

-(void)imageDidPan:(UIPanGestureRecognizer*)pan WithImageView:(UIImageView*)imageView
{
    if(![pan.view isKindOfClass:[UIScrollView class]])
        return;
                
    static CGPoint startPoint;
    static CGFloat zoomScale;
    static CGFloat startHeight;
    static CGPoint anchorPoint;
    static BOOL touchBegan;
    static BOOL canPanStart = YES;
    
    UIScrollView* scrollView = (UIScrollView*)pan.view;
    CGPoint location = [pan locationInView:pan.view];
    CGPoint touchOffset = [pan translationInView:pan.view]; //屏幕偏移量
                 
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            //                if(scrollView.contentSize.height > scrollView.height)
            if(imageView.height > scrollView.height)
            {
                if(scrollView.offsetY > 0)
                    canPanStart = false;
                else if(scrollView.decelerating)
                    canPanStart = false;
                else if([scrollView.mt_order containsString:@"isDecelerate"])
                    canPanStart = false;
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            if(!canPanStart)
                return;
//           if (location.y - startPoint.y <= 0 && !touchBegan)
            if (touchOffset.y <= 0 && !touchBegan)
               return;
           
            if(!touchBegan)
            {
                self.bigImageController.imagePlayView.scrollEnabled = false;
                scrollView.pinchGestureRecognizer.enabled = false;
                startPoint = location;
                
                CGPoint imageLocation = [pan locationInView:imageView];
                zoomScale = scrollView.zoomScale;
                if(zoomScale < 1)
                    zoomScale = 1;
                anchorPoint = CGPointMake(imageLocation.x * zoomScale / imageView.width, imageLocation.y * zoomScale / imageView.height);
                
                startHeight = (scrollView.height - kTabBarHeight_mt()) - imageView.y;
                imageView.layer.anchorPoint = anchorPoint;
                touchBegan = YES;
                scrollView.bindOrder(@"isPanDoing");
            }
                        
            imageView.layer.position = [pan locationInView:scrollView];
                        
            double percent = 1 - fabs(touchOffset.y) / (scrollView.height); // 移动距离 / 整个屏幕
            double scalePercent = zoomScale * (location.y - startPoint.y < 0 ? 1 : MAX(percent, 0.35));
                        
            CGAffineTransform scale = CGAffineTransformMakeScale(scalePercent, scalePercent);
            imageView.transform = scale;
            
            CGFloat currentHeight = (scrollView.height - kTabBarHeight_mt()) - imageView.y;
            
            self.bigImageController.blackView.alpha = currentHeight > startHeight ? 1 : (currentHeight / startHeight);
                        
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            touchBegan = false;
            canPanStart = YES;
            startPoint = CGPointZero;
            scrollView.pinchGestureRecognizer.enabled = YES;
            self.bigImageController.imagePlayView.scrollEnabled = YES;
            break;
        }
            
        default:
            break;
    }
}

/**大图开始拖拽*/
-(void)bigImageViewBeginDragging:(UIImageView*)imageView
{
    UIScrollView* scrollView = (UIScrollView*)imageView.superview;
      if(![scrollView isKindOfClass:[UIScrollView class]])
          return;
        
    if(scrollView.offsetX == 0)
        self.bigImageController.imagePlayView.scrollEnabled = false;
    else if(scrollView.offsetX < (scrollView.contentSize.width - scrollView.width))
        self.bigImageController.imagePlayView.scrollEnabled = false;
    
    if(imageView.height < scrollView.height)
        scrollView.offsetY = 0;
}

/**大图结束拖拽*/
-(void)bigImage:(UIImageView*)imageView EndDraggingWithDecelerate:(BOOL)decelerate
{
    if(!decelerate)
        self.bigImageController.imagePlayView.scrollEnabled = YES;
    if([self.delegate respondsToSelector:@selector(bigImage:EndDraggingWithDecelerate:)])
    {
        [self.delegate bigImage:imageView EndDraggingWithDecelerate:decelerate];
        return;
    }
        
    UIScrollView* scrollView = (UIScrollView*)imageView.superview;
    if(![scrollView isKindOfClass:[UIScrollView class]])
        return;
        
    if(![scrollView.mt_order containsString:@"isPanDoing"])
    {
        if(decelerate)
            scrollView.bindOrder(@"isDecelerate");
        else
            scrollView.mt_order = nil;
        return;
    }

    if(decelerate && [scrollView.panGestureRecognizer velocityInView:scrollView].y > 0)
    {
        if(scrollView.offsetY <= 0)
            [self bigImageDismissView:imageView];
    }
    else
        [self bigImageReset:imageView];
    
    scrollView.mt_order = nil;
}

-(void)bigImageViewDidEndDecelerating:(UIImageView*)imageView
{
    self.bigImageController.imagePlayView.scrollEnabled = YES;
    UIScrollView* scrollView = (UIScrollView*)imageView.superview;
       if(![scrollView isKindOfClass:[UIScrollView class]])
           return;
    if(!scrollView.tracking)
        scrollView.mt_order = nil;
}

- (void)bigImageDismissView:(UIView*)view
{
    UIScrollView* scrollView = (UIScrollView*)view.superview;
     if(![scrollView isKindOfClass:[UIScrollView class]])
         return;
        
    UIView* smallImageView = self.imageViewMap[view.baseContentModel.mt_index];

      if(!smallImageView)
      {
          [self.bigImageController dismissViewControllerAnimated:YES completion:^{
              self.bigImageController = nil;
          }];
          return;
      }
           
      [UIView animateWithDuration:self.bigimageCellModel.animateTime animations:^{
          scrollView.zoomScale = scrollView.minimumZoomScale;
          self.bigImageController.blackView.backgroundColor = [UIColor clearColor];
          view.frame = [self.bigImageController.view convertRect:smallImageView.frame fromView:smallImageView.superview];
      } completion:^(BOOL finished) {
          if(finished)
          {           
              [self.bigImageController dismissViewControllerAnimated:false completion:^{
                 
                  self.bigImageController = nil;
              }];
          }
      }];
}

-(void)bigImageReset:(UIImageView*)imageView
{
    UIScrollView* scrollView = (UIScrollView*)imageView.superview;
    if(![scrollView isKindOfClass:[UIScrollView class]])
        return;
        
    CGFloat zoomScale = scrollView.contentSize.width / scrollView.width;
    if(zoomScale < 1)
        zoomScale = 1;
    
    CGFloat centerX = scrollView.contentSize.width > scrollView.width ? scrollView.contentSize.width / 2 : scrollView.centerX;
    CGFloat centerY = scrollView.contentSize.height > scrollView.height ? scrollView.contentSize.height / 2 : scrollView.centerY;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bigImageController.blackView.alpha = 1;
        
        imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        imageView.layer.position = CGPointMake(centerX, centerY);
        imageView.transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        
    } completion:nil];
}

#pragma mark - 大图双击

-(void)bigImageDoubleTap:(UITapGestureRecognizer*)tap
{
    if([self.delegate respondsToSelector:@selector(bigImageDoubleTap:)])
    {
        [self.delegate bigImageDoubleTap:tap];
        return;
    }
    
    [self bigImageZoomView:tap.view Location:[tap locationInView:tap.view]];
}

-(void)bigImageZoomView:(UIView*)view Location:(CGPoint)location
{
    UIScrollView* scrollView = (UIScrollView*)view.superview;
    if(![scrollView isKindOfClass:[UIScrollView class]])
        return;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if(scrollView.zoomScale == scrollView.minimumZoomScale)
            [scrollView zoomToRect:[self zoomRectWithPoint:location ScrollView:scrollView] animated:false];
        else
            scrollView.zoomScale = scrollView.minimumZoomScale;
    }];
}

- (CGRect)zoomRectWithPoint:(CGPoint)point ScrollView:(UIScrollView*)scrollView
{
    CGRect zoomRect;
    
    zoomRect.size.height =scrollView.height / scrollView.maximumZoomScale;
    zoomRect.size.width  =scrollView.width / scrollView.maximumZoomScale;
    zoomRect.origin.x = point.x - zoomRect.size.width * 0.5;
    zoomRect.origin.y = point.y - zoomRect.size.height * 0.5;
    return zoomRect;
}

-(void)resizeImageViewForZooming:(UIImageView*)imageView CellSize:(NSString*)size
{
    CGSize scrollViewSize = CGSizeFromString(size);
    scrollViewSize.width -= self.bigimageCellModel.bigImageCellSpacing;
    
    CGSize imageSize = CGSizeMake(scrollViewSize.width, imageView.image.size.height / imageView.image.size.width * scrollViewSize.width);
    UIScrollView* scrollView = (UIScrollView*)imageView.superview;
         
     CGFloat contentHeight = imageSize.height * scrollView.zoomScale;
     scrollView.bounces = contentHeight > scrollViewSize.height;
     contentHeight = contentHeight > scrollViewSize.height ? contentHeight : (scrollViewSize.height + 1);
     scrollView.contentSize = CGSizeMake(scrollViewSize.width * scrollView.zoomScale, contentHeight);
     
     //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
     CGFloat xcenter = scrollView.contentSize.width > scrollViewSize.width ? scrollView.contentSize.width / 2 : scrollViewSize.width / 2;
     CGFloat ycenter = scrollView.contentSize.height > scrollViewSize.height ? scrollView.contentSize.height / 2 : scrollViewSize.height / 2;
     imageView.center = CGPointMake(xcenter, ycenter);
}

#pragma mark - 大图长按

-(void)bigImageLongPress:(UILongPressGestureRecognizer*)longPress
{    
    if([self.delegate respondsToSelector:@selector(bigImageLongPress:)])
    {
       [self.delegate bigImageLongPress:longPress];
        return;
    }
  
    if(longPress.state != UIGestureRecognizerStateBegan)
        return;
    
    UIImageView* imageView = (UIImageView*)longPress.view;
    if(![imageView isKindOfClass:[UIImageView class]])
        return;
    
    [self saveBigImage:imageView.image];
}

-(void)saveBigImage:(UIImage*)image
{
    if(!image)
        return;
            
    UIViewController* vc = mt_rootViewController();
    while (vc.presentedViewController) {vc = vc.presentedViewController;}
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[image  showMsg:@"请稍候"] saveToPhotoLibrary:^(BOOL success) {
            if(success)
                [self showSuccess:@"保存成功"];
            else
                [self showError:@"保存失败"];
        }];
    }]];
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

-(void)saveAllImage
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    if(!status)
//        return;
    
    [self showMsg:@"请稍候"];
    dispatch_group_t imageGroup = dispatch_group_create();
    
    __block NSInteger failCount = 0;
    for (UIImage* image in self.imageArray) {
        
        dispatch_group_enter(imageGroup);
        if([image isKindOfClass:[UIImage class]])
        {
            [image saveToPhotoLibrary:^(BOOL success) {
                if(!success)
                    failCount ++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(!status)
                        [self showSaveTips: failCount];
                });
            }];
        }
        else if([image isKindOfClass:[NSString class]])
        {
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:(NSString*)image] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                
                if(image)
                    [image saveToPhotoLibrary:^(BOOL success) {
                        if(!success)
                            failCount ++;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if(!status)
                                [self showSaveTips: failCount];
                        });
                    }];
                else
                {
                    failCount ++;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(!status)
                            [self showSaveTips: failCount];
                    });
                }
                dispatch_group_leave(imageGroup);
            }];
            continue;
        }
        dispatch_group_leave(imageGroup);
    }
    
    dispatch_group_notify(imageGroup, dispatch_get_main_queue(), ^{
        
        if(status)
            [self showSaveTips: failCount];
    });
}

-(void)showSaveTips:(NSInteger)failCount
{
    if(!failCount)
        [self showSuccess:@"保存成功"];
    else
    {
        if(failCount < self.imageArray.count)
            [self showCenterToast:[NSString stringWithFormat:@"%zd张图片保存失败", failCount]];
        else
            [self showError:@"保存失败"];
    }
}

#pragma mark - 点击调出大图

-(void)showBigImageWithSmallImageView:(UIImageView*)imageView
{
    switch (self.bigImageShowType) {
                    
        default:
        {
            [self showBigImage_alertWithImageView: imageView];
            break;
        }
    }
}

-(void)showBigImage_alertWithImageView:(UIImageView*)imageView
{
    if(self.bigImageController.presentingViewController)
        return;
            
    NSObject* image;
      if(imageView.baseContentModel.image && ![[imageView.baseContentModel valueForKey:@"isImageURLImage"] boolValue])
          image = imageView.baseContentModel.image;
      else if([imageView.baseContentModel.imageURL isExist])
          image = imageView.baseContentModel.imageURL;
      else if(imageView.baseContentModel.asset)
          image = imageView.baseContentModel.asset;
    
    NSUInteger index = [self.imageArray indexOfObject:(UIImage*)image];
    if(index < 0 || index >= self.imageArray.count)
        return;
              
    self.bigimageCellModel.bigImageShowIndex = imageView.baseContentModel.mt_currentIndex;
    
    switch (self.bigImageShowBeginType) {
        case MTBigImageShowBeginTypeZoom:
        {
            [self alertBigImageWithZoomSmallImageView:imageView];
            break;
        }
                        
        default:
        {
            [self alertBigImageWithZoomSmallImageView:imageView];
//            [self.bigImageController alert];
            break;
        }
    }
}

-(void)alertBigImageWithZoomSmallImageView:(UIImageView*)smallImageView
{
    if(!smallImageView.image.size.width || !smallImageView.image.size.height)
        return;
    self.beginImageView.image = smallImageView.image;
    CGRect smallImageViewRect = [self.bigImageController.view convertRect:smallImageView.frame fromView:smallImageView.superview];
    
    self.beginImageView.bounds = CGRectMake(0, 0, smallImageViewRect.size.width, smallImageViewRect.size.height);
    self.beginImageView.center = CGPointMake(smallImageViewRect.origin.x + smallImageViewRect.size.width * 0.5, smallImageViewRect.origin.y + smallImageViewRect.size.height * 0.5);
    
    self.bigImageController.blackView.backgroundColor = [UIColor clearColor];
    self.bigImageController.alertView.hidden = YES;

    CGRect beginImageBounds = CGRectMake(0, 0, self.bigImageController.alertView.width - self.bigimageCellModel.bigImageCellSpacing, smallImageView.image.size.height / smallImageView.image.size.width * (self.bigImageController.alertView.width - self.bigimageCellModel.bigImageCellSpacing));
    CGPoint beginImageCenter = CGPointMake(beginImageBounds.size.width * 0.5, 0);
    if(beginImageBounds.size.height < self.bigImageController.alertView.height)
        beginImageCenter.y = self.bigImageController.alertView.halfHeight;
    else
        beginImageCenter.y = beginImageBounds.size.height * 0.5;

    self.beginImageView.hidden = false;
    [self.bigImageController.view insertSubview:self.beginImageView belowSubview:self.bigImageController.alertView];
    
    [self.bigImageController willAlert];
    
    UIViewController* vc = mt_rootViewController();
    while (vc.presentedViewController) {vc = vc.presentedViewController;}
    
    [vc presentViewController:self.bigImageController animated:false completion:^{
        
        [self.bigImageController alertCompletion];
        
        [UIView animateWithDuration:self.bigimageCellModel.animateTime animations:^{
              
            self.bigImageController.blackView.backgroundColor = [UIColor blackColor];
            self.beginImageView.bounds = beginImageBounds;
            self.beginImageView.center = beginImageCenter;
            
            [self.bigImageController alerting];

          } completion:^(BOOL finished) {
                
                if(!finished)
                    return;
          
              self.bigImageController.alertView.hidden = false;
              self.beginImageView.hidden = YES;
              [self.bigImageController alertCompletion];
          }];
    }];
}

#pragma mark - view 与 image 绑定
-(void)removeImageViewBindWithImage:(UIImage*)image Index:(NSNumber*)index
{
    NSUInteger imageIndex = [self.imageArray indexOfObject:image];
    if(imageIndex < 0 || imageIndex >= self.imageArray.count)
        return;
    
    [self.imageViewMap removeObjectForKey:index];
}

-(void)updateImageViewMapWithImage:(UIImage*)image View:(UIView*)view
{
    NSUInteger index = [self.imageArray indexOfObject:image];
    if(index < 0 || index >= self.imageArray.count)
        return;
              
    [self.imageViewMap setObject:view forKey:view.mt_index];
}

#pragma mark - 第三方

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[MTImageShowControllModel class]])
        return keyValues;
    else if([keyValues isKindOfClass:[NSWeakReuseObject class]])
    {
        MTImageShowControllModel* model = ((NSWeakReuseObject*)keyValues).data;
        if([model isKindOfClass:[MTImageShowControllModel class]])
            return model;
    }
    
        
    return [super mj_objectWithKeyValues:keyValues context:context];
}

#pragma mark - Getter、Setter

-(NSMutableArray<UIImage *> *)imageArray
{
    if(!_imageArray)
    {
        _imageArray = [NSMutableArray array];
    }
    
    return _imageArray;
}

-(NSMutableDictionary *)imageViewMap
{
    if(!_imageViewMap)
    {
        _imageViewMap = [NSMutableDictionary dictionary];
    }
    
    return _imageViewMap;
}

-(void)setBigImageController:(MTAlertBigImageController *)bigImageController
{
    _bigImageController = bigImageController;
    bigImageController.imageShowControllModel = self;
    
    [self.beginImageView removeFromSuperview];
    self.beginImageView.hidden = YES;
}

-(MTAlertBigImageController *)bigImageController
{
    if(!_bigImageController)
    {
        self.bigImageController = [MTAlertBigImageController new];
    }
    
    return _bigImageController;
}

-(MTBigimageCellModel *)bigimageCellModel
{
    if(!_bigimageCellModel)
    {
        _bigimageCellModel = [MTBigimageCellModel new];
    }
    
    return _bigimageCellModel;
}

- (UIImageView *)beginImageView
{
    if(!_beginImageView)
    {
        _beginImageView = [UIImageView new];
        _beginImageView.contentMode = UIViewContentModeScaleAspectFill;
        _beginImageView.clipsToBounds = YES;
    }
    
    return _beginImageView;
}

@end
