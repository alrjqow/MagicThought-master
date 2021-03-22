//
//  UIFont+FontResource.h
//  AppBase
//
//  Created by monda on 2020/12/21.
//

#import <UIKit/UIKit.h>

@interface UIFont (FontResource)

+ (void)registerFont:(NSString *)fontName withExtension:(NSString *)extension inBundle:(NSBundle *)bundle;

@end

