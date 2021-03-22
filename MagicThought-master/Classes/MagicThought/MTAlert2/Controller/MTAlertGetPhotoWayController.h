//
//  MTAlertGetPhotoWayController.h
//  QXProject
//
//  Created by 王奕聪 on 2020/1/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTAlertSheetController.h"
#import "MTTakePhotoModel.h"

CG_EXTERN NSString*  MTAlertGetPhotoWayCameraOrder;
CG_EXTERN NSString*  MTAlertGetPhotoWayLibraryOrder;
@interface MTAlertGetPhotoWayController : MTAlertSheetController<MTTakePhotoModelProtocol>

/**用于实现调起拍照和相册的功能*/
@property (nonatomic,strong) MTTakePhotoModel* takePhotoModel;



@end


