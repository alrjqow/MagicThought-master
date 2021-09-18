//
//  MTServiceModel.h
//  AFNetworking
//
//  Created by monda on 2021/1/18.
//

#import "MTPageSumController.h"
#import "MTBaseAlertController.h"

@interface MTServiceModel : NSObject

@property (nonatomic,weak, readonly) UIViewController* viewController;

@property (nonatomic,weak, readonly) UIViewController* showNoMsgController;

@property (nonatomic,weak, readonly) MTViewController* controller;

@property (nonatomic,weak, readonly) MTBaseListController* listController;

@property (nonatomic,weak, readonly) MTHeaderRefreshListController* headerListController;

@property (nonatomic,weak, readonly) MTHeaderFooterRefreshListController* headerFooterRefreshListController;

@property (nonatomic,weak, readonly) MTPageSumController* pageSumController;

@property (nonatomic,weak, readonly) MTPageScrollListController* pageScrollListController;

@property (nonatomic,weak, readonly) MTBaseAlertController* alertController;

@property (nonatomic,weak, readonly) UIView* view;

@end

