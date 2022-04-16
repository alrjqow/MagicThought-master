//
//  MTPageControl.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import <UIKit/UIKit.h>
#import "MTBorderStyle.h"


@interface MTPageControl : UIPageControl

@property (nonatomic,assign) CGSize pointSize;
@property (nonatomic,assign) CGSize selectedPointSize;

@property (nonatomic,assign) CGFloat pointMargin;

@property (nonatomic,strong) MTBorderStyle* selectBorderStyle;

@property (nonatomic,strong) MTBorderStyle* normalBorderStyle;

@end

