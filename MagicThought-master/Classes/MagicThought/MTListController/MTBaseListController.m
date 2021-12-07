//
//  MTBaseListController.m
//  QXProject
//
//  Created by monda on 2019/12/4.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseListController.h"
#import "MTDataSourceModel.h"
#import "NSString+Exist.h"
#import "UIView+Frame.h"

@interface MTBaseListController ()
{
    UICollectionViewFlowLayout* _collectionViewFlowLayout;
}
@property (nonatomic,strong) MTDataSourceModel* dataModel;

@end

@implementation MTBaseListController

#pragma mark - 生命周期

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    [self startRequest];
}

#pragma mark - 网络请求

-(void)loadData
{
    if(!self.mtListView)
        return;
    NSArray* dataList;
    NSArray* sectionList;
    NSObject* emptyData;
    
    if([self respondsToSelector:@selector(dataList)])
        dataList = self.dataList;
    
    if([self respondsToSelector:@selector(sectionList)])
        sectionList = self.sectionList;
    
    if([self respondsToSelector:@selector(emptyData)])
        emptyData = self.emptyData;
    
    if(!dataList)
        dataList = self.dataModel.dataList;
    if(!sectionList)
        sectionList = self.dataModel.sectionList;
    if(!emptyData)
        emptyData = self.dataModel.emptyData;
    
    [self.mtListView reloadDataWithDataList:dataList  SectionList:sectionList EmptyData:emptyData];
}

-(void)doSomeThingForMe:(id)obj withOrder:(NSString *)order
{
    if([order isEqualToString:@"MTDataSourceReloadDataBeforeOrder"])
    {
        if(!self.adjustListViewHeightByData)
            return;
        NSArray* dataList = [obj valueForKey:@"dataList"];
        NSArray* sectionList = [obj valueForKey:@"sectionList"];
        NSArray* emptyData = [obj valueForKey:@"emptyData"];
        
        [self adjustListViewHeightWithDataList:dataList SectionList:sectionList EmptyData:emptyData];
    }
}

-(void)adjustListViewHeightWithDataList:(NSArray*)dataList SectionList:(NSArray*)sectionList EmptyData:(NSObject*)emptyData
{
    if(self.mtListView != _mtBase_tableView && self.mtListView != _mtBase_collectionView)
        return;
    
    CGFloat height = 0;
    if(dataList.count)
    {
        for (NSArray* arr in dataList) {
            if(![arr isKindOfClass:[NSArray class]])
                return;
            
            for(NSObject* obj in arr)
            {
                if(![obj isKindOfClass:[NSObject class]])
                    return;
                
                height += obj.mt_itemHeight;
            }
        }
        
        NSInteger index = -1;
        for (NSArray* arr in sectionList) {
            index++;
            if(index > 1) break;
                
            if(![arr isKindOfClass:[NSArray class]])
                return;
            
            for(NSObject* obj in arr)
            {
                if(![obj isKindOfClass:[NSObject class]])
                    return;
                
                height += obj.mt_itemHeight;
            }
        }
    }
    else
    {
        height += emptyData.mt_itemHeight;
        if(emptyData.mt_headerEmptyShow)
        {
            if(sectionList.count > 0)
            {
                NSArray* arr = sectionList[0];
                if(arr.count > 0)
                    height += ((NSObject*)arr[0]).mt_itemHeight;
            }
        }
    }
    
    height += (self.mtListView.contentInset.top + self.mtListView.contentInset.bottom);
    if(self.mtListView == self.mtBase_tableView)
        height += (self.mtBase_tableView.tableHeaderView.height + self.mtBase_tableView.tableFooterView.height);
    self.mtListView.height = height;
}

#pragma mark - 重载方法


#pragma mark - 懒加载

- (MTDelegateTableView *)mtBase_tableView
{
    if (_mtBase_tableView == nil) {
                
        _mtBase_tableView = [[MTDelegateTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mtBase_tableView.backgroundColor = [UIColor clearColor];
        _mtBase_tableView.showsVerticalScrollIndicator = false;
        _mtBase_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtBase_tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        //防止分页漂移
        _mtBase_tableView.estimatedRowHeight = 0;
        _mtBase_tableView.estimatedSectionHeaderHeight = 0;
        _mtBase_tableView.estimatedSectionFooterHeight = 0;
        [_mtBase_tableView addTarget:self];
//        在设置代理前设置tableFooterView，上边会出现多余间距，谨记谨记
        _mtBase_tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *))
            _mtBase_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _mtBase_tableView;
}

-(MTDragCollectionView *)mtBase_collectionView
{
    if(!_mtBase_collectionView)
    {
        _mtBase_collectionView = [[MTDragCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _mtBase_collectionView.backgroundColor = [UIColor clearColor];
        _mtBase_collectionView.showsVerticalScrollIndicator = false;
        _mtBase_collectionView.showsHorizontalScrollIndicator = false;
        _mtBase_collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight_mt(), 0);
        
        
        [_mtBase_collectionView addTarget:self];
        if (@available(iOS 11.0, *))
            _mtBase_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _mtBase_collectionView;
}

-(UIScrollView *)mtListView
{
    return self.mtBase_collectionView;
}

-(MTDataSourceModel *)dataModel
{
    if(!_dataModel && [self.dataModelClassName isExist])
    {
        Class c = NSClassFromString(self.dataModelClassName);
                
        if(![c isSubclassOfClass:[MTDataSourceModel class]])
            return nil;
             
        _dataModel = [c.new setWithObject:NSStringFromClass(self.class)];
    }
    
    return _dataModel;
}

-(NSString *)dataModelClassName
{
    return nil;
}

-(void)setEmptyData:(NSObject *)emptyData
{
    _realEmptyData = emptyData;
    [self loadData];
}

-(NSObject *)emptyData
{
    return self.realEmptyData;
}

-(void)setDataList:(NSArray *)dataList
{
    _realDataList = dataList;
    [self loadData];
}

-(NSArray *)dataList
{
    return self.realDataList;
}

-(void)setTenScrollDataList:(NSArray *)tenScrollDataList
{
    _realTenScrollDataList = tenScrollDataList;
    [self loadData];
}

-(NSArray *)tenScrollDataList
{
    return self.realTenScrollDataList;
}

-(void)setSectionList:(NSArray *)sectionList
{
    _realSectionList = sectionList;
    [self loadData];
}

-(NSArray *)sectionList
{
    return self.realSectionList;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout
{
    if(!_collectionViewFlowLayout)
    {
        _collectionViewFlowLayout = [self createCollectionViewFlowLayout];
    }
    
    return _collectionViewFlowLayout;
}

-(UICollectionViewFlowLayout*)createCollectionViewFlowLayout
{
    return [UICollectionViewFlowLayout new];
}

-(NSMutableArray *)modelArray
{
    if(!_modelArray)
    {
        _modelArray = NSMutableArray.new;
    }
    
    return _modelArray;
}

@end
