//
//  MTTakePhotoModel.m
//  QXProject
//
//  Created by 王奕聪 on 2020/1/6.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTTakePhotoModel.h"

#import "TZImagePickerController.h"
#import "TZImageManager.h"

#import "MTConst.h"
#import "NSObject+ReuseIdentifier.h"
#import "NSObject+CommonProtocol.h"


@interface MTTakePhotoModel ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@end

@implementation MTTakePhotoModel

-(instancetype)init
{
    if(self = [super init])
    {
        [self setupDefault];
    }
    
    return self;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.photoMaxAddingCount = MAXFLOAT;
    self.photoDisplayColumnCount_library = 4;
}

#pragma mark - modal 相机和相册
-(void)presentTakePhotoController:(UIViewController*)takePhotoController
{
    takePhotoController.modalPresentationStyle = UIModalPresentationFullScreen;
    UIViewController* vc = mt_rootViewController();
    while (vc.presentedViewController) {vc = vc.presentedViewController;}
    
    [vc presentViewController:takePhotoController animated:YES completion:nil];
    if([vc isKindOfClass:NSClassFromString(@"MTAlertGetPhotoWayController")])
    {
        takePhotoController.bindClick(^(id  _Nullable object) {
            if(vc.mt_click)
                vc.mt_click(nil);
            [vc performSelector:@selector(dismiss)];            
        });        
    }
}

#pragma mark - 拍照

-(void)takePhotoFromCamera
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus && authStatus != AVAuthorizationStatusAuthorized)
    {
        if([self.delegate_takePhoto respondsToSelector:@selector(whenCameraAuthorizationStatusNotOk)])
            [self.delegate_takePhoto whenCameraAuthorizationStatusNotOk];
        NSLog(@"未授权");
        return;
    }
        
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"相机不可用");
        return;
    }
        
    
    //这里先调用临时变量，而不调用持续占有的成员变量
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if (@available(iOS 8.0, *))
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    [self presentTakePhotoController:imagePicker];
}

#pragma mark - 相册

- (void)takePhotoFromPhotoLibrary
{
    [self takePhotoFromPhotoLibraryWith:false];
}

-(void)takePhotoFromPhotoLibraryWithCamera
{
    [self takePhotoFromPhotoLibraryWith:YES];
}

-(void)takePhotoFromPhotoLibraryWith:(BOOL)allowCamera
{
    [[TZImageManager manager].assetIdentifierDict removeAllObjects];
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.photoMaxAddingCount columnNumber:self.photoDisplayColumnCount_library delegate:nil pushPhotoPickerVc:YES];
        //    imagePickerVc.allowPickingImage = false;
        imagePickerVc.allowTakeVideo = false;
        imagePickerVc.allowTakePicture = allowCamera;
                    
        __weak typeof(imagePickerVc) weakImagePickerVc = imagePickerVc;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto)
         {
    //         NSLog(@"%@",NSStringFromCGSize(photos.firstObject.size));
            [self.photoArray addObjectsFromArray:photos];
            if(weakImagePickerVc.mt_click)
                weakImagePickerVc.mt_click(nil);
         }];
        
        [imagePickerVc setImagePickerControllerDidCancelHandle:^{
            
            if(weakImagePickerVc.mt_click)
                weakImagePickerVc.mt_click(nil);
        }];
                                 
    [self presentTakePhotoController:imagePickerVc];
}

#pragma mark - 代理

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(picker.mt_click)
        picker.mt_click(nil);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (![type isEqualToString:@"public.image"])
        return;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.photoArray addObject:image];
    if(picker.mt_click)
        picker.mt_click(nil);
}


#pragma mark - 懒加载

-(NSMutableArray *)photoArray
{
    if(!_photoArray)
    {
        _photoArray = [NSMutableArray array];
    }
    
    return _photoArray;
}

@end
