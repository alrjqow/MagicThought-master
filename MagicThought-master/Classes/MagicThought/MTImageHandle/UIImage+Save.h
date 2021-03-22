//
//  UIImage+Save.h
//  8kqw
//
//  Created by 王奕聪 on 2017/5/17.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MTImageSaveToLibraryTypeFailure,
    MTImageSaveToLibraryTypeSuccessButCollectionFailure,
    MTImageSaveToLibraryTypeSuccess,
} MTImageSaveToLibraryType;

@interface UIImage (Save)

/**将图片保存至某路径，压缩比可调*/
-(BOOL)saveTo:(NSString*)directoryPath Name:(NSString*)name Zip:(CGFloat)zip;

/**将图片保存至某路径，压缩比为1*/
-(BOOL)saveTo:(NSString*)directoryPath Name:(NSString*)name;

/**将图片从某路径下取出来*/
+(UIImage*)imageWithPath:(NSString*)directoryPath;

/**压缩图片根据给定的最大MB*/
- (NSData *)compressWithMaxDataSizeMBytes:(CGFloat)size;



@end

@interface  UIImage(PhotoLibrary)

- (void)saveToPhotoLibrary: (void (^)(BOOL success))completion;

@end
