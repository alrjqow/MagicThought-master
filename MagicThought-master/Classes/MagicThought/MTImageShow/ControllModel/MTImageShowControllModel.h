//
//  MTImageShowControllModel.h
//  QXProject
//
//  Created by monda on 2020/5/7.
//  Copyright © 2020 monda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAlertBigImageController.h"
#import "MTBigimageCellModel.h"

typedef enum : NSInteger {
    
    /**alert 的方式展示大图*/
    MTBigImageShowTypeAlert,
    
} MTBigImageShowType;

typedef enum : NSInteger {
        
    MTBigImageShowBeginTypeDefault,
    MTBigImageShowBeginTypeZoom,
    
} MTBigImageShowBeginType;

typedef enum : NSInteger {
        
    MTBigImageShowEndTypeDefault,
    MTBigImageShowEndTypeZoom,
    
} MTBigImageShowEndType;

@protocol MTImageShowControllModelProtocol<NSObject>

@optional
/**大图单击*/
-(void)bigImageSingleTap:(UITapGestureRecognizer*)tap;

/**大图双击*/
-(void)bigImageDoubleTap:(UITapGestureRecognizer*)tap;

/**大图长按*/
-(void)bigImageLongPress:(UILongPressGestureRecognizer*)longPress;

/**大图拖拽*/
-(void)bigImagePan:(UIPanGestureRecognizer*)pan WithImageView:(UIImageView*)imageView;

/**大图结束拖拽*/
-(void)bigImage:(UIImageView*)imageView EndDraggingWithDecelerate:(BOOL)decelerate;

@end

@interface MTImageShowControllModel : NSObject<MTImageShowControllModelProtocol>

@property (nonatomic,strong) NSMutableArray<UIImage*>* imageArray;

@property (nonatomic,assign) MTBigImageShowType bigImageShowType;
@property (nonatomic,assign) MTBigImageShowBeginType bigImageShowBeginType;
@property (nonatomic,assign) MTBigImageShowEndType bigImageShowEndType;

@property (nonatomic,strong) MTAlertBigImageController* bigImageController;

@property (nonatomic,strong) MTBigimageCellModel* bigimageCellModel;

@property (nonatomic,weak) id<MTImageShowControllModelProtocol> delegate;

-(void)showBigImageWithSmallImageView:(UIImageView*)imageView;

/**点击缩小退出*/
- (void)bigImageDismissView:(UIView*)view;

/**点击缩放图片*/
-(void)bigImageZoomView:(UIView*)view Location:(CGPoint)location;

/**长按保存图片*/
-(void)saveBigImage:(UIImage*)image;

/**拖拽图片*/
-(void)imageDidPan:(UIPanGestureRecognizer*)pan WithImageView:(UIImageView*)imageView;

/**保存所有图片*/
-(void)saveAllImage;

@end

