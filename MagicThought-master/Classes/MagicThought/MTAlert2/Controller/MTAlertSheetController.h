//
//  MTAlertSheetController.h
//  DaYiProject
//
//  Created by monda on 2018/9/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTBaseAlertController.h"

CG_EXTERN NSString*  MTBaseAlertDismissOrder_Close;
CG_EXTERN NSString*  MTBaseAlertDismissOrder_Enter;

@interface MTAlertSheetController : MTBaseAlertController

@property (nonatomic,copy) void (^enterBlock)(NSInteger currentIndex, NSInteger currentSection);

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger currentSection;

@end

CG_EXTERN CGFloat bottomCellHeight_mtAlertHair(CGFloat height);
CG_EXTERN CGFloat bottomCellHeight_mtAlertNormal(CGFloat height);
