//
//  MTAlertGetPhotoWayController.m
//  QXProject
//
//  Created by 王奕聪 on 2020/1/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTAlertGetPhotoWayController.h"
#import "NSObject+ReuseIdentifier.h"

NSString*  MTAlertGetPhotoWayCameraOrder = @"MTAlertGetPhotoWayCameraOrder_MTBaseAlertDismissOrder";
NSString*  MTAlertGetPhotoWayLibraryOrder = @"MTAlertGetPhotoWayLibraryOrder_MTBaseAlertDismissOrder";

@interface MTAlertGetPhotoWayController ()

@end

@implementation MTAlertGetPhotoWayController

#pragma mark - 代理

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath.mt_order containsString:@"MTAlertGetPhotoWayCameraOrder"])
        [self.takePhotoModel takePhotoFromCamera];
    else if([indexPath.mt_order containsString:@"MTAlertGetPhotoWayLibraryOrder"])
        [self.takePhotoModel takePhotoFromPhotoLibrary];
}

#pragma mark - 懒加载

-(MTTakePhotoModel *)takePhotoModel
{
    if(!_takePhotoModel)
    {
        MTTakePhotoModel* takePhotoModel = [MTTakePhotoModel new];
        takePhotoModel.delegate_takePhoto = self;
        
        self.takePhotoModel = takePhotoModel;
    }
    
    return _takePhotoModel;
}

-(MTBaseAlertType)type
{
    return MTBaseAlertTypeUp_DismissTwice;
}

@end
