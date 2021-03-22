//
//  MTDataSourceModel.m
//  MDKit
//
//  Created by monda on 2019/5/16.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDataSourceModel.h"
#import "NSObject+ReuseIdentifier.h"
#import "UIView+Delegate.h"
#import "NSString+Exist.h"
#import <MJRefresh/MJRefresh.h>

@implementation MTDataSourceModel

-(void)reloadListView
{
    [self reloadListView:self.scrollView];
}

-(void)reloadListView:(UIScrollView*)listView
{
    [listView reloadDataWithDataList:self.dataList SectionList:self.sectionList EmptyData:self.emptyData];
}

-(instancetype)setWithObject:(NSObject *)obj
{
    [super setWithObject:obj];
    
    if([obj.mt_keyName isExist])
    {
        [self setValue:obj forKey:obj.mt_keyName];
        return self;
    }
    
    if([obj isKindOfClass:[NSString class]])
        _className = (NSString*)obj;
            
    return self;
}


@end

NSArray* mt_dataList(NSObject* dataList)
{
    return (NSArray*)dataList.bindKey(@"dataList");
}
NSArray* mt_sectionList(NSObject* sectionList)
{
    return (NSArray*)sectionList.bindKey(@"sectionList");
}
NSObject* mt_emptyData(NSObject* emptyData)
{
    return (NSObject*)emptyData.bindKey(@"emptyData");
}
