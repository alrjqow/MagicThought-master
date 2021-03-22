//
//  VKCssClassManager.m
//  CSSKitDemo
//
//  Created by Awhisper on 2016/10/11.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKCssClassManager.h"
#import "VKCssStyleManager.h"


void loadBundleCss_mt(NSString* fileName)
{
    [VKCssClassManager readBundleCssFile:fileName];
}

void loadPathCss_mt(NSString* path)
{
    [VKCssClassManager readCssFilePath:path];
}

void reloadBundleCss_mt(NSString* fileName)
{
    [VKCssClassManager reloadBundleCssFile:fileName];
}
void reloadPathCss_mt(NSString* path)
{
    [VKCssClassManager reloadCssFilePath:path];
}

@interface VKCssClassManager ()

@property (nonatomic,strong) NSMutableDictionary *cssFileArr;

@end

@implementation VKCssClassManager

VK_DEF_SINGLETON

-(instancetype)init{
    self = [super init];
    if (self) {
        self.cssClassDic = [[NSMutableDictionary alloc]init];
        self.cssFileArr = [[NSMutableDictionary alloc]init];
    }
    return self;
}

+(void)addCssClassName:(NSString *)className sytleName:(NSString *)styleName styleValue:(id)styleValue{
    [[VKCssClassManager singleton]addCssClassName:className sytleName:styleName styleValue:styleValue];
}

-(void)addCssClassName:(NSString *)className sytleName:(NSString *)styleName styleValue:(id)styleValue{
    
    VKCssClassModal *cssclass = [self.cssClassDic objectForKey:className];
    if (!cssclass) {
        cssclass = [[VKCssClassModal alloc]initWithName:className];
    }
    
    [cssclass.styleDic setObject:styleValue forKey:styleName];
    [self.cssClassDic setObject:cssclass forKey:className];
    
}


+(void)defineCssClass:(NSString *)className styleInfo:(NSArray *)info
{
    if ([info.firstObject isKindOfClass:[NSString class]]) {
        [VKCssClassManager defineCssClass:className styleStrArr:info];
    }else if ([info.firstObject isKindOfClass:[NSDictionary class]]){
        [VKCssClassManager defineCssClass:className styleDicArr:info];
    }
}

+(void)defineCssClass:(NSString *)className styleStrArr:(NSArray *)styleArr
{
    for (NSString *style in styleArr) {
        if ([style rangeOfString:@":"].location != NSNotFound) {
            NSArray *styleItem = [style componentsSeparatedByString:@":"];
            NSString *styleName = styleItem.firstObject;
            NSString *styleValue = styleItem.lastObject;
            [VKCssClassManager addCssClassName:className sytleName:styleName styleValue:styleValue];
        }else if(style.length > 0){
            NSLog(@"style string is incorrect");
        }
    }
}

+(void)defineCssClass:(NSString *)className styleDicArr:(NSArray *)styleDicArr
{
    for (NSDictionary *styleDic in styleDicArr) {
        for (NSString *stylekey in styleDic.allKeys) {
            id stylevalue = [styleDic objectForKey:stylekey];
            [VKCssClassManager addCssClassName:className sytleName:stylekey styleValue:stylevalue];
        }
    }
    
}

+(void)setCssClass:(id)target className:(NSString *)className{
    [[VKCssClassManager singleton]setCssClass:target className:className];
}

-(void)setCssClass:(id)target className:(NSString *)className{
    VKCssClassModal *cssclass = [self.cssClassDic objectForKey:className];
    if (cssclass) {
        NSArray *styleKeyArr = cssclass.styleDic.allKeys;
        for (NSString *styleName in styleKeyArr) {
            id stylevalue = [cssclass.styleDic objectForKey:styleName];
            [VKCssStyleManager setCssStyle:target styleName:styleName styleValue:stylevalue];
        }
        
    }

}

+(void)readBundleCssFile:(NSString *)cssFile
{
    NSString *cssFilePath = [[NSBundle mainBundle] pathForResource:cssFile ofType:@"css"];

    [VKCssClassManager readCssFilePath:cssFilePath];
}

+(void)readCssFilePath:(NSString *)cssFilePath
{
    [VKCssClassManager readCssFilePath:cssFilePath IsReload:false];
}

+ (void)reloadBundleCssFile:(NSString *)cssFile
{
    NSString *cssFilePath = [[NSBundle mainBundle] pathForResource:cssFile ofType:@"css"];
    [VKCssClassManager readCssFilePath:cssFilePath IsReload:YES];
}
+ (void)reloadCssFilePath:(NSString *)cssFilePath
{
    [VKCssClassManager readCssFilePath:cssFilePath IsReload:YES];
}

+(void)reloadAllCssFile
{
    [VKCssClassManager clearCssFile];
    NSDictionary *fileArray = [[VKCssClassManager singleton].cssFileArr.allKeys copy];
    for (NSString * cssFilePath in fileArray) {
        [VKCssClassManager readCssFilePath:cssFilePath IsReload:YES];
    }
}

+(void)readCssFilePath:(NSString *)cssFilePath IsReload:(BOOL)isReload
{
    if(!isReload && [VKCssClassManager singleton].cssFileArr[@"cssFilePath"])
            return;
    
    NSString* filePath = [cssFilePath stringByDeletingLastPathComponent];
    NSString *css = [NSString stringWithContentsOfFile:cssFilePath encoding:NSUTF8StringEncoding error:nil];
    
    css = [VKCssClassManager parseCssContent0:css];
    [VKCssClassManager parseCssContent:css];
    [VKCssClassManager parseCssContent2:css FilePath:filePath];
    
    if (cssFilePath && css) {
        [[VKCssClassManager singleton].cssFileArr setObject:css forKey:cssFilePath];
    }
}

+(void)clearCssFile
{
    [[VKCssClassManager singleton].cssClassDic removeAllObjects];
}


+(NSString*)parseCssContent0:(NSString *)cssContent
{
    cssContent = [cssContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSMutableArray<NSString*>* arr = [NSMutableArray array];
    
    NSScanner *theScanner = [NSScanner scannerWithString:cssContent];

    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"/*" intoString:nil];
        NSInteger startIndex = theScanner.scanLocation;
        
        [theScanner scanUpToString:@"*/" intoString:nil];
        NSInteger endIndex = theScanner.scanLocation + 1;
                        
        if(endIndex < cssContent.length)
            [arr addObject:[cssContent substringWithRange:NSMakeRange(startIndex, endIndex - startIndex + 1)]];
    }
    
    for (NSString* subStr in arr) {
        cssContent = [cssContent stringByReplacingOccurrencesOfString:subStr withString:@""];
    }
    
    return cssContent;
}
+(void)parseCssContent:(NSString *)cssContent
{
    cssContent = [cssContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSScanner *theScanner = [NSScanner scannerWithString:cssContent];
    
    [theScanner setCaseSensitive: YES];
    [theScanner setScanLocation: 0];
    
    
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"." intoString:nil];
        NSInteger cssClassNameStart = theScanner.scanLocation + 1;
        [theScanner scanUpToString:@"{" intoString:nil];
        NSInteger cssdefineStart = theScanner.scanLocation + 1;
        
        NSString *cssName = @"";
        if((cssdefineStart - 1) < cssContent.length)
            cssName = [cssContent substringWithRange:NSMakeRange(cssClassNameStart, cssdefineStart - cssClassNameStart - 1)];
        [theScanner scanUpToString:@"}" intoString:nil];
        NSInteger cssdefineEnd = theScanner.scanLocation + 1;
        
        NSString *cssDef = @"";
        if((cssdefineEnd - 1) < cssContent.length)
            cssDef = [cssContent substringWithRange:NSMakeRange(cssdefineStart, cssdefineEnd - cssdefineStart - 1)];
        
        cssName = [cssName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([cssName containsString:@"css\";"])
        {
            NSRange range = [cssName rangeOfString:@"."];
            if(range.location != NSNotFound)
                cssName = [cssName substringFromIndex: (range.location + 1)];
        }
        cssName = [cssName stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        NSArray *cssStyles = [cssDef componentsSeparatedByString:@";"];
        for (NSString *cssstyle in cssStyles) {
            NSString *style = [cssstyle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([style rangeOfString:@":"].location != NSNotFound) {
                NSArray *styleItem = [style componentsSeparatedByString:@":"];
                NSString *styleName = [styleItem.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSString *styleValue = [styleItem.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                [VKCssClassManager addCssClassName:cssName sytleName:styleName styleValue:styleValue];
            }else if(style.length > 0){
                NSLog(@"style string is incorrect");
            }
            
        }
    }        
}

+(void)parseCssContent2:(NSString *)cssContent FilePath:(NSString*)filePath
{
    cssContent = [cssContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSScanner *theScanner = [NSScanner scannerWithString:cssContent];
    
    [theScanner setCaseSensitive: YES];
    [theScanner setScanLocation: 0];
    
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"@import" intoString:nil];
        NSInteger cssFileNameStart = theScanner.scanLocation + 7;
        
        [theScanner scanUpToString:@".css\";" intoString:nil];
        NSInteger cssdefineEnd = theScanner.scanLocation;
        
        NSString *cssFileName = @"";
        if(cssdefineEnd < cssContent.length)
            cssFileName = [cssContent substringWithRange:NSMakeRange(cssFileNameStart, cssdefineEnd - cssFileNameStart)];
        cssFileName = [cssFileName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        cssFileName = [cssFileName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        if(cssFileName.length > 0)
        {
            cssFileName = [cssFileName stringByAppendingString:@".css"];
            [VKCssClassManager readCssFilePath:[filePath stringByAppendingPathComponent:cssFileName]];
        }
    }
}

@end
