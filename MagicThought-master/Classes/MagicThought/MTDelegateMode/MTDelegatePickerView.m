//
//  MTDelegatePickerView.m
//  DaYiProject
//
//  Created by monda on 2018/9/20.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDelegatePickerView.h"
#import "MTDataSource.h"




@interface MTDelegatePickerView()

@property (nonatomic,strong) MTDataSource* mt_dataSource;

@end


@implementation MTDelegatePickerView

- (void)addTarget:(id<UIPickerViewDataSource,MTDelegatePickerViewDelegate>)target
{
    [self addTarget:target DataList:nil];
}

- (void)addTarget:(id<UIPickerViewDataSource,MTDelegatePickerViewDelegate>)target  DataList:(NSArray*)dataList
{
    MTDataSource* dataSource = [MTDataSource new];
    
    [dataSource setValue:self forKey:@"pickView"];
    dataSource.delegate = target;
    
    dataSource.dataList = dataList;
    
    self.dataSource = dataSource;
    self.delegate = dataSource;
    self.mt_dataSource = dataSource;
}

- (void)reloadDataWithDataList:(NSArray*)dataList
{
    self.mt_dataSource.dataList = dataList;
    
    [self reloadAllComponents];
}

-(NSObject*)getDataForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.mt_dataSource performSelector:@selector(getDataForIndexPath:) withObject:[NSIndexPath indexPathForRow:row inSection:component]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.separatorColor)
        for(UIView *singleLine in self.subviews)
            if (singleLine.frame.size.height < 1)
                singleLine.backgroundColor = self.separatorColor;
}

@end
