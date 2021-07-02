//
//  UIView+Delegate.m
//  MDKit
//
//  Created by monda on 2019/5/15.
//  Copyright © 2019 monda. All rights reserved.
//

#import "UIView+Delegate.h"
#import "MTDataSource.h"
#import "MTContentModelPropertyConst.h"

#import <objc/runtime.h>


@implementation UIView (Delegate)

-(void)setupDefault
{
    [super setupDefault];
    
    if([self.viewModel respondsToSelector:@selector(setupDefault)])
        [self.viewModel setupDefault];
}

#pragma mark - MDExchangeDataProtocol代理

-(void)whenGetResponseObject:(NSObject *)object{}

-(void)setSuperResponseObject:(NSObject*)object{}

-(NSDictionary *)giveSomeThingToYou
{
    return nil;
}

-(void)giveSomeThingToMe:(id)obj WithOrder:(NSString *)order{}

-(Class)classOfResponseObject
{
    return nil;
}

-(void)setViewModel:(NSObject<MTViewModelProtocol> *)viewModel
{
    if([viewModel respondsToSelector:@selector(whenGetResponseObject:)])
        [viewModel whenGetResponseObject:self];
    
    objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject<MTViewModelProtocol> *)viewModel
{
    NSObject<MTViewModelProtocol>* viewModel = objc_getAssociatedObject(self, _cmd);
    if(!viewModel && self.viewModelClass)
    {
        viewModel = NSClassFromString(self.viewModelClass).new;
        self.viewModel = viewModel;
    }
    
    return viewModel;
}


- (NSString *)viewModelClass
{
    return nil;
}

@end



@implementation UIScrollView (MTList)

-(instancetype)setWithObject:(NSObject *)obj
{
    if(![obj isKindOfClass:[MTDataSourceModel class]])
        return [super setWithObject:obj];
    
    self.dataSourceModel = (MTDataSourceModel*)obj;
    return self;
}

- (void)addTarget:(id)target
{
    [self addTarget:target EmptyData:nil DataList:nil SectionList:nil];
}

- (void)addTarget:(id)target EmptyData:(NSObject*)emptyData DataList:(NSArray*)dataList SectionList:(NSArray*)sectionList
{
    if(dataList && [self.viewModel respondsToSelector:@selector(newDataList:)])
        dataList = [self.viewModel newDataList:dataList];
    
    if(![self isKindOfClass:[UITableView class]] && ![self isKindOfClass:[UICollectionView class]])
        return;
    
//    if([self.cellStateArray.mt_order containsString:@"MTCellKeepStateOrder"])
//        self.cellStateArray.mt_order = nil;
    
    NSString* key = [self isKindOfClass:[UITableView class]] ? @"tableView" : @"collectionView";
    
    MTDataSource* dataSource = [MTDataSource new];
    [dataSource setValue:self forKey:key];
    dataSource.delegate = target;
    
    dataSource.emptyData = emptyData;
    dataSource.dataList = dataList;
    dataSource.sectionList = sectionList;
    
    self.delegate = dataSource;    
    [self setValue:dataSource forKey:@"dataSource"];
    
    self.mt_dataSource = dataSource;
}

- (void)reloadDataWithDataList:(NSArray*)dataList
{
    [self reloadDataWithDataList:dataList EmptyData:nil];
}

- (void)reloadDataWithDataList:(NSArray*)dataList EmptyData:(NSObject*)emptyData
{
    [self reloadDataWithDataList:dataList SectionList:nil EmptyData:emptyData];
}

- (void)reloadDataWithDataList:(NSArray*)dataList SectionList:(NSArray*)sectionList
{
    [self reloadDataWithDataList:dataList SectionList:sectionList EmptyData:nil];
}

- (void)reloadDataWithDataList:(NSArray*)dataList SectionList:(NSArray*)sectionList EmptyData:(NSObject*)emptyData
{
    if([self.viewModel respondsToSelector:@selector(newDataList:)])
        dataList = [self.viewModel newDataList:dataList];
    
    if(![self isKindOfClass:[UITableView class]] && ![self isKindOfClass:[UICollectionView class]])
        return;
    
//    if([self.cellStateArray.mt_order containsString:@"MTCellKeepStateOrder"])
//    {
//        if(self.cellStateArray.mt_order.mt_tag != kNew)
//            self.cellStateArray.mt_order = nil;
//        else
//            self.cellStateArray.mt_order.bindEnum(kOld);
//    }
    
    self.mt_dataSource.emptyData = emptyData;
    self.mt_dataSource.dataList = dataList;
    self.mt_dataSource.sectionList = sectionList;
    
    if([self.mt_dataSource.delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
        [self.mt_dataSource.delegate doSomeThingForMe:self.mt_dataSource withOrder:@"MTDataSourceReloadDataBeforeOrder"];
        
    [self performSelector:@selector(reloadData)];
    
    if([self.mt_dataSource.delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
    [self.mt_dataSource.delegate doSomeThingForMe:self.mt_dataSource withOrder:@"MTDataSourceReloadDataAfterOrder"];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([self.viewModel respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)])
        return [self.viewModel gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    
    return false;
}

-(void)setMt_dataSource:(MTDataSource *)mt_dataSource
{
    objc_setAssociatedObject(self, @selector(mt_dataSource), mt_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MTDataSource *)mt_dataSource
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDataSourceModel:(MTDataSourceModel *)dataSourceModel
{
    objc_setAssociatedObject(self, @selector(dataSourceModel), dataSourceModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(dataSourceModel.dataList || dataSourceModel.sectionList || dataSourceModel.emptyData)
    [self reloadDataWithDataList:dataSourceModel.dataList SectionList:dataSourceModel.sectionList EmptyData:dataSourceModel.emptyData];
}

-(MTDataSourceModel *)dataSourceModel
{
    MTDataSourceModel* dataSourceModel = objc_getAssociatedObject(self, _cmd);
    if(!dataSourceModel)
    {
        dataSourceModel = MTDataSourceModel.new;
        dataSourceModel.scrollView = self;
        self.dataSourceModel = dataSourceModel;
    }
    
    return dataSourceModel;
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{    
    objc_setAssociatedObject(self, @selector(currentIndex), @(currentIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)currentIndex
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setCurrentSection:(NSInteger)currentSection
{
    objc_setAssociatedObject(self, @selector(currentSection), @(currentSection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)currentSection
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end


@implementation UIScrollView (Direction)

-(void)setDirectionXTag:(NSNumber*)directionXTag
{
    objc_setAssociatedObject(self, @selector(directionXTag), directionXTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)directionXTag
{
    return ((NSNumber*)objc_getAssociatedObject(self, _cmd)).integerValue;
}

-(void)setDirectionYTag:(NSNumber*)directionYTag
{
    objc_setAssociatedObject(self, @selector(directionYTag), directionYTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)directionYTag
{
    return ((NSNumber*)objc_getAssociatedObject(self, _cmd)).integerValue;
}

@end

