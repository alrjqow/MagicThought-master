//
//  NSData+File.h
//  8kqw
//
//  Created by 王奕聪 on 2017/4/23.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (File)

- (BOOL)writeToDirectory:(NSString *)directory File:(NSString*)file atomically:(BOOL)useAuxiliaryFile;

@end
