//
//  UIView+Dependency.h
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MTButton : UIButton @end

@interface UIButton (Click)

- (void)clearClick;


/// 添加时间
/// @param target 处理事件的对象
/// @param action 事件处理
- (void)addTarget:(nullable id)target action:(SEL _Nullable )action;

@end


@interface UIButton (HighLight)

/*!
 取消高亮
 */
-(void)noHighLight;

/*!
 还原高亮
 */
-(void)resetHighLight;

@end

