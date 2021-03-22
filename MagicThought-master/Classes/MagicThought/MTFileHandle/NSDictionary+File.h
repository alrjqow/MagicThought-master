//
//  NSDictionary+File.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (File)

- (BOOL)writeToDirectory:(NSString *)directory File:(NSString*)file atomically:(BOOL)useAuxiliaryFile;

+(NSDictionary*)removeNullKeyBeforeSave:(NSDictionary*)d;

@end
