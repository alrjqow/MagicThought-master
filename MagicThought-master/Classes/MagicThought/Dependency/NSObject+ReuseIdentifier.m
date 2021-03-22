//
//  NSObject+ReuseIdentifier.m
//  MTEasyController
//
//  Created by monda on 2018/4/23.
//  Copyright © 2018年 monda. All rights reserved.
//

#import "NSObject+ReuseIdentifier.h"
#import "MJExtension.h"
#import "objc/runtime.h"
#import "NSString+Exist.h"
#import "MTContentModelPropertyConst.h"

NSString* MTClearNotificationOrder = @"MTClearNotificationOrder";
NSString* MTBanClickOrder = @"MTBanClickOrder";
NSString* MTBindNewObjectOrder = @"MTBindNewObjectOrder";


@implementation NSBindObject @end

@implementation NSReuseObject @end
@implementation NSWeakReuseObject @end


@implementation NSObject (ReuseIdentifier)

-(void)setMt_automaticDimension:(BOOL)mt_automaticDimension
{
    objc_setAssociatedObject(self, @selector(mt_automaticDimension), @(mt_automaticDimension), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)mt_automaticDimension
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setMt_result:(BOOL)mt_result
{
    objc_setAssociatedObject(self, @selector(mt_result), @(mt_result), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)mt_result
{
    NSNumber* result = objc_getAssociatedObject(self, _cmd);
    
    if(result)
        return [result boolValue];
    else
        return YES;
}

-(void)setMt_tag:(NSInteger)mt_tag
{
    objc_setAssociatedObject(self, @selector(mt_tag), @(mt_tag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)mt_tag
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setMt_index:(NSNumber *)mt_index
{
    objc_setAssociatedObject(self, @selector(mt_index), mt_index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)mt_index
{
    return objc_getAssociatedObject(self, _cmd);
}

-(NSInteger)mt_currentIndex
{    
    return self.mt_index.integerValue;
}

-(void)setMt_order:(NSString *)mt_order
{
    objc_setAssociatedObject(self, @selector(mt_order), mt_order, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)mt_order
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_click:(MTClick)mt_click
{
    objc_setAssociatedObject(self, @selector(mt_click), mt_click, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(MTClick)mt_click
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_automaticDimensionSize:(MTAutomaticDimensionSize)mt_automaticDimensionSize
{
     objc_setAssociatedObject(self, @selector(mt_automaticDimensionSize), mt_automaticDimensionSize, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(MTAutomaticDimensionSize)mt_automaticDimensionSize
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_notificationHandle:(MTNotificationHandle)mt_notificationHandle
{
    objc_setAssociatedObject(self, @selector(mt_notificationHandle), mt_notificationHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(MTNotificationHandle)mt_notificationHandle
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_tagIdentifier:(NSString *)mt_tagIdentifier
{
    objc_setAssociatedObject(self, @selector(mt_tagIdentifier), mt_tagIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)mt_tagIdentifier
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_reuseIdentifier:(NSString *)mt_reuseIdentifier
{
    objc_setAssociatedObject(self, @selector(mt_reuseIdentifier), mt_reuseIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)mt_reuseIdentifier
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_keyName:(NSString *)mt_keyName
{
    objc_setAssociatedObject(self, @selector(mt_keyName), mt_keyName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)mt_keyName
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMt_itemHeight:(CGFloat)mt_itemHeight
{
    objc_setAssociatedObject(self, @selector(mt_itemHeight), @(mt_itemHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)mt_itemHeight
{
    NSNumber* height = objc_getAssociatedObject(self, _cmd);
    
    return height.floatValue;
}

-(void)setMt_itemEstimateHeight:(NSObject *)mt_itemEstimateHeight
{
    objc_setAssociatedObject(self, @selector(mt_itemEstimateHeight), mt_itemEstimateHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject *)mt_itemEstimateHeight
{
    NSObject* itemEstimateHeight = objc_getAssociatedObject(self, _cmd);
    
    if(!itemEstimateHeight)
    {
        itemEstimateHeight = [NSObject new];
        objc_setAssociatedObject(self, _cmd, itemEstimateHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);        
    }
    
    return itemEstimateHeight;
}

-(void)setMt_itemSize:(CGSize)mt_itemSize
{
    objc_setAssociatedObject(self, @selector(mt_itemSize), [NSValue valueWithCGSize:mt_itemSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(CGSize)mt_itemSize
{
    NSValue* size = objc_getAssociatedObject(self, _cmd);
    
    return size ? size.CGSizeValue : CGSizeZero;
}

-(void)setMt_spacing:(MTDelegateCollectionViewSpacing)mt_spacing
{
    //结构体转换成对象
    objc_setAssociatedObject(self, @selector(mt_spacing), [NSValue valueWithBytes:&mt_spacing objCType:@encode(MTDelegateCollectionViewSpacing)], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MTDelegateCollectionViewSpacing)mt_spacing
{
    MTDelegateCollectionViewSpacing spacing = {0, 0, UIEdgeInsetsZero};
    NSValue* value = objc_getAssociatedObject(self, _cmd);
    [value getValue:&spacing];
    
    return spacing;
}

-(void)setMt_open3dTouch:(BOOL)mt_open3dTouch
{
    objc_setAssociatedObject(self, @selector(mt_open3dTouch), @(mt_open3dTouch), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)mt_open3dTouch
{
    NSNumber* open3dTouch = objc_getAssociatedObject(self, _cmd);
    
    return open3dTouch.boolValue;
}


-(void)setMt_headerEmptyShow:(BOOL)mt_headerEmptyShow
{
    objc_setAssociatedObject(self, @selector(mt_headerEmptyShow), @(mt_headerEmptyShow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)mt_headerEmptyShow
{
    NSNumber* headerEmptyShow = objc_getAssociatedObject(self, _cmd);
    
    return headerEmptyShow.boolValue;
}

@end



@implementation NSObject (BindReuseIdentifier)

-(BindClick)bindClick
{
    __weak __typeof(self) weakSelf = self;
    BindClick bindClick  = ^(MTClick click){
        
        if(!click)
            return weakSelf;
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(!obj.mt_click)
                    obj.mt_click = click;
            }
        }
        
        weakSelf.mt_click = click;
        return weakSelf;
    };
    
    return bindClick;
}

-(BindCount)bindCount
{
    __weak __typeof(self) weakSelf = self;
    BindCount bindCount  = ^(NSInteger count){
        
        NSMutableArray* arr = [NSMutableArray array];
        
        for(NSInteger i = 0; i < count; i++)
            [arr addObject:mt_reuse(weakSelf)];
        
        return [arr copy];
    };
    
    return bindCount;
}

-(BindReuseIdentifier)bind
{
    __weak __typeof(self) weakSelf = self;
    BindReuseIdentifier bind  = ^(NSString* reuseIdentifier){
        
        if(reuseIdentifier.length <= 0)
            return weakSelf;
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(![obj.mt_reuseIdentifier isExist])
                    obj.mt_reuseIdentifier = reuseIdentifier;
            }
            
        }
        
        weakSelf.mt_reuseIdentifier = reuseIdentifier;
        return weakSelf;
    };
    
    return bind;
}

-(BindOrder)bindOrder
{
    __weak __typeof(self) weakSelf = self;
    BindOrder bindOrder  = ^(NSString* order){
        
        if(order.length <= 0)
            return weakSelf;
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(![obj.mt_order isExist])
                    obj.mt_order = order;
            }
            
            return weakSelf;
        }
        
        weakSelf.mt_order = order;
        return weakSelf;
    };
    
    return bindOrder;
}

-(BindOrder)bindArrayOrder
{
    __weak __typeof(self) weakSelf = self;
    BindOrder bindArrayOrder  = ^(NSString* order){
        
        if(order.length <= 0)
            return weakSelf;
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
               
        weakSelf.mt_order = order;
        return weakSelf;
    };
    
    return bindArrayOrder;
}

-(AutomaticDimension)automaticDimension
{
    __weak __typeof(self) weakSelf = self;
     AutomaticDimension automaticDimension  = ^{
         
         if([weakSelf isKindOfClass:[NSArray class]])
         {
             NSArray* arr = (NSArray*)weakSelf;
             for(NSObject* obj in arr)
             {
                 obj.mt_automaticDimension = YES;
                 obj.mt_tag = kNew;
             }                 
             
             return weakSelf;
         }
         
         weakSelf.mt_automaticDimension = YES;
         weakSelf.mt_tag = kNew;
         return weakSelf;
     };
     
     return automaticDimension;
}


-(AutomaticDimensionSize)automaticDimensionSize
{
    __weak __typeof(self) weakSelf = self;
       AutomaticDimensionSize automaticDimensionSize  = ^(MTAutomaticDimensionSize mt_automaticDimensionSize){
                 
           weakSelf.mt_automaticDimensionSize = mt_automaticDimensionSize;           
           return weakSelf;
       };
       
       return automaticDimensionSize;
}

-(BindNewObjectOrder)bindNewObjectOrder
{
    __weak __typeof(self) weakSelf = self;
    BindNewObjectOrder bindNewObjectOrder  = ^{
        
        weakSelf.mt_order = MTBindNewObjectOrder;
        return weakSelf;
    };
    
    return bindNewObjectOrder;
}

-(BindTag)bindEnum
{
    __weak __typeof(self) weakSelf = self;
    BindTag bindEnum  = ^(NSInteger tag){
        
        weakSelf.mt_tag = tag;
        return weakSelf;
    };
    
    return bindEnum;
}

-(BindIndex)bindIndex
{
    __weak __typeof(self) weakSelf = self;
    BindIndex bindIndex  = ^(NSInteger index){
        
        weakSelf.mt_index = @(index);
        return weakSelf;
    };
    
    return bindIndex;
}

-(BindResult)bindResult
{
    __weak __typeof(self) weakSelf = self;
    BindResult bindResult  = ^(BOOL result){
        
        weakSelf.mt_result = result;
        return weakSelf;
    };
    
   return bindResult;
}

-(BindTagIdentifier)bindTag
{
    __weak __typeof(self) weakSelf = self;
    BindTagIdentifier bindTag  = ^(NSString* tagIdentifier){
        
        if(tagIdentifier.length <= 0)
            return weakSelf;
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(![obj.mt_tagIdentifier isExist])
                    obj.mt_tagIdentifier = tagIdentifier;
            }
            
            
            return weakSelf;
        }
        
        weakSelf.mt_tagIdentifier = tagIdentifier;
        return weakSelf;
    };
    
    return bindTag;
}

-(BindKey)bindKey
{
    __weak __typeof(self) weakSelf = self;
    BindKey bindKey  = ^(NSString* keyName){
        
        if(keyName.length <= 0)
            return weakSelf;
        
        weakSelf.mt_keyName = keyName;
        return weakSelf;
    };
    
    return bindKey;
}

-(BindTagText)bindTagText
{
    __weak __typeof(self) weakSelf = self;
    BindTagText bindTagText  = ^(NSString* tagIdentifier){
                
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
                obj.mt_tagIdentifier = tagIdentifier;
            
            return weakSelf;
        }
        
        weakSelf.mt_tagIdentifier = tagIdentifier;
        return weakSelf;
    };
    
    return bindTagText;
}

-(BindArrayReuseIdentifier)arrBind
{
    __weak __typeof(self) weakSelf = self;
    BindArrayReuseIdentifier arrBind  = ^(NSString* reuseIdentifier){
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
        
        weakSelf.mt_reuseIdentifier = reuseIdentifier;
        return weakSelf;
    };
    
    return arrBind;
}

-(BindRowHeight)bindHeight
{
    __weak __typeof(self) weakSelf = self;
    BindRowHeight bindHeight  = ^(CGFloat itemHeight){
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(!obj.mt_itemHeight)
                    obj.mt_itemHeight = itemHeight;
            }
        }
        
        weakSelf.mt_itemHeight = itemHeight;
        return weakSelf;
    };
    
    return bindHeight;
}

-(BindRowsHeight)bindRowsHeight
{
    __weak __typeof(self) weakSelf = self;
    BindRowsHeight bindRowsHeight  = ^(NSArray<NSNumber*>* heights){
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
        
        NSArray* arr = (NSArray*)weakSelf;
        for(NSInteger i = 0; i < arr.count; i++)
        {
            if(i >= heights.count)
                break;
            
            if(![arr[i] isKindOfClass:[NSObject class]])
                continue;
            
            NSObject* obj =arr[i];
            obj.mt_itemHeight = heights[i].floatValue;
        }
        return weakSelf;
        
    };
    
    return bindRowsHeight;
}

-(BindItemSize)bindSize
{
    __weak __typeof(self) weakSelf = self;
    BindItemSize bindSize  = ^(CGSize size){
        
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
            {
                if(CGSizeEqualToSize(CGSizeZero, obj.mt_itemSize))
                    obj.mt_itemSize = size;
            }
            
            return weakSelf;
        }
        
        weakSelf.mt_itemSize = size;
        return weakSelf;
    };
    
    return bindSize;
}

-(BindArrayItemSize)arrBindSize
{
    __weak __typeof(self) weakSelf = self;
    BindArrayItemSize bindSize  = ^(CGSize size){
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
        
        weakSelf.mt_itemSize = size;
        return weakSelf;
    };
    
    return bindSize;
}

-(BindItemsSize)bindItemsSize
{
    __weak __typeof(self) weakSelf = self;
    BindItemsSize bindItemsSize  = ^(NSArray<NSValue*>* sizes){
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
        
        NSArray* arr = (NSArray*)weakSelf;
        for(NSInteger i = 0; i < arr.count; i++)
        {
            if(i >= sizes.count)
                break;
            
            if(![arr[i] isKindOfClass:[NSObject class]])
                continue;
            
            NSObject* obj =arr[i];
            obj.mt_itemSize = sizes[i].CGSizeValue;
        }
        return weakSelf;
        
    };
    
    return bindItemsSize;
}


-(BindItemSpacing)bindSpacing
{
    __weak __typeof(self) weakSelf = self;
    BindItemSpacing bindSpacing  = ^(MTDelegateCollectionViewSpacing spacing){
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
                obj.mt_spacing = spacing;
            
            return weakSelf;
        }
        
        weakSelf.mt_spacing = spacing;
        return weakSelf;
    };
    
    return bindSpacing;
}

-(BindItemsSpacing)bindItemsSpacing
{
    __weak __typeof(self) weakSelf = self;
    BindItemsSpacing bindItemsSpacing  = ^(NSArray<NSValue*>* itemSpacing){
        
        if(![weakSelf isKindOfClass:[NSArray class]])
            return weakSelf;
        
        NSArray* arr = (NSArray*)weakSelf;
        for(NSInteger i = 0; i < arr.count; i++)
        {
            if(i >= itemSpacing.count)
                break;
            
            if(![arr[i] isKindOfClass:[NSObject class]])
                continue;
            
            MTDelegateCollectionViewSpacing spacing = {0, 0, UIEdgeInsetsZero};
            [itemSpacing[i] getValue:&spacing];
            
            NSObject* obj =arr[i];
            obj.mt_spacing = spacing;
        }
        return weakSelf;
        
    };
    
    return bindItemsSpacing;
}

- (Bind3dTouch)bind3dTouch
{
    __weak __typeof(self) weakSelf = self;
    Bind3dTouch bind3dTouch  = ^(){
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
                obj.mt_open3dTouch = YES;
            
            return weakSelf;
        }
        
        weakSelf.mt_open3dTouch = YES;
        return weakSelf;
    };
    
    return bind3dTouch;
}

-(BindHeaderEmptyShow)bindHeaderEmptyShow
{
    __weak __typeof(self) weakSelf = self;
    BindHeaderEmptyShow bindHeaderEmptyShow  = ^(){
        if([weakSelf isKindOfClass:[NSArray class]])
        {
            NSArray* arr = (NSArray*)weakSelf;
            for(NSObject* obj in arr)
                obj.mt_headerEmptyShow = YES;
            
            return weakSelf;
        }
        
        weakSelf.mt_headerEmptyShow = YES;
        return weakSelf;
    };
    
    return bindHeaderEmptyShow;
}

- (instancetype)setWithObject:(NSObject*)obj{
    
    if([obj isKindOfClass:[NSBindObject class]])
    {
        [self copyBindWithObject:obj];
    }
    
    return self;
}
- (instancetype _Nullable)copyBindWithObject:(NSObject* _Nullable)obj
{
    if(![self.mt_reuseIdentifier isExist])
        self.bind(obj.mt_reuseIdentifier);
    if(obj.mt_click)
        self.bindClick(obj.mt_click);    
    if(![self.mt_order isExist])
        self.bindOrder(obj.mt_order);
    if(![self.mt_tagIdentifier isExist])
        self.bindTag(obj.mt_tagIdentifier);
    self.bindEnum(obj.mt_tag);
    if(!self.mt_index)
        self.bindIndex(obj.mt_index.integerValue);
    
    self.mt_automaticDimension = obj.mt_automaticDimension;
    
    return self;
}

-(instancetype _Nullable)clearBind
{
    self.mt_reuseIdentifier = nil;
    self.mt_click = nil;
    self.mt_order = nil;
    self.mt_tag = 0;
    self.mt_result = YES;
    self.mt_tagIdentifier = nil;
    self.mt_itemHeight = 0;
    
    return self;
}

-(id _Nonnull (^) (NSObject* _Nullable objects))setObjects
{    
    __weak __typeof(self) weakSelf = self;
    id _Nonnull (^ _Nonnull setObjects) (NSObject* _Nullable objects)  = ^(NSObject* objects){
        
        if([objects isKindOfClass:[NSArray class]])
        {
            for (NSObject* obj in (NSArray*)objects)
            {
                [weakSelf setWithObject:obj];
            }
        }
        else
            [weakSelf setWithObject:objects];
        
        return weakSelf;
    };
    
    return setObjects;
}



@end


@implementation NSObject (Notification)

-(WhenReceiveNotification)whenReceiveNotification
{
    __weak __typeof(self) weakSelf = self;
       WhenReceiveNotification whenReceiveNotification  = ^(MTNotificationHandle notificationHandle){
           
           if(!notificationHandle)
               return weakSelf;
             
           weakSelf.mt_notificationHandle = notificationHandle;
           return weakSelf;
       };
       
       return whenReceiveNotification;
}

-(BindNotifications)bindNotifications
{
    __weak __typeof(self) weakSelf = self;
       BindNotifications bindNotifications  = ^(NSArray<NSString*>* _Nonnull notifications){
           
           if(notifications.count <= 0)
               return weakSelf;
           
           for (NSString* notification in notifications)
           {
               if([notification isExist])
                   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceiveNotification:) name:notification object:nil];
           }
                      
           weakSelf.mt_notifications = notifications;
           return weakSelf;
       };
       
       return bindNotifications;
}

-(void)whenReceiveNotification:(NSNotification *)info
{
    if(self.mt_notificationHandle)
        self.mt_notificationHandle(info);
}

-(void)whenDealloc
{
    self.mt_notifications = nil;
}

-(void)setMt_notifications:(NSArray<NSString *> *)mt_notifications
{
    for(NSString* notification in self.mt_notifications)
        [[NSNotificationCenter defaultCenter] removeObserver:self name: notification object:nil];
    
    objc_setAssociatedObject(self, @selector(mt_notifications), mt_notifications, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSArray<NSString *> *)mt_notifications
{
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation NSObject (Copy)

-(NSInteger)bindNotification{return 0;}
-(NSInteger)objects{return 0;}

- (instancetype)copyObject
{
    return  [[self class] mj_objectWithKeyValues:[self mj_keyValues]];
}

- (BOOL)isContainProperty:(NSString*)propertyName
{
    Class myClass = [self class];
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++)
    {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSLog(@"%@",keyName);
        if ([keyName isEqualToString:propertyName])
            return YES;
    }
    return NO;
}

@end



MTDelegateCollectionViewSpacing mt_collectionViewSpacingMake(CGFloat minLineSpacing, CGFloat minItemSpacing,UIEdgeInsets sectionInset)
{
    MTDelegateCollectionViewSpacing spacing = {minLineSpacing, minItemSpacing, sectionInset};
    return spacing;
}


NSReuseObject* mt_reuse(id data)
{
    NSReuseObject* obj = [NSReuseObject new];
    obj.data = data;
    
    return obj;
}

NSReuseObject* mt_empty()
{
    NSReuseObject* obj = [NSReuseObject new];
    obj.data = @{};
    
    return obj;
}

NSWeakReuseObject* mt_weakReuse(id data)
{
    NSWeakReuseObject* obj = [NSWeakReuseObject new];
    obj.data = data;
    
    return obj;
}


@implementation NSArray(ReuseIdentifier)

-(NSObject*)getDataByIndex:(NSInteger)index
{
    if(index >= self.count)
        return nil;
    
    NSObject* data = self[index];
    
    if(![data isKindOfClass:[NSObject class]])
        return nil;
    
    if(!data.mt_reuseIdentifier && [data isKindOfClass:[NSString class]])
        data.mt_reuseIdentifier = (NSString*)data;
    
    if(!data.mt_reuseIdentifier && [data isKindOfClass:[NSReuseObject class]] && [((NSReuseObject*)data).data isKindOfClass:[NSString class]])
        data.mt_reuseIdentifier = (NSString*)((NSReuseObject*)data).data;
    
    return data;
}

-(BOOL)isAllArray
{
    BOOL isAllArr = YES;
    for(NSObject* obj in self)
    {
        if([obj isKindOfClass:[NSArray class]])
            continue;
        
        isAllArr = false;
        break;
    }
    
    return isAllArr;
}

@end

