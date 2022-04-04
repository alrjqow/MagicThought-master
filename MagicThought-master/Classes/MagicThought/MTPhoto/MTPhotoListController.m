//
//  MTPhotoListController.m
//  XHProject
//
//  Created by apple on 2021/8/17.
//  Copyright © 2021 王奕聪. All rights reserved.
//
NSString *const kMTPhotoListCameraCell = @"MTPhotoListCameraCell";

#import "MTPhotoListController.h"
#import "MTImageShowControllModel.h"
#import "MTSetupDefaultModel.h"
#import "MTLayoutButton.h"
#import "MTConst.h"
#import "MTContentModelPropertyConst.h"
#import "MTTimer.h"
#import "NSObject+ReuseIdentifier.h"
#import "MTImageShowViewContentModel.h"
#import "MTPopTipServiceModel.h"


@interface MTPhotoListController ()

@property (nonatomic,strong) MTPopTipServiceModel* popTipServiceModel;

@property (nonatomic,strong) MTImageShowControllModel* imageShowControllModel;

propertyBool(isSelfNavigationBar)

@property (nonatomic,strong) NSArray* photoDataList;

@end

@implementation MTPhotoListController

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:MTPhotoServiceModel.class])
    {
        self.photoServiceModel = (id) obj;
        [self.photoServiceModel setWithObject:self];
    }
    
    return [super setWithObject:obj];
}

-(void)setupDefault
{
    [super setupDefault];
    
    __weak typeof(self) weakSelf = self;
        
    self.bindNotification(UIApplicationDidBecomeActiveNotification).whenReceiveNotification(^(NSNotification * _Nonnull notification) {
        
        [weakSelf.photoServiceModel loadData];
        [weakSelf loadData];
    });
    
    [self.photoServiceModel loadData];
}

-(void)setupSubview
{
    [super setupSubview];
    
    if(self.isSelfNavigationBar)
    {
        __weak __typeof(self) weakSelf = self;
        self.navigationBar.button3.bindClick(^(id  _Nullable object) {
            
            if(weakSelf.photoServiceModel.actuallyAssetMediaType)
                [weakSelf goBack];
            else
                [weakSelf.popTipServiceModel showPopTips];
        });
    }
}

-(void)navigationBarRightBtnClick
{
    [self.photoServiceModel finishPickAsset];
}

-(void)createDataList
{
    __weak __typeof(self) weakSelf = self;
    
    NSMutableArray* array = NSMutableArray.new;
    
    [array addObject:
     [self cameraCellData]
     .bindClick(^(NSIndexPath* indexPath){
    
        [weakSelf.photoServiceModel takePhoto];
    })];
            
    [self.imageShowControllModel.imageArray removeAllObjects];
    for (NSInteger index = self.photoServiceModel.isAsc ? 0 : self.photoServiceModel.assets.count - 1; self.photoServiceModel.isAsc ? index < self.photoServiceModel.assets.count : index >= 0; self.photoServiceModel.isAsc ? index ++ : index --) {
        
        PHAsset* asset = self.photoServiceModel.assets[index];
            
        [array addObject:[self photoListItemCellData:asset Index:index]];
                
        [self.imageShowControllModel.imageArray addObject: (id) asset];
    }
    
    self.photoDataList = array;
}

-(NSObject *)cameraCellData
{return mt_empty().bindAutomaticDimensionBaseCollectionCell(kMTPhotoListCameraCell);}

-(NSObject*)photoListItemCellData:(PHAsset*)asset Index:(NSInteger)index
{
    __weak __typeof(self) weakSelf = self;
    
    NSInteger duration = asset.duration;
    NSTimeInterval durationValue;
    if(asset.duration - duration > 0.5)
        durationValue = ceil(asset.duration);
    else
        durationValue = floor(asset.duration);
    
    NSInteger selectedIndex = [self.photoServiceModel.selectedAssetArray indexOfObject:asset];    
    NSInteger buttonViewState = (selectedIndex >= 0 && selectedIndex < self.photoServiceModel.assets.count) ? kSelectedForever : kDefaultForever;
        
    return @{
        
        kTitle : mt_content(
                            mt_hidden(!asset.duration),
                            [MTTimer getTimeWithDate:[NSDate dateWithTimeIntervalSince1970:durationValue] Format:@"mm:ss"]
                            ),
        
        kImg : mt_imageShowContent(
                                   asset,
                                   mt_bind.bindIndex((self.photoServiceModel.assets.count - 1) - index),
                                   self.imageShowControllModel
                                   ),
                    
        kContent : mt_stateContent(
                                   mt_hidden(false),
                                   @(buttonViewState), buttonViewState == kSelectedForever ? @(selectedIndex + 1).stringValue : @""
                                   )
    }
        .bindAutomaticDimension(@"MTPhotoListItemCell")
        .bindClick(^(NSIndexPath* indexPath){
            
            if(![indexPath.mt_order isEqualToString:kBtnTitle])
                return;
            
            [weakSelf buttonSelected:asset Index:indexPath.row];
        });
}

-(void)buttonSelected:(PHAsset*)clickAsset Index:(NSInteger)index
{
    NSDictionary* data = self.photoDataList[index];
    MTBaseViewContentModel* btnTitleModel = data[kContent];
    if(btnTitleModel.viewState == kDefaultForever)
    {
        if(!self.photoServiceModel.canAdd)
            return;
        [self.photoServiceModel selectedAsset:clickAsset];
                
        btnTitleModel.viewState = kSelectedForever;
        btnTitleModel.text = @(self.photoServiceModel.selectedAssetArray.count).stringValue;
    }
    else
    {
        NSInteger startIndex = [self.photoServiceModel.selectedAssetArray indexOfObject:clickAsset];
        
        [self.photoServiceModel disselectedAsset:clickAsset];
                        
        btnTitleModel.viewState = kDefaultForever;
        btnTitleModel.text = @"";
        
        if(startIndex < self.photoServiceModel.selectedAssetArray.count)
        {
            for (; startIndex < self.photoServiceModel.selectedAssetArray.count; startIndex ++) {
                
                NSInteger assetIndex = [self.photoServiceModel.assets indexOfObject:self.photoServiceModel.selectedAssetArray[startIndex]];
                
                NSInteger showIndex = self.photoServiceModel.isAsc ? (assetIndex + 1) : ((self.photoServiceModel.assets.count - 1) - assetIndex + 1);
                
                btnTitleModel = self.photoDataList[showIndex][kContent];
                btnTitleModel.text = @(startIndex + 1).stringValue;
            }
        }
    }
        
    if(self.photoServiceModel.isMediaTypeAgainst && (self.photoServiceModel.selectedAssetArray.count == 1 || self.photoServiceModel.selectedAssetArray.count == 0))
    {
        for (NSInteger index = self.photoServiceModel.isAsc ? 0 : self.photoServiceModel.assets.count - 1; self.photoServiceModel.isAsc ? index < self.photoServiceModel.assets.count : index >= 0; self.photoServiceModel.isAsc ? index ++ : index --) {
                                 
            PHAsset* asset =
            self.photoServiceModel.assets[index];
            
            NSDictionary* itemData = self.photoDataList[self.photoServiceModel.isAsc ? (index + 1) : (self.photoServiceModel.assets.count - index)];
   
            BOOL isDisable = self.photoServiceModel.selectedAssetArray.count && self.photoServiceModel.currentAssetMediaType != asset.mediaType;
            
            MTBaseViewContentModel* baseViewContentModel = (id) itemData[kContent];
            baseViewContentModel.isHidden = @(isDisable);
            
            baseViewContentModel = (id) itemData[kBtnTitle];
            baseViewContentModel.isHidden = @(isDisable);
            
            baseViewContentModel = (id) itemData[kImg];
            baseViewContentModel.userInteractionEnabled = @(!isDisable);
        }
    }
    
    [self loadData];
}

-(void)loadNavigationBar
{
    if(self.isSelfNavigationBar)
        self.navigationBar.objects(@{
            kBtnTitle2 : mt_stateContent(
            @(self.photoServiceModel.selectedAssetArray.count ? kDefaultForever : kDisabled),
            [NSString stringWithFormat:@"完成%@", self.photoServiceModel.selectedAssetArray.count ?
             [NSString stringWithFormat:@"(%zd/%@)", self.photoServiceModel.selectedAssetArray.count, self.photoServiceModel.maxMediaCount ? @(self.photoServiceModel.maxMediaCount).stringValue : @"∞"] : @""]
            ),
            
            kBtnTitle3 : mt_content(
            self.photoServiceModel.assetMediaTypeTitle,
            self.photoServiceModel.actuallyAssetMediaType ? UIImage.new : kImageInBundle(@"MTPhoto.bundle/arrowBottom", @"MTPhotoListController")
            )
        });
}

-(void)loadData
{
    [self loadNavigationBar];
    [super loadData];
}

-(NSArray *)dataList
{
    return self.photoDataList;
}

-(NSArray *)sectionList
{
    return @[    
        mt_empty().bindSpacing(mt_collectionViewSpacingMake(8, 8, UIEdgeInsetsMake(10, 16, 0, 16)))
    ];
}

-(NSDictionary *)setupDefaultDict
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:self.photoSetupDefaultDict];
    
    if(!dict[kMTPhotoListCameraCell])
        dict[kMTPhotoListCameraCell] =     mt_BaseCellDefaultModelMake(^(MTBaseCollectionViewCell* cell) {
            
            cell.defaultViewContent(hex(0x5D5D5D));
            
            cell.imageView.defaultViewContent(kImageInBundle(@"MTPhoto.bundle/camera", @"MTPhotoListController"));
            
        }, ^CGSize(MTBaseCollectionViewCell* cell, CGFloat contentWidth, CGFloat contentHeight) {
            
            contentWidth = (kScreenWidth_mt() - doubles(16) - doubles(8)) / 3;
            contentHeight = contentWidth;
            
            [cell.imageView sizeToFit];
            cell.imageView.center = CGPointMake(half(contentWidth), half(contentHeight));
            
            return CGSizeMake(contentWidth, contentHeight);
            
        }, ^(id object, MTViewContentModel *contentModel) {
            
        });
    
    return dict;
}

-(NSDictionary *)photoSetupDefaultDict{return @{};}

-(MTPhotoServiceModel *)photoServiceModel
{
    if(!_photoServiceModel)
    {
        _photoServiceModel = MTPhotoServiceModel.new(self);
        _photoServiceModel.assetMediaTypeTitleDict = @{
            @(PHAssetMediaTypeImage) : @"图片",
            @(PHAssetMediaTypeVideo) : @"视频",
            @(PHAssetMediaTypeUnknown) : @"图片和视频",
        };
    }
    
    return _photoServiceModel;
}

-(MTPopTipServiceModel *)popTipServiceModel
{
    if(!_popTipServiceModel)
    {
        __weak typeof(self) weakSelf = self;

        _popTipServiceModel = MTPopTipServiceModel.new(self);
        _popTipServiceModel.popViewSize = CGSizeMake(120, 200);
        _popTipServiceModel.fromRect = [self.navigationBar convertRect:self.navigationBar.button3.frame toView:self.view];

//        _popTipServiceModel.popTip.offset = -6;

        _popTipServiceModel.dataList = (NSArray*)@[

            @{
                kTitle : mt_content(@"图片")
            },
            @{
                kTitle : mt_content(@"视频")
            },
            @{
                kTitle : mt_content(@"图片和视频")
            },
        ]
        .bind(@"XHTextPopTipCell")
        .automaticDimension()
        .bindClick(^(NSIndexPath* indexPath){
            
            if(indexPath.row == 0)
                [weakSelf.photoServiceModel loadMediaWithType:PHAssetMediaTypeImage];
            else if(indexPath.row == 1)
                [weakSelf.photoServiceModel loadMediaWithType:PHAssetMediaTypeVideo];
            else if(indexPath.row == 2)
                [weakSelf.photoServiceModel loadMediaWithType:PHAssetMediaTypeUnknown];
                            
            [weakSelf loadData];
            [weakSelf.popTipServiceModel dismissPopTips];
        });
    }

    return _popTipServiceModel;
}

-(MTImageShowControllModel *)imageShowControllModel
{
    if(!_imageShowControllModel)
    {
        _imageShowControllModel = MTImageShowControllModel.new;
    }
    
    return _imageShowControllModel;
}

-(NSObject *)navigationBarSetupDefaultModel
{
    self.isSelfNavigationBar = YES;
    return mt_BaseCellDefaultModelMake(^(MTNavigationBar* navigationBar) {
        
        navigationBar.button2.defaultViewStateContent(
                                             @(kDisabled),
                                             mt_WordStyleMake(16, @"完成", [UIColor whiteColor]).bold(YES),
                                             mt_BorderStyleMake(0, 10, nil).fill(hex(0xFA6521)),
                                             mt_disabledContent(
                                                                mt_WordStyleMake(16, @"完成", hex(0xC1C1C1)).bold(YES),
                                                                mt_BorderStyleMake(0, 10, nil).fill(hex(0xEEEEEE)),
                                                                )
                                             );
        
        MTLayoutImageInRightButton* button = MTLayoutImageInRightButton.new;
        button.xImageSpacing = 7;
        navigationBar.button3 = button;
        
        navigationBar.button3.defaultViewContent(
                                                 kImageInBundle(@"MTPhoto.bundle/arrowBottom", @"MTPhotoListController"),
                                        mt_WordStyleMake(16, @"图片和视频", [UIColor blackColor]).bold(YES)
                                        );
        
    }, ^CGSize(MTNavigationBar* navigationBar, CGFloat contentWidth, CGFloat contentHeight) {
        
        [navigationBar.button2 sizeToFit];
        navigationBar.button2.height = 33;
        if(navigationBar.button2.width + doubles(12) < 56)
            navigationBar.button2.width = 56;
        else
            navigationBar.button2.width += doubles(7);
        
        if(navigationBar.button2.width < 56)
            navigationBar.button2.width = 56;
            
        navigationBar.button2.maxX = contentWidth - 16;
        
        [navigationBar.button3 sizeToFit];
        navigationBar.button3.centerY = navigationBar.button2.centerY;
        navigationBar.button3.x = navigationBar.button.maxX;
        
        return CGSizeMake(contentWidth, contentHeight);
        
    }, ^(id object, MTViewContentModel *contentModel) {
                
    });
}

@end


@interface MTPhotoListItemCell ()

@property (nonatomic,assign) CGFloat contentWidth;

@property (nonatomic,strong) CALayer* imageViewLayer;

@end

@implementation MTPhotoListItemCell


-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
        
    [self setNeedsLayout];
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.contentWidth = (kScreenWidth_mt() - doubles(16) - doubles(8)) / 3;
    
    self.imageView.defaultViewContent();
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.bindSize(CGSizeMake(self.contentWidth, 0));
    
    self.imageViewLayer = CALayer.new;
    self.imageViewLayer.backgroundColor = hexa(0x000000, 0.6).CGColor;
    self.imageViewLayer.speed = MAXFLOAT;
    [self.imageView.layer addSublayer:self.imageViewLayer];
        
    
    self.detailTextLabel.defaultViewStateContent(
                                        @(kDefaultForever),
                                        mt_BorderStyleMake(1, 12, [UIColor whiteColor]).fill([UIColor clearColor]),
                                        mt_WordStyleMake(16, nil, [UIColor whiteColor]).bold(YES).horizontalAlignment(NSTextAlignmentCenter),
                                        mt_selectedContent(mt_BorderStyleMake(0, 12, nil).fill(hex(0xFA6521)))
                                        );
    
    self.textLabel.defaultViewContent(
                                      mt_WordStyleMake(12, nil, [UIColor whiteColor]).bold(YES)
                                      );
    
    self.imageView2.defaultViewContent(
                                       kImageInBundle(@"MTPhoto.bundle/video", @"MTPhotoListController")
                                       );
    
    self.button.defaultViewContent();
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    contentWidth = self.contentWidth;
    contentHeight = contentWidth;
    
    self.imageView.frame = CGRectMake(0, 0, contentWidth, contentHeight);
    self.imageViewLayer.frame = self.imageView.bounds;
        
    self.imageViewLayer.hidden = self.detailTextLabel.viewState != kSelectedForever && !self.detailTextLabel.hidden;
    
    self.detailTextLabel.bounds = CGRectMake(0, 0, 24, 24);
    self.detailTextLabel.y = 8;
    
    [self.textLabel sizeToFit];
    self.textLabel.height = 9;
    self.textLabel.maxY = contentHeight - 8;
    
    self.textLabel.maxX = self.detailTextLabel.maxX = contentWidth - 8;
    
    [self.imageView2 sizeToFit];
    self.imageView2.x = 8;
    self.imageView2.centerY = self.textLabel.centerY;
    
    self.button.bounds = CGRectMake(0, 0, half(contentWidth), contentHeight);
    self.button.y = 0;
    self.button.maxX = contentWidth;
    
    return CGSizeMake(contentWidth, contentHeight);
}

@end
