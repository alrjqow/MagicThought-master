//
//  UIImage+Base64.h
//  8kqw
//
//  Created by 王奕聪 on 2017/6/6.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Base64)

-(NSString*)base64_PNG;

-(NSString*)base64_JPG;

+(UIImage*)imageWithBase64:(NSString*)base64Str;



@end
