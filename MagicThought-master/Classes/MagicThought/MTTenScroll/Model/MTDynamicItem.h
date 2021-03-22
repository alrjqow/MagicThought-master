//
//  MTDynamicItem.h
//  MagicThought
//
//  Created by monda on 2019/11/18.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MTDynamicItem : NSObject<UIDynamicItem>

@property (nonatomic, assign) CGPoint center;

@property (nonatomic, readonly) CGRect bounds;

@property (nonatomic, assign) CGAffineTransform transform;

@end


