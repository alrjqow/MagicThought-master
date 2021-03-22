//
//  MTAlertBigImageController.h
//  QXProject
//
//  Created by monda on 2020/5/11.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTAlertSheetController.h"
#import "MTImagePlayView.h"

@class MTImageShowControllModel;
@interface MTAlertBigImageController : MTAlertSheetController

@property (nonatomic,strong) MTBaseImagePlayView* imagePlayView;
@property (nonatomic,weak) MTImageShowControllModel* imageShowControllModel;

@end


