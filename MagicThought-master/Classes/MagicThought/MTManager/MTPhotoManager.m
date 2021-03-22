//
//  MTPhotoManager.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/18.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTPhotoManager.h"
#import "NSString+Exist.h"
#import <Photos/Photos.h>

@implementation MTPhotoManager

/**
 * 根据资源id获取到图片
 */
- (void)searchAllImagesWithLocalIdentifiers:(NSArray<NSString*> *)ids CompletionHandler:(void (^) ( UIImage* _Nullable ))completionHandler
{
   // 判断授权状态
   [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      if (status != PHAuthorizationStatusAuthorized) return;
      
      dispatch_async(dispatch_get_main_queue(), ^{
         
         // 采取同步获取图片（只获得一次图片）
         PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
         imageOptions.synchronous = YES;
         
       // 遍历id获取所有图片
         PHFetchResult<PHAsset *>* result = [PHAsset fetchAssetsWithLocalIdentifiers:ids options:nil];
         
         for (PHAsset *asset in result) {
            // 过滤非图片
            if (asset.mediaType != PHAssetMediaTypeImage) continue;
            
            // 图片原尺寸
            CGSize targetSize = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
            // 请求图片
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
               
               NSLog(@"图片：%@ %@", result, [NSThread currentThread]);
               if(!result) return;
               
               completionHandler(result);
            }];
         }
      });
   }];
   
   

   
   

 
}


#pragma mark - 查询相册中的图片
/**
 * 查询所有的图片
 */
- (IBAction)searchAllImages {
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 遍历所有的自定义相册
            PHFetchResult<PHAssetCollection *> *collectionResult0 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            for (PHAssetCollection *collection in collectionResult0) {
                [self searchAllImagesInCollection:collection];
            }
            
            // 获得相机胶卷的图片
            PHFetchResult<PHAssetCollection *> *collectionResult1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            for (PHAssetCollection *collection in collectionResult1) {
                if (![collection.localizedTitle isEqualToString:@"Camera Roll"]) continue;
                [self searchAllImagesInCollection:collection];
                break;
            }
        });
    }];
}

/**
 * 查询某个相册里面的所有图片
 */
- (void)searchAllImagesInCollection:(PHAssetCollection *)collection
{
    // 采取同步获取图片（只获得一次图片）
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    
    NSLog(@"相册名字：%@", collection.localizedTitle);
    
    // 遍历这个相册中的所有图片
    PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    for (PHAsset *asset in assetResult) {
        // 过滤非图片
        if (asset.mediaType != PHAssetMediaTypeImage) continue;
        
        // 图片原尺寸
        CGSize targetSize = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        // 请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"图片：%@ %@", result, [NSThread currentThread]);
        }];
    }
}


#pragma mark - 保存图片到自定义相册
/**
 * 获得自定义的相册对象
 */
+ (PHAssetCollection *)collection:(NSString*)collectionName
{
    if(![collectionName isExist]) return nil;
    
    // 先从已存在相册中找到自定义相册对象
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:collectionName]) {
            return collection;
        }
    }
    
    // 新建自定义相册
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        NSLog(@"获取相册【%@】失败", collectionName);
        return nil;
    }
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}

/**
 * 保存图片到相册
 */
+ (void)saveImage:(UIImage*)image To:(NSString*)collectionName completion: (void (^)(NSInteger, NSString*))completion {
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            
            // 保存相片到相机胶卷
            __block PHObjectPlaceholder *createdAsset = nil;
           //资源ID
           __block NSString* localIdentifier = @"";
           
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
               
               //写入图片到相册
                PHAssetChangeRequest* req = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
               
                createdAsset = req.placeholderForCreatedAsset;
                localIdentifier = req.placeholderForCreatedAsset.localIdentifier;
            } error:&error];
            
            if (error) {
                completion(-1, localIdentifier);
                return;
            }
            
            if(![collectionName isExist])
            {
                completion(0, localIdentifier);
                return;
            }
            
            // 拿到自定义的相册对象
            PHAssetCollection *collection = [self collection:collectionName];
            if (collection == nil)
            {
                completion(0, localIdentifier);
                return;
            }
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] insertAssets:@[createdAsset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } error:&error];
            
            if (error) {
                completion(0, localIdentifier);
            } else {
                completion(1, localIdentifier);
            }
        });
    }];
}



@end
