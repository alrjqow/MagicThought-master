//
//  MTPhotoServiceModel.m
//  XHProject
//
//  Created by apple on 2021/8/17.
//  Copyright © 2021 王奕聪. All rights reserved.
//

#import "MTPhotoServiceModel.h"
#import "MTAuthorizationManager.h"
#import "MTTimer.h"
#import "UIViewController+Navigation.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "MTPhotoCutController.h"
#import "MTProjectArchitectureManager.h"


@interface MTPhotoServiceModel ()
{
    NSArray<NSNumber *> * _assetMediaUITypeList;
    PHAssetMediaType _actuallyAssetMediaType;
    PHAssetMediaType _currentAssetMediaType;
}

@property (nonatomic,assign) BOOL isFinishCameraPicker;

@end

@implementation MTPhotoServiceModel

-(void)show
{
    Class c = NSClassFromString(self.photoListControllerClassName);
    if(![c isSubclassOfClass:NSClassFromString(@"MTPhotoListController")])
        c = NSClassFromString(@"MTPhotoListController");
        
    UIViewController* photoListController = c.new;
    [photoListController setWithObject:self];
    [photoListController pushWithAnimate];
}

#pragma mark - 选取视频加图片
-(void)finishPickAsset
{
    if(self.actuallyAssetMediaType == PHAssetMediaTypeImage)
    {
        [self finishPickImage];
        return;
    }
    
    if(self.actuallyAssetMediaType == PHAssetMediaTypeVideo)
    {
        [self finishPickVideo];
        return;
    }
            
    if(self.didFinishGetImageOrAsset)
        self.didFinishGetImageOrAsset([self.selectedAssetArray copy], self);
    
    [self.controller goBack];
}


#pragma mark - 选取视频

-(void)finishPickVideo
{
    NSMutableArray<PHAsset*>* videoArray = NSMutableArray.new;
    
    for (PHAsset* asset in self.selectedAssetArray)
        if(asset.mediaType == PHAssetMediaTypeVideo)
            [videoArray addObject:asset];
    
    if(self.didFinishGetImageOrAsset)
        self.didFinishGetImageOrAsset([videoArray copy], self);
    
    if(self.didFinishGetVideoPath && videoArray.firstObject)
    {
        if(videoArray.firstObject.duration < self.minVideoSecond)
        {            
            [self.controller showCenterToast:[NSString stringWithFormat:@"视频时长低于%zd秒", self.minVideoSecond]];
            return;
        }
//        NSArray<PHAssetResource *> * assetResourceArray = [PHAssetResource assetResourcesForAsset:videoArray.firstObject];
//        NSString* tailFileName = [assetResourceArray.firstObject.originalFilename componentsSeparatedByString:@"."].lastObject;
                
        [[PHImageManager defaultManager] requestExportSessionForVideo:videoArray.firstObject options:nil exportPreset:AVAssetExportPresetMediumQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
                        
            NSString* videoPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", [MTTimer getTimeWithDate:[NSDate date] Format:@"yyyyMMddHHmmss"]]];
            
            exportSession.outputURL = [NSURL fileURLWithPath:videoPath];
            exportSession.shouldOptimizeForNetworkUse = YES;
            exportSession.outputFileType = AVFileTypeMPEG4;
            
            [self showMsg:nil];
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (exportSession.status) {
                        case AVAssetExportSessionStatusFailed:
                        {
                            [self showCenterToast:@"导出失败"];
                            break;
                        }
                        case AVAssetExportSessionStatusWaiting:
                        {
                            NSLog(@"等待中");
                            break;
                        }
                        case AVAssetExportSessionStatusExporting:
                        {
                            NSLog(@"导出中");
                            break;
                        }
                        case AVAssetExportSessionStatusCompleted:
                        {
                            NSLog(@"导出完成");
                                                                                    
                            [self dismissIndicator];
                            self.didFinishGetVideoPath([AVURLAsset assetWithURL:exportSession.outputURL]);
                            break;
                        }
                        case AVAssetExportSessionStatusCancelled:
                        {
                            NSLog(@"导出取消");
                            [self dismissIndicator];
                            break;
                        }
                            
                        default:
                            break;
                    }
                });
            }];
        }];
    }
    
    [self.controller goBack];
}

#pragma mark - 根据资源生成图片

-(void)finishPickImage
{
    [self.controller showNoMsg];
    
    static NSInteger count;
    count = 0;
    
    NSMutableArray* imageArray = [self.selectedAssetArray mutableCopy];
    
    for (PHAsset* asset in self.selectedAssetArray)
    {
        NSInteger index = [self.selectedAssetArray indexOfObject:asset];
        [self getImageWithAsset:asset Completion:^(UIImage * image) {
            
            if(count < 0)
                return;
            
            if(image)
            {
                if([imageArray[index] isKindOfClass:[PHAsset class]])
                    count++;
                imageArray[index] = image;
            }
            if(count >= self.selectedAssetArray.count)
            {
                [self didFinishGetImage:imageArray];
                count = -1;
            }
        }];
    }
}

-(void)getImageWithAsset:(PHAsset*)asset Completion:(void (^)(UIImage*))completion
{
    CGFloat scale = [UIScreen mainScreen].scale;
    scale = 1;
    CGFloat kW = kScreenWidth_mt() * scale;
    CGFloat kH = kScreenHeight_mt() * scale;
    CGFloat imgWidth = asset.pixelWidth;
    CGFloat imgHeight = asset.pixelHeight;
    CGSize size = CGSizeZero;
    
    PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    if(imgWidth < kW && imgHeight < kH)
        size = CGSizeMake(imgWidth, imgHeight);
    
    if(imgWidth < kW && imgHeight > kH)
        size = CGSizeMake(kW, kW * imgHeight / imgWidth);
    
    if(imgWidth > kW && imgHeight < kH)
        size = CGSizeMake(kW, kW * imgHeight / imgWidth);
    
    if(imgWidth > kW && imgHeight > kH)
    {
        if(imgWidth > imgHeight)
        {
            CGFloat targetHeight = half(kH);
            size = CGSizeMake(targetHeight * imgWidth / imgHeight, targetHeight);
        }
        else
            size = CGSizeMake(kW, kW * imgHeight / imgWidth);
    }
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if(completion)
            completion(result);
        
    }];
}

-(void)didFinishGetImage:(NSMutableArray*)imageArray
{
    NSMutableArray* newImageArray = [imageArray mutableCopy];
    
    for (UIImage* image in imageArray) {
        if(![image isKindOfClass:[UIImage class]])
            [newImageArray removeObject:image];
    }
    
    [self.controller dismissIndicator];
    
    NSArray* finalImageArray = [imageArray copy];
    
    if(self.isCut)
    {
        MTPhotoCutController* photoCutController = MTPhotoCutController.new;
        photoCutController.whScale = self.whScale;
        photoCutController.imageArray = finalImageArray;
        
        __weak typeof(self) weakSelf = self;
        photoCutController.didFinishGetImage = ^(NSArray<UIImage *> *imageArray) {
            
            if(weakSelf.didFinishGetImageOrAsset)
                weakSelf.didFinishGetImageOrAsset(imageArray, self);
                        
            if(weakSelf.controller.navigationController.presentingViewController)
                [weakSelf.controller.navigationController dismissViewControllerAnimated:YES completion:nil];
            else
            {
                NSInteger index = [weakSelf.controller.navigationController.viewControllers indexOfObject:weakSelf.controller] - 1;
                
                UIViewController* viewController = (index < weakSelf.controller.navigationController.viewControllers.count && index >= 0) ? weakSelf.controller.navigationController.viewControllers[index] : weakSelf.controller;
                                
                [weakSelf.controller.navigationController popToViewController:viewController animated:YES];
            }
        };
            
        [photoCutController pushWithAnimate];
        return;
    }
        
    [self.controller goBack];
    if(self.didFinishGetImageOrAsset)
        self.didFinishGetImageOrAsset(finalImageArray, self);
}

#pragma mark - 处理选中资源逻辑

-(void)selectedAsset:(PHAsset*)asset
{
    NSInteger assetIndex = [self.assets indexOfObject:asset];
    if(assetIndex < 0 || assetIndex >= self.assets.count)
        return;
    
    [self.selectedAssetArray addObject:asset];
}

-(void)disselectedAsset:(PHAsset*)asset
{
    [self.selectedAssetArray removeObject:asset];
}

-(void)clearSelectedAsset
{
    [self.selectedAssetArray removeAllObjects];
}

#pragma mark - 获取资源

-(void)loadData
{
    [self loadMediaWithType:self.currentAssetMediaType];
}

-(void)loadMediaWithType:(PHAssetMediaType)assetMediaType
{
    if(![MTAuthorizationManager haveAuthorizationWith:MTAuthorizationTypePhoto])
    {
        [self.controller showCenterToast:@"请前往设置开启访问相册权限"];
        return;
    }
     
    _currentAssetMediaType = assetMediaType;
    
    PHFetchResult<PHAssetCollection *> *cameraRolls = [PHAssetCollection fetchAssetCollectionsWithType: PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    PHFetchOptions* option = PHFetchOptions.new;
    if(self.currentAssetMediaType)
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", assetMediaType];
    self.assets = [PHAsset fetchAssetsInAssetCollection:cameraRolls.firstObject options:option];
    
    
    if(self.isFinishCameraPicker)
    {
        [self selectedAsset:self.assets.lastObject];
        self.isFinishCameraPicker = false;
    }
    else if(!self.isRetainSelectedAssetWhenMediaTypeChange)
        [self.selectedAssetArray removeAllObjects];
    else
    {
        NSMutableDictionary<NSString*, NSNumber*>* selectedAssetMap = NSMutableDictionary.new;
        for (PHAsset* asset in self.selectedAssetArray)
            selectedAssetMap[asset.localIdentifier] = @([self.selectedAssetArray indexOfObject:asset]);
                
        for (PHAsset* asset in self.assets) {
            
            NSNumber* index = selectedAssetMap[asset.localIdentifier];
            if(index)
                self.selectedAssetArray[index.integerValue] = asset;
        }
    }
    
    [self.controller createDataList];
}

//拍照
-(void)takePhoto
{
    if(![MTAuthorizationManager haveAuthorizationWith:MTAuthorizationTypeCamera])
    {
        [self.controller showCenterToast:@"请前往设置开启访问相机权限"];
        return;
    }
        
    
    UIImagePickerController* pickerController = UIImagePickerController.new;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    if(!self.currentAssetMediaType)
    {
        pickerController.mediaTypes=@[(NSString *)kUTTypeMovie, (NSString*)kUTTypeImage];
        pickerController.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
    }
    
    //    pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    pickerController.delegate = self;
    
    [self.controller presentFullScreenViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = info[UIImagePickerControllerMediaType];
    if([type isEqualToString: (NSString*)kUTTypeImage])
    {
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        return;
    }
    
    if([type isEqualToString:(NSString *)kUTTypeMovie])
    {
        UISaveVideoAtPathToSavedPhotosAlbum([info[UIImagePickerControllerMediaURL] path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        
        return;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
        return;
    
    self.isFinishCameraPicker = YES;
     
    [self loadData];    
    [self.controller loadData];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
        return;
    
    self.isFinishCameraPicker = YES;
    
    [self loadData];
    [self.controller loadData];
}

#pragma mark - getter、setter

-(NSMutableArray<PHAsset *> *)selectedAssetArray
{
    if(!_selectedAssetArray)
    {
        _selectedAssetArray = NSMutableArray.new;
    }
    
    return _selectedAssetArray;
}

-(NSString *)assetMediaTypeTitle{
    return self.assetMediaTypeTitleDict[@(self.currentAssetMediaType)] ? self.assetMediaTypeTitleDict[@(self.currentAssetMediaType)] : @"";
}

-(void)setAssetMediaUITypeList:(NSArray<NSNumber *> *)assetMediaUITypeList
{
    _assetMediaUITypeList = assetMediaUITypeList;
    
    _currentAssetMediaType = assetMediaUITypeList.firstObject.integerValue;
    
    BOOL isImage = false;
    BOOL isVideo = false;
    BOOL isAudio = false;
    
    for (NSNumber * assetMediaType in assetMediaUITypeList) {
        
        if(assetMediaType.integerValue == PHAssetMediaTypeImage)
            isImage = YES;
        if(assetMediaType.integerValue == PHAssetMediaTypeVideo)
            isVideo = YES;
        if(assetMediaType.integerValue == PHAssetMediaTypeAudio)
            isAudio = YES;
    }
        
    if(isImage && !isVideo && !isAudio)
        _actuallyAssetMediaType = PHAssetMediaTypeImage;
    else if(isVideo && !isImage && !isAudio)
        _actuallyAssetMediaType = PHAssetMediaTypeVideo;
    else
        _actuallyAssetMediaType = PHAssetMediaTypeUnknown;
}

-(NSArray<NSNumber *> *)assetMediaUITypeList
{
    if(!_assetMediaUITypeList)
    {
        _assetMediaUITypeList = @[];
    }
    
    return _assetMediaUITypeList;
}

-(PHAssetMediaType)actuallyAssetMediaType
{
    return self.isOnlyImage ? PHAssetMediaTypeImage : _actuallyAssetMediaType;
}

-(PHAssetMediaType)currentAssetMediaType
{
    return (self.isMediaTypeAgainst && self.selectedAssetArray.count) ? self.selectedAssetArray.firstObject.mediaType : self.isOnlyImage ? PHAssetMediaTypeImage : _actuallyAssetMediaType;
}

-(NSInteger)maxMediaCount
{
    if(self.isMediaTypeAgainst)
        return self.currentAssetMediaType == PHAssetMediaTypeImage ? self.maxImageCount : self.currentAssetMediaType == PHAssetMediaTypeVideo ? self.maxVideoCount : self.maxAssetCount;
            
    return self.maxAssetCount;
}

-(BOOL)canAdd{
        
    return self.maxMediaCount ? (self.selectedAssetArray.count < self.maxMediaCount) : YES;
}

-(NSString *)photoListControllerClassName
{
    return _photoListControllerClassName ? _photoListControllerClassName : kArchitectureManager_mt.basePhotoListControllerClassName;
}

@end


@implementation MTViewController (MTPhotoServiceModel)

-(void)createDataList{}

@end
