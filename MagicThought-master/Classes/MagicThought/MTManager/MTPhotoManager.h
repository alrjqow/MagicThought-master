//
//  MTPhotoManager.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/18.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"

@interface MTPhotoManager : MTManager

/**根据资源id获取到图片*/
- (void)searchAllImagesWithLocalIdentifiers:(NSArray<NSString*> *)ids CompletionHandler:(void (^) ( UIImage* _Nullable ))completionHandler;

/** 保存图片 */
+ (void)saveImage:(UIImage*)image To:(NSString*)collectionName completion: (void (^)(NSInteger, NSString*))completion;

@end
