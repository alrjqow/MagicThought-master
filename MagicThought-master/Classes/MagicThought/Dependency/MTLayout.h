//
//  MTLayout.h
//  QXProject
//
//  Created by monda on 2020/9/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MTLayoutFrame : NSObject

@property (nonatomic,strong,readonly) MTLayoutFrame* x;

@property (nonatomic,strong,readonly) MTLayoutFrame* y;

@property (nonatomic,strong,readonly) MTLayoutFrame* top;

@property (nonatomic,strong,readonly) MTLayoutFrame* left;

@property (nonatomic,strong,readonly) MTLayoutFrame* bottom;

@property (nonatomic,strong,readonly) MTLayoutFrame* right;

@property (nonatomic,strong,readonly) MTLayoutFrame* width;

@property (nonatomic,strong,readonly) MTLayoutFrame* height;

@property (nonatomic,strong,readonly) MTLayoutFrame* centerX;

@property (nonatomic,strong,readonly) MTLayoutFrame* centerY;

@property (nonatomic,strong,readonly) MTLayoutFrame* maxX;

@property (nonatomic,strong,readonly) MTLayoutFrame* maxY;

@property (nonatomic,strong,readonly) MTLayoutFrame* edge;

@property (nonatomic,copy, readonly) MTLayoutFrame* (^equalTo)(NSObject* obj);
@property (nonatomic,copy, readonly) MTLayoutFrame* (^equalToValue)(CGFloat value);

@property (nonatomic,copy, readonly) void (^offset)(CGFloat offset);

@end

@interface UIView (MTLayoutFrame)

@property (nonatomic,strong,readonly) MTLayoutFrame* x_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* y_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* top_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* left_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* bottom_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* right_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* width_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* height_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* centerX_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* centerY_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* maxX_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* maxY_mt;

@property (nonatomic,strong,readonly) MTLayoutFrame* edge_mt;

@end
