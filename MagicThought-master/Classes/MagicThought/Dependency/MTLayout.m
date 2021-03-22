//
//  MTLayout.m
//  QXProject
//
//  Created by monda on 2020/9/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTLayout.h"
#import "UIView+Frame.h"
#import "MTConst.h"
#import "objc/runtime.h"
#import "NSObject+ReuseIdentifier.h"

NSString* kX = @"x";
NSString* kCenterX = @"centerX";
NSString* kMaxX = @"maxX";
NSString* kWidth = @"width";

NSString* kY = @"y";
NSString* kCenterY = @"centerY";
NSString* kMaxY = @"maxY";
NSString* kHeight = @"height";

NSString* kLeft = @"left";
NSString* kRight = @"right";
NSString* kTop = @"top";
NSString* kBottom = @"bottom";


#define createLayoutEdge(edgeKey, keyName)\
-(MTLayoutEdge *)edgeKey{\
if(!_##edgeKey){\
        _##edgeKey = [MTLayoutEdge new];\
        _##edgeKey.key = keyName; \
    }\
    return _##edgeKey;\
}

#define createMutableStringArray(name)\
-(NSMutableArray<NSString *> *)name{\
if(!_##name){_##name = [NSMutableArray array];}\
    return _##name;\
}

#define createLayoutKey(layoutKey, keyName,horizontal)\
-(MTLayoutFrame *)layoutKey{\
    [self setLayoutKey:keyName isHorizontal:horizontal];\
    return self;\
}

@interface UIView ()

@property (nonatomic,strong) MTLayoutFrame* layoutFrame;

@end

@interface MTLayoutEdge : NSObject

@property (nonatomic,assign) BOOL isLayout;

@property (nonatomic,strong) NSNumber* value;

@property (nonatomic,strong) NSString* key;

@end

@implementation MTLayoutEdge

-(NSNumber *)value
{
    if(!_value)
        _value = @(0);    
    
    return _value;
}

@end


@interface MTLayoutFrame ()

@property (nonatomic,strong) NSMutableArray<NSString*>* horizontalKeyArray;
@property (nonatomic,strong) NSMutableArray<NSString*>* verticalKeyArray;

@property (nonatomic,strong) NSDictionary* horizontalLayoutKeys;
@property (nonatomic,strong) NSDictionary<NSString*, MTLayoutEdge*>* horizontalEdgeKeys;

@property (nonatomic,strong) NSDictionary* verticalLayoutKeys;
@property (nonatomic,strong) NSDictionary<NSString*, MTLayoutEdge*>* verticalEdgeKeys;

@property (nonatomic,strong) NSMutableArray<NSString*>* horizontalEdgeKeyArray;
@property (nonatomic,strong) NSMutableArray<NSString*>* verticalEdgeKeyArray;


@property (nonatomic,weak) UIView* view;

@property (nonatomic,strong) NSString* currentKey;

@property (nonatomic,strong) MTLayoutEdge* leftKey;

@property (nonatomic,strong) MTLayoutEdge* rightKey;

@property (nonatomic,strong) MTLayoutEdge* topKey;

@property (nonatomic,strong) MTLayoutEdge* bottomKey;

@property (nonatomic,strong) MTLayoutEdge* centerXKey;

@property (nonatomic,strong) MTLayoutEdge* centerYKey;

@property (nonatomic,assign) BOOL isFinishEqualOrOffset;

@end

@implementation MTLayoutFrame

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:[UIView class]])
        self.view = (UIView*)obj;
    
    return self;
}

-(MTLayoutFrame *(^)(NSObject* obj))equalTo
{
        __weak __typeof(self) weakSelf = self;
    return ^(NSObject* obj)
    {
        return [weakSelf setEqualLayoutWithObject:obj];
    };
}

-(MTLayoutFrame *(^)(CGFloat))equalToValue
{
    __weak __typeof(self) weakSelf = self;
    return ^(CGFloat value)
    {
        return [weakSelf setEqualLayoutWithObject:@(value)];
    };
}

-(MTLayoutFrame*)setEqualLayoutWithObject:(NSObject*)obj
{
    if(self.verticalKeyArray.count)
        [self setEqualLayoutWithObject:obj isHorizontal:false];
    if(self.horizontalKeyArray.count)
        [self setEqualLayoutWithObject:obj isHorizontal:YES];
    self.isFinishEqualOrOffset = YES;
    return self;
}

-(void)setEqualLayoutWithObject:(NSObject*)obj isHorizontal:(BOOL)isHorizontal
{
    NSMutableArray<NSString*>* keyArray = isHorizontal ? self.horizontalKeyArray : self.verticalKeyArray;
        
    if(!keyArray.count)
        isHorizontal ? [[self left] right] : [[self top] bottom];
        
    if(keyArray.count < 2)
    {
        [self setSingleKey:keyArray.firstObject WithObject:obj isHorizontal:isHorizontal];
        return;
    }
     
    NSString* sizeKey = isHorizontal ? kWidth : kHeight;
    if([keyArray.lastObject isEqualToString:sizeKey])
    {
        NSString* key1 = keyArray.firstObject;
        keyArray[0] = keyArray.lastObject;
        keyArray[1] = key1;
    }
    
    for(NSString* key in keyArray)
        [self setSingleKey:key WithObject:obj isHorizontal:isHorizontal];
}

-(void)setSingleKey:(NSString*)key WithObject:(NSObject*)obj isHorizontal:(BOOL)isHorizontal
{
    [self configEdgeKey:key isHorizontal:isHorizontal];
    
    NSString* edgeKey1 = isHorizontal ? kLeft : kTop;
    NSString* edgeKey2 = isHorizontal ? kRight : kBottom;
    NSString* edgeKey3 = isHorizontal ? kCenterX : kCenterY;
    
    NSNumber* value;
    if([obj isKindOfClass:[NSNumber class]])
        value = (NSNumber*)obj;
    else
    {
        MTLayoutFrame* layoutFrame;
        NSString* currentKey;
        if([obj isKindOfClass:[MTLayoutFrame class]])
        {
            layoutFrame = (MTLayoutFrame*)obj;
            currentKey = layoutFrame.currentKey;
        }
        
        if([obj isKindOfClass:[UIView class]])
        {
            layoutFrame = ((UIView*)obj).layoutFrame;
            currentKey = key;
        }
                    
        if([currentKey isEqualToString:edgeKey1] || [currentKey isEqualToString:edgeKey2])
        {
            if([currentKey isEqualToString:edgeKey1])
                value = @(isHorizontal ? layoutFrame.view.x : layoutFrame.view.y);
            else
            {
                if(self.view.superview == layoutFrame.view.superview)
                    value = @(isHorizontal ? layoutFrame.view.maxX : layoutFrame.view.maxY);
                else if(self.view.superview == layoutFrame.view)
                    value = @(isHorizontal ? layoutFrame.view.width : layoutFrame.view.height);
            }
        }
        else if([currentKey isEqualToString: edgeKey3])
        {
            if(self.view.superview == layoutFrame.view.superview)
                value = @(isHorizontal ? layoutFrame.view.centerX : layoutFrame.view.centerY);
            else if(self.view.superview == layoutFrame.view)                
                value = @(half(isHorizontal ? layoutFrame.view.width : layoutFrame.view.height));
        }
        else
            value = [layoutFrame.view valueForKey:currentKey];
    }
     
    if(value)
        [self setKey:key WithNumber:@(value.integerValue) isHorizontal:isHorizontal];
}

-(void)setKey:(NSString*)key WithNumber:(NSNumber*)value isHorizontal:(BOOL)isHorizontal
{
    MTLayoutEdge* edge1 = isHorizontal ? self.leftKey : self.topKey;
    NSString* edgeKey1 = isHorizontal ? kLeft : kTop;
    
    MTLayoutEdge* edge2 = isHorizontal ? self.rightKey : self.bottomKey;
    NSString* edgeKey2 = isHorizontal ? kRight : kBottom;
    
    MTLayoutEdge* edge3 = isHorizontal ? self.centerXKey : self.centerYKey;
    NSString* edgeKey3 = isHorizontal ? kCenterX : kCenterY;
    
    if([key isEqualToString:isHorizontal ? kWidth : kHeight])
    {
        [self.view setValue:value forKey:key];
        if(edge1.isLayout)
        {
            [self.view setValue:edge1.value forKey:edge1.key];
        }
        if(edge2.isLayout)
        {
            [self.view setValue:edge2.value forKey:edge2.key];
        }
        if(edge3.isLayout)
        {
            [self.view setValue:edge3.value forKey:edge3.key];
        }
        return;
    }
    
    if([key isEqualToString:edgeKey1] || [key isEqualToString:edgeKey2] || [key isEqualToString:edgeKey3])
    {
        if([key isEqualToString:edgeKey1])
            edge1.value = value;
        else if([key isEqualToString:edgeKey2])
            edge2.value = value;
        else
            edge3.value = value;
            
        if(edge1.isLayout && edge2.isLayout)
        {
            [self.view setValue:@(fabs(edge1.value.floatValue - edge2.value.floatValue)) forKey:isHorizontal ? kWidth : kHeight];
            [self.view setValue:edge1.value forKey:edge1.key];
            return;
        }
        
        if(edge1.isLayout && edge3.isLayout)
        {
            [self.view setValue:@(doubles(fabs(edge1.value.floatValue - edge3.value.floatValue))) forKey:isHorizontal ? kWidth : kHeight];
            [self.view setValue:edge3.value forKey:edge3.key];
            return;
        }
        
        if(edge2.isLayout && edge3.isLayout)
        {
            [self.view setValue:@(doubles(fabs(edge2.value.floatValue - edge3.value.floatValue))) forKey:isHorizontal ? kWidth : kHeight];
            [self.view setValue:edge3.value forKey:edge3.key];
            return;
        }
        
        if([key isEqualToString:edgeKey1])
            [self.view setValue:edge1.value forKey:edge1.key];
        else if([key isEqualToString:edgeKey2])
            [self.view setValue:edge2.value forKey:edge2.key];
        else
            [self.view setValue:edge3.value forKey:edge3.key];
        
        return;
    }
    
    [self.view setValue:value forKey:key];
}

-(void (^)(CGFloat))offset
{
    __weak __typeof(self) weakSelf = self;
    return ^(CGFloat offset){
        [weakSelf setOffsetWithValue:offset];
    };
}

-(void)setOffsetWithValue:(CGFloat)offset
{
    if(self.verticalKeyArray.count)
        [self setOffsetWithValue:offset isHorizontal:false];
    if(self.horizontalKeyArray.count)
        [self setOffsetWithValue:offset isHorizontal:YES];
    self.isFinishEqualOrOffset = YES;
}

-(void)setOffsetWithValue:(CGFloat)offset isHorizontal:(BOOL)isHorizontal
{
    NSMutableArray<NSString*>* keyArray = isHorizontal ? self.horizontalKeyArray : self.verticalKeyArray;
    if(!keyArray.count)
        isHorizontal ? [[self x] width] : [[self y] height];
    
    if(keyArray.count < 2)
    {
        [self setKey:keyArray.firstObject WithOffset:offset isHorizontal:isHorizontal];
        return;
    }
    
    NSString* sizeKey = isHorizontal ? kWidth : kHeight;
    if([keyArray.lastObject isEqualToString:sizeKey])
    {
        NSString* key1 = keyArray.firstObject;
        keyArray[0] = keyArray.lastObject;
        keyArray[1] = key1;
    }
    
    for(NSString* key in keyArray)
        [self setKey:key WithOffset:offset isHorizontal:isHorizontal];
}

-(void)setKey:(NSString*)key WithOffset:(CGFloat)offset isHorizontal:(BOOL)isHorizontal
{
    [self configEdgeKey:key isHorizontal:isHorizontal];
    
    NSString* edgeKey1 = isHorizontal ? kLeft : kTop;
    NSString* edgeKey2 = isHorizontal ? kRight : kBottom;
    
    if([key isEqualToString:edgeKey1] || [key isEqualToString:edgeKey2])
    {
        MTLayoutEdge* edge;
        if([key isEqualToString:edgeKey1])
            edge = isHorizontal ? self.leftKey : self.topKey;
        else
            edge = isHorizontal ? self.rightKey : self.bottomKey;
        
        edge.value = @(offset + edge.value.floatValue);
        [self setKey:key WithNumber:edge.value isHorizontal:isHorizontal];
        return;
    }
    
    NSNumber* value = [self.view valueForKey:key];
    if(![value isKindOfClass:[NSNumber class]])
        return;
    
    [self setKey:key WithNumber:@(value.floatValue + offset) isHorizontal:isHorizontal];
}

#pragma mark - 批量加入的约束
-(void)setLayoutKey:(NSString*)key isHorizontal:(BOOL)isHorizontal
{
    NSMutableArray* array = isHorizontal ? self.horizontalKeyArray : self.verticalKeyArray;
    NSDictionary* layoutKeys = isHorizontal ? self.horizontalLayoutKeys : self.verticalLayoutKeys;
    NSDictionary<NSString*, MTLayoutEdge*>* edgeKeys = isHorizontal ? self.horizontalEdgeKeys : self.verticalLayoutKeys;
    
    if(array.count < 2)
    {
        if(!array.count)
            [array addObject:key];
        else
        {
            if([array.firstObject isEqualToString:key])
                return;
                            
            if((layoutKeys[array.firstObject] && layoutKeys[key]) ||
               (layoutKeys[array.firstObject] && edgeKeys[key]) ||
               (edgeKeys[array.firstObject] && layoutKeys[key]))
            {
                array[0] = key;
                return;
            }
            
            [array addObject:key];
        }
        return;
    }
    
    if([array.lastObject isEqualToString:key])
        return;
    
    if((layoutKeys[array.lastObject] && layoutKeys[key]) ||
       (layoutKeys[array.lastObject] && edgeKeys[key]) ||
       (edgeKeys[array.lastObject] && layoutKeys[key]))
    {
        array[1] = key;
        return;
    }
    
    NSString* key0 = array.lastObject;
    array[0] = key0;
    array[1] = key;
}

-(void)setEdgeKey:(NSString*)key isHorizontal:(BOOL)isHorizontal
{
    NSMutableArray<NSString*>* array = isHorizontal ? self.horizontalEdgeKeyArray : self.verticalEdgeKeyArray;
    NSDictionary<NSString*, MTLayoutEdge*>* edgeKeys = isHorizontal ? self.horizontalEdgeKeys : self.verticalEdgeKeys;
    if(!([key isEqualToString: isHorizontal ? kWidth : kHeight] || edgeKeys[key]))
        return;
    
    if(array.count < 2)
    {
        if([array.firstObject isEqualToString:key])
            return;
       [array addObject:key];
        return;
    }
       
    if([array.lastObject isEqualToString:key])
        return;
    
    if(edgeKeys[array.firstObject])
        edgeKeys[array.firstObject].isLayout = false;
    
    NSString* key0 = array.lastObject;
    array[0] = key0;
    array[1] = key;
}

-(void)configEdgeKey:(NSString*)key isHorizontal:(BOOL)isHorizontal
{
    if(self.isFinishEqualOrOffset)
        return;
        
    NSDictionary<NSString*, MTLayoutEdge*>* edgeKeys = isHorizontal ? self.horizontalEdgeKeys : self.verticalLayoutKeys;
    NSString* sizeKey = isHorizontal ? kWidth : kHeight;
    
    if(edgeKeys[key])
        edgeKeys[key].isLayout = YES;
    else if(![key isEqualToString:sizeKey])
    {
        if(isHorizontal)
            self.centerXKey.isLayout = self.leftKey.isLayout = self.rightKey.isLayout = false;
        else
            self.centerYKey.isLayout = self.topKey.isLayout = self.bottomKey.isLayout = false;
    }
    [self setEdgeKey:key isHorizontal:isHorizontal];
}


createLayoutKey(x, kX, YES)
createLayoutKey(left, kLeft, YES)
createLayoutKey(centerX, kCenterX, YES)
createLayoutKey(maxX, kMaxX, YES)
createLayoutKey(right, kRight, YES)
createLayoutKey(width, kWidth, YES)

createLayoutKey(y, kY, false)
createLayoutKey(top, kTop, false)
createLayoutKey(centerY, kCenterY, false)
createLayoutKey(maxY, kMaxY, false)
createLayoutKey(bottom, kBottom, false)
createLayoutKey(height, kHeight, false)

createLayoutEdge(leftKey, kX)
createLayoutEdge(rightKey, kMaxX)
createLayoutEdge(topKey, kY)
createLayoutEdge(bottomKey, kMaxY)
createLayoutEdge(centerXKey, kCenterX)
createLayoutEdge(centerYKey, kCenterY)

-(MTLayoutFrame *)edge
{
    [self left];
    [self top];
    [self right];
    [self bottom];
    return self;
}

createMutableStringArray(horizontalKeyArray)
createMutableStringArray(verticalKeyArray)

createMutableStringArray(horizontalEdgeKeyArray)
createMutableStringArray(verticalEdgeKeyArray)

-(NSDictionary<NSString*, MTLayoutEdge*> *)horizontalEdgeKeys
{
    return @{
        kLeft : self.leftKey,
        kRight : self.rightKey,
        kCenterX : self.centerXKey,
    };
}

-(NSDictionary *)horizontalLayoutKeys
{
    return @{
        kX : kX,
        kMaxX : kMaxX
    };
}

-(NSDictionary<NSString*, MTLayoutEdge*> *)verticalEdgeKeys
{
    return @{
        kTop : self.topKey,
        kBottom : self.bottomKey,
        kCenterY : self.centerYKey,
    };
}

-(NSDictionary *)verticalLayoutKeys
{
    return @{
        kY : kY,
        kMaxY : kMaxY
    };
}


@end


#define addLayout(property, key) \
-(MTLayoutFrame *)property##_mt{\
[self.layoutFrame.horizontalKeyArray removeAllObjects];\
[self.layoutFrame.verticalKeyArray removeAllObjects];\
self.layoutFrame.isFinishEqualOrOffset = false;\
self.layoutFrame.currentKey = key;\
[self.layoutFrame property];\
return self.layoutFrame;\
}

@implementation UIView (MTLayoutFrame)

-(MTLayoutFrame *)layoutFrame
{
    MTLayoutFrame* layoutFrame = objc_getAssociatedObject(self, _cmd);
    if(!layoutFrame)
    {
        layoutFrame = MTLayoutFrame.new(self);
        objc_setAssociatedObject(self, _cmd, layoutFrame, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return layoutFrame;
}


addLayout(x, kX)
addLayout(centerX, kCenterX)
addLayout(maxX, kMaxX)
addLayout(left, kLeft)
addLayout(right, kRight)
addLayout(width, kWidth)

addLayout(y, kY)
addLayout(centerY, kCenterY)
addLayout(maxY, kMaxY)
addLayout(top, kTop)
addLayout(bottom, kBottom)
addLayout(height, kHeight)

addLayout(edge, nil)

@end
