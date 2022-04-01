//
//  MTPageControl.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import <UIKit/UIKit.h>


@interface MTPageControl : UIPageControl

@property (nonatomic,assign) CGSize pointSize;

@property (nonatomic,assign) CGFloat pointMargin;

@property (nonatomic,strong) UIColor* selectColor;

@property (nonatomic,strong) UIColor* normalColor;

@end

