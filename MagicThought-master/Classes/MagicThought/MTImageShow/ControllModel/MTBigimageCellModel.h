//
//  MTBigimageCellModel.h
//  QXProject
//
//  Created by monda on 2020/5/11.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBigimageCellModel : NSObject

@property (nonatomic,strong) NSString* bigImageCellClassName;

@property (nonatomic,assign) CGFloat bigImageCellSpacing;

@property (nonatomic,assign) CGFloat animateTime;

@property (nonatomic,assign) NSInteger bigImageShowIndex;

@property (nonatomic,assign) CGFloat maximumZoomScale;

@property (nonatomic,assign) BOOL bigImageSingleShow;

@property (nonatomic,strong) id placeholderImage;



@end

