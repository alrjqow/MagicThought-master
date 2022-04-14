//
//  MTAlertView.h
//  QDDProject
//
//  Created by 王奕聪 on 2022/4/14.
//  Copyright © 2022 seenovation. All rights reserved.
//

#import "MTBaseView.h"


@interface MTAlertTipsView : MTBaseView

@property (nonatomic,strong) NSArray<NSNumber*>* ySpacingArray;

@property (nonatomic,assign) CGFloat contentMargin;
@property (nonatomic,assign) CGFloat buttonMargin;

@property (nonatomic,assign) CGFloat spacingBetweenButtonAndButton;
@property (nonatomic,assign) CGFloat buttonHeight;


@end

