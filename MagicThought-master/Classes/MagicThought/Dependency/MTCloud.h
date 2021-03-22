//
//  MTCloud.h
//  8kqw
//
//  Created by 王奕聪 on 2017/3/24.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTManager.h"

@protocol MTBaseDataModelProtocol;
@interface MTCloud : MTManager

- (void)setBool:(BOOL)value forKey:(id)key;
- (void)setInteger:(NSInteger)value forKey:(id)key;
- (void)setFloat:(CGFloat)value forKey:(id)key;
- (void)setString:(NSString*)str forKey:(id)key;
- (void)setObject:(id)obj forKey:(id)key;

- (BOOL)boolForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (CGFloat)floatForKey:(id)key;
- (NSString*)stringForKey:(id)key;
- (instancetype)objectForKey:(id)key;

- (void)removeObjectForKey:(id)key;

+(MTCloud*)shareCloud;

@property (nonatomic,strong) NSObject<MTBaseDataModelProtocol>* apiManager;

@property (nonatomic,strong) NSString* alertViewConfigName;

@property (nonatomic,weak) UIViewController* currentViewController;

@end
