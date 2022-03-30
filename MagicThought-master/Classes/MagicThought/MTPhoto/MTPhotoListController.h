//
//  MTPhotoListController.h
//  XHProject
//
//  Created by apple on 2021/8/17.
//  Copyright © 2021 王奕聪. All rights reserved.
//

#import "MTListController.h"
#import "MTPhotoServiceModel.h"
#import "MTBaseCollectionViewCell.h"

@interface MTPhotoListController : MTListController

@property (nonatomic,strong) MTPhotoServiceModel* photoServiceModel;

@property (nonatomic,strong, readonly) NSDictionary* photoSetupDefaultDict;

-(void)loadNavigationBar;

-(NSObject*)cameraCellData;

-(NSObject*)photoListItemCellData:(PHAsset*)asset Index:(NSInteger)index;

@end

@interface MTPhotoListItemCell : MTBaseCollectionViewCell @end


