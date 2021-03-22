//
//  MTPageScrollController.h
//  QXProject
//
//  Created by monda on 2020/4/14.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPageControllModel.h"

@interface MTPageScrollController : UIPageViewController

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) NSArray<UIViewController*>* pageControllerArray;

@property (nonatomic,weak) MTPageControllModel* pageControllModel;

@end


