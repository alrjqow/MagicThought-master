//
//  MTPhotoServiceModel.h
//  XHProject
//
//  Created by apple on 2021/8/17.
//  Copyright © 2021 王奕聪. All rights reserved.
//

#import "MTServiceModel.h"
#import <Photos/Photos.h>


@interface MTPhotoServiceModel : MTServiceModel <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,assign) BOOL isAsc;
@property (nonatomic,assign) BOOL isOnlyImage;

@property (nonatomic,strong) NSString* photoListControllerClassName;

@property (nonatomic,assign, readonly) PHAssetMediaType actuallyAssetMediaType;
@property (nonatomic,assign, readonly) PHAssetMediaType currentAssetMediaType;
@property (nonatomic,strong) NSArray<NSNumber*>* assetMediaUITypeList;

@property (nonatomic,strong, readonly) NSString* assetMediaTypeTitle;
@property (nonatomic,strong) NSDictionary<NSNumber*, NSString*>* assetMediaTypeTitleDict;

@property (nonatomic,assign) BOOL isRetainSelectedAssetWhenMediaTypeChange;

@property (nonatomic, strong) PHFetchResult<PHAsset *> *assets;



@property (nonatomic,assign, readonly) NSInteger maxMediaCount;
@property (nonatomic,assign) NSInteger maxAssetCount;

//资源互斥的情况
@property (nonatomic,assign) BOOL isMediaTypeAgainst;
@property (nonatomic,assign) NSInteger maxImageCount;
@property (nonatomic,assign) NSInteger maxVideoCount;



@property (nonatomic,assign) NSInteger minVideoSecond;
@property (nonatomic,assign, readonly) BOOL canAdd;

@property (nonatomic,assign) BOOL isCut;
@property (nonatomic,assign) CGFloat whScale;

@property (nonatomic,strong) void (^didFinishGetImageOrAsset)(NSArray* assetArray, MTPhotoServiceModel* photoServiceModel);

@property (nonatomic,strong) void (^didFinishGetVideoPath)(AVURLAsset *urlAsset);

@property (nonatomic,strong) NSMutableArray<PHAsset*>* selectedAssetArray;

//选中与否相关逻辑
-(void)selectedAsset:(PHAsset*)asset;
-(void)disselectedAsset:(PHAsset*)asset;
-(void)clearSelectedAsset;


-(void)loadMediaWithType:(PHAssetMediaType)assetMediaType;

-(void)takePhoto;

//选择视频和图片
-(void)finishPickAsset;

-(void)show;


@end

@interface MTViewController (MTPhotoServiceModel)

-(void)createDataList;

@end
