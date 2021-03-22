//
//  MTDataSourceModel.h
//  MDKit
//
//  Created by monda on 2019/5/16.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDataSourceModel : NSObject

@property (nonatomic,strong,readonly) NSString* className;

@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) NSArray* sectionList;

@property (nonatomic,strong) NSObject* emptyData;

@property (nonatomic,weak) UIScrollView* scrollView;

-(void)reloadListView;
-(void)reloadListView:(UIScrollView*)listView;

@end

CG_EXTERN NSArray* mt_dataList(NSObject* dataList);
CG_EXTERN NSArray* mt_sectionList(NSObject* sectionList);
CG_EXTERN NSObject* mt_emptyData(NSObject* emptyData);
