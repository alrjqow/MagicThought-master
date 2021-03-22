//
//  UIImage+Save.m
//  8kqw
//
//  Created by 王奕聪 on 2017/5/17.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "UIImage+Save.h"
#import "NSData+File.h"
#import <Photos/Photos.h>

#import "NSString+Exist.h"

@implementation UIImage (Save)

+(UIImage*)imageWithPath:(NSString*)directoryPath
{
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:directoryPath]];
}

-(BOOL)saveTo:(NSString*)directoryPath Name:(NSString*)name Zip:(CGFloat)zip
{
    return [UIImageJPEGRepresentation(self, zip) writeToDirectory:directoryPath File:name atomically:YES];
}

-(BOOL)saveTo:(NSString*)directoryPath Name:(NSString*)name
{
    return [self saveTo:directoryPath Name:name Zip:1];
}

/**
 *  压缩图片到指定文件大小
 *
 *
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)compressWithMaxDataSizeMBytes:(CGFloat)size{
    
    NSData* data;
    CGFloat dataKBytes = 0.0;
    CGFloat lastDataKBytes;
    CGFloat maxQuality = 0.9f;
    
    //转成KB
    size = size * 1000;
    do
    {
        lastDataKBytes = dataKBytes;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1000.0;
        maxQuality -= 0.01f;
        
    }while (dataKBytes > size && maxQuality > 0.01f && lastDataKBytes != dataKBytes);
    
    return data;
}


/**保存到相册*/
- (void)saveToLocalPhotoLibrary:(void (^)(BOOL result))completion
{
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
                PHAssetChangeRequest* req = [PHAssetCreationRequest creationRequestForAssetFromImage:self];
                createdAsset = req.placeholderForCreatedAsset;
                localIdentifier = req.placeholderForCreatedAsset.localIdentifier;
            } error:&error];
            
            if(completion)
                completion(!error);
        });
    }];
}

@end


@implementation  UIImage(PhotoLibrary)

#pragma mark - 保存图片到自定义相册

- (void)saveToPhotoLibrary: (void (^)(BOOL success))completion {
    
    [self saveTo:nil completion:^(MTImageSaveToLibraryType imageSaveToLibraryType, NSString *localIdentifier) {
            
        if(completion)
            completion(imageSaveToLibraryType != MTImageSaveToLibraryTypeFailure);
    }];
}

/**
 * 保存图片到相册
 */
- (void)saveTo:(NSString*)collectionName completion: (void (^)(MTImageSaveToLibraryType imageSaveToLibraryType, NSString* localIdentifier))completion {
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized)
        {
            completion(MTImageSaveToLibraryTypeFailure, nil);
            return;
        }
                
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            
            // 保存相片到相机胶卷
            __block PHObjectPlaceholder *createdAsset = nil;
           //资源ID
           __block NSString* localIdentifier = @"";
           
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
               
               //写入图片到相册
                PHAssetChangeRequest* req = [PHAssetCreationRequest creationRequestForAssetFromImage:self];
               
                createdAsset = req.placeholderForCreatedAsset;
                localIdentifier = req.placeholderForCreatedAsset.localIdentifier;
            } error:&error];
            
            if (error) {
                completion(MTImageSaveToLibraryTypeFailure, localIdentifier);
                return;
            }
            
            if(![collectionName isExist])
            {
                completion(MTImageSaveToLibraryTypeSuccess, localIdentifier);
                return;
            }
            
            // 拿到自定义的相册对象
            PHAssetCollection *collection = [UIImage collection:collectionName];
            if (collection == nil)
            {
                completion(MTImageSaveToLibraryTypeSuccessButCollectionFailure, localIdentifier);
                return;
            }
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] insertAssets:@[createdAsset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } error:&error];
            
            if (error) {
                completion(MTImageSaveToLibraryTypeSuccessButCollectionFailure, localIdentifier);
            } else {
                completion(MTImageSaveToLibraryTypeSuccess, localIdentifier);
            }
        });
    }];
}

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


@end
