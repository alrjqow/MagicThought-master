//
//  MTTakePhotoModel.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTTakePhotoModelProtocol <NSObject>

@optional
/**当没有授权时*/
-(void)whenCameraAuthorizationStatusNotOk;

@end

@interface MTTakePhotoModel : NSObject

/**图片数组*/
@property (nonatomic,strong) NSMutableArray<UIImage*>* photoArray;

/**用于作UI交互*/
@property (nonatomic,weak) id<MTTakePhotoModelProtocol> delegate_takePhoto;

/**最大添加图片数*/
@property(nonatomic,assign) CGFloat photoMaxAddingCount;

/**展示列数*/
@property(nonatomic,assign) NSInteger photoDisplayColumnCount_library;


/**拍照*/
-(void)takePhotoFromCamera;
/**照片库*/
-(void)takePhotoFromPhotoLibrary;
-(void)takePhotoFromPhotoLibraryWithCamera;

@end

