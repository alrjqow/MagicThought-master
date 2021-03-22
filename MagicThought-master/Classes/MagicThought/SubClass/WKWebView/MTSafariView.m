//
//  MTSafariView.m
//  MyTool
//
//  Created by 王奕聪 on 2017/4/1.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTSafariView.h"
#import "MTConst.h"
#import "NSString+Exist.h"

@interface MTSafariView ()<UIGestureRecognizerDelegate>

@end

@implementation MTSafariView

-(WKNavigation *)loadRequest:(NSURLRequest *)request Cookies:(NSString*)cookie
{
    NSMutableURLRequest* request1;
    if([cookie isExist])
    {
        request1 = [request mutableCopy];
        [request1 addValue:cookie forHTTPHeaderField:@"Cookie"];
    }

    return [self loadRequest:request1 ? request1 : request];
}

+(void)clearCache
{
        if(mt_iOSVersion() >= 9)
        {
            NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                       modifiedSince:dateFrom completionHandler:^{
                                                           
                                                       }];
        }
        else
        {
            NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                       NSUserDomainMask, YES)[0];
            NSString *bundleId  =  mt_BundleID();
            NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
            NSString *webKitFolderInCaches = [NSString
                                              stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
            NSString *webKitFolderInCachesfs = [NSString
                                                stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
            
            NSError *error;
            /* iOS8.0 WebView Cache的存放路径 */
            [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
            
            [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
        }
}

-(void)setupSelf
{
    if (@available(iOS 11.0, *))
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMe:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];        
}

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame])
    {
        [self setupSelf];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setupSelf];
    }
    
    return self;
}


-(void)tapMe:(UITapGestureRecognizer*) tap
{
    if(self.doSomethingWhenTap)
        self.doSomethingWhenTap(tap);
}

#pragma mark - 代理
// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
