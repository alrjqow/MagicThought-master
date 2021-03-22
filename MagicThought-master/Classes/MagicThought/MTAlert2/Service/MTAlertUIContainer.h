//
//  MTAlertUIContainer.h
//  SimpleProject
//
//  Created by monda on 2019/6/12.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTBaseAlertController;
@interface MTAlertUIContainer : NSObject


+(void)setUpControllBarOnController:(MTBaseAlertController*)controller Layout:(void (^)(UIButton* cancelBtn, UIButton* enterBtn, UIView* sepLine))layout;


@end

