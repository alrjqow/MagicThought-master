//
//  NSObject+MJExtension.m
//  QXProject
//
//  Created by monda on 2019/12/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "NSObject+MJExtension.h"
#import "MJExtension.h"
#import "NSString+Exist.h"

@implementation UIColor(MJExtension)

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if(![keyValues isKindOfClass:[UIColor class]])
        return nil;
    
    return keyValues;
}

-(NSMutableDictionary *)mj_keyValues{return nil;}

@end

@implementation UIImage(MJExtension)

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[NSString class]] && [keyValues isExist])
        return [UIImage imageNamed:keyValues];
    
    if([keyValues isKindOfClass:[UIImage class]])
        return keyValues;
    
    return nil;
}

-(NSMutableDictionary *)mj_keyValues{return nil;}

@end

@implementation MTWordStyle(MJExtension)

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if(![property.name isEqualToString:@"wordStyleList"])
        return oldValue;
    
    return [MTWordStyle mj_objectArrayWithKeyValuesArray:oldValue];
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[MTWordStyle class]])
        return keyValues;
    
    if([keyValues isKindOfClass:[NSDictionary class]])
        return [super mj_objectWithKeyValues:keyValues context:context];
    
    return nil;
}

-(NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary* dict = [super mj_keyValues];
    dict[@"wordColor"] = self.wordColor;
    return dict;
}

@end

@implementation MTBorderStyle(MJExtension)

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[MTBorderStyle class]])
        return keyValues;
    
    if([keyValues isKindOfClass:[NSDictionary class]])
        return [super mj_objectWithKeyValues:keyValues context:context];
    
    return nil;
}

-(NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary* dict = [super mj_keyValues];
    dict[@"borderColor"] = self.borderColor;
    dict[@"fillColor"] = self.fillColor;    
    return dict;
}

@end

@implementation MTShadowStyle(MJExtension)

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[MTShadowStyle class]])
        return keyValues;
    
    if([keyValues isKindOfClass:[NSDictionary class]])
        return [super mj_objectWithKeyValues:keyValues context:context];
    
    return nil;
}

-(NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary* dict = [super mj_keyValues];
    dict[@"shadowColor"] = self.shadowColor;
    return dict;
}

@end
