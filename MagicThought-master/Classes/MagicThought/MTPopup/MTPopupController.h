//
//  MTPopupController.h
//  QDDProject
//
//  Created by 王奕聪 on 2022/4/9.
//  Copyright © 2022 seenovation. All rights reserved.
//

#import "MTListController.h"


@interface MTPopupController : UIViewController


@end


@interface UIViewController (MTPopupController)

-(void)popupController:(UIViewController*)controller LayoutPopup:(void (^)(UIView* popupView, UIView* contentView))layoutPopup;

-(void)dismissPopup;

-(CGSize)popupSize;

-(MTBorderStyle*)popupBorder;

@end

