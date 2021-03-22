//
//  NSString+MaxLength.h
//  QXProject
//
//  Created by monda on 2020/3/24.
//  Copyright © 2020 monda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MaxLength)

- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfstringToIndex:(NSInteger)index;

- (BOOL)validateChineseChar:(NSString *)string;

- (BOOL)validateChinese:(NSString *)string;

- (BOOL)isMatchesRegularExp:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
