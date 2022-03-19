//
//  MTViewContentModel.m
//  QXProject
//
//  Created by monda on 2019/12/5.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTViewContentModel.h"
#import "NSObject+ReuseIdentifier.h"

#import "MJExtension.h"


@interface NSArray(MTBaseViewContentModel)

-(instancetype)baseViewContentModelArrayWIthClass:(Class)modelClass;

@end

@implementation MTViewContentModel

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if(![oldValue isKindOfClass:[NSObject class]])
        return oldValue;
    
    if([oldValue isKindOfClass:[MTTimeRecordModel class]])
        return oldValue;        
    
    if([property.type.typeClass isSubclassOfClass:[NSArray class]])
    {
        Class objectClass = [property objectClassInArrayForClass:[self class]];
        
        if(![objectClass isSubclassOfClass:[MTBaseViewContentModel class]])
            return oldValue;
        else
            return [(NSArray*)oldValue baseViewContentModelArrayWIthClass:objectClass];
    }
    
    if(![property.type.typeClass isSubclassOfClass:[MTBaseViewContentModel class]])
        return oldValue;
    
    if([oldValue isKindOfClass:[MTBaseViewContentModel class]])
        return oldValue;
        
    MTBaseViewContentModel* model;
    NSObject* obj = oldValue;
    if([obj.mt_order isEqualToString:MTBindNewObjectOrder])
        model = property.type.typeClass.new;
    else
    {
        model = [self valueForKey:property.name];
        if(!model)
            model = property.type.typeClass.new;
    }
    
    return [model copyBindWithObject:obj].setObjects(oldValue);
}

@end



@implementation NSArray(MTBaseViewContentModel)

-(instancetype)baseViewContentModelArrayWIthClass:(Class)modelClass;
{
    NSMutableArray* arr = [NSMutableArray array];
    
    if(![modelClass isSubclassOfClass:[MTBaseViewContentModel class]])
        return self;
    
    for(NSObject* obj in self)
    {
        if(![obj isKindOfClass:[NSObject class]])
            continue;
        
        NSObject* model;
        if([obj isKindOfClass:modelClass])
            model = obj;
        else
            model = [modelClass.new setWithObject:obj];
                
        [arr addObject:[model copyBindWithObject:obj]];
    }
    
    return [arr copy];
}

@end

