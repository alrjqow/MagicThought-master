//
//  UIView+CSSKit.h
//  CSSKitDemo
//
//  Created by Awhisper on 2016/10/10.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cssClassProtocol(target,cssClasses) \
autoreleasepool{ target.cssClass = cssClasses;}; \

#define cssStyleProtocol(target,cssStyles) \
autoreleasepool{ target.cssStyle = cssStyles;}; \

typedef UIView* (^CssClass) (NSString* cssClass);
typedef UIView* (^CssStyle) (NSString* cssStyle);

@interface UIView (VKCssProtocol)

@property (nonatomic,copy, readonly) CssStyle cssStyle;
@property (nonatomic,copy, readonly) CssClass CssClass;


-(void)refreshCSS;

@end

