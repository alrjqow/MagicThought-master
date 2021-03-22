//
//  UIImage+Base64.m
//  8kqw
//
//  Created by 王奕聪 on 2017/6/6.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "UIImage+Base64.h"

@implementation UIImage (Base64)


+(UIImage*)imageWithBase64:(NSString*)base64Str
{
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:decodedImageData];
}

-(NSString*)base64_PNG
{
    NSData *data = UIImagePNGRepresentation(self);
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(NSString*)base64_JPG
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
