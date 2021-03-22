//
//  UIFont+FontResource.m
//  AppBase
//
//  Created by monda on 2020/12/21.
//

#import "UIFont+FontResource.h"
#import <CoreText/CoreText.h>

@implementation UIFont (FontResource)

+ (void)registerFont:(NSString *)fontName withExtension:(NSString *)extension inBundle:(NSBundle *)bundle
{
    NSURL *fontURL = [bundle URLForResource:fontName withExtension:extension];
    NSData *inData = [NSData dataWithContentsOfURL:fontURL];
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        // Failed to load font
        CFRelease(errorDescription);
    }
    if (font != NULL) CFRelease(font);
    if (provider != NULL) CFRelease(provider);
}

@end
