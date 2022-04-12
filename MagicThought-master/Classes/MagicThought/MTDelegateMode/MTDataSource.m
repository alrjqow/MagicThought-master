//
//  MTDataSource.m
//  MonDaProject
//
//  Created by monda on 2018/6/15.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTDataSource.h"
#import "MTDelegateTableView.h"
#import "MTDelegateCollectionView.h"
#import "MTDelegatePickerView.h"
#import "MTDelegateCollectionViewCell.h"
#import "MTDelegateTableViewCell.h"
#import "MTDelegatePickerViewCell.h"
#import "MTDelegateCollectionReusableView.h"
#import "MTDelegateHeaderFooterView.h"
#import "MJRefresh.h"
#import "MTDragCollectionView.h"

#import "NSObject+ReuseIdentifier.h"
#import "UIView+Frame.h"
#import "MJExtension.h"
#import "MTContentModelPropertyConst.h"
#import "NSString+Exist.h"
#import "UIView+MTBaseViewContentModel.h"


@interface MTDelegateCollectionViewCell (Private)

@property (nonatomic,strong) NSObject* mt_data;

@end

@interface MTDelegateTableViewCell (Private)

@property (nonatomic,strong) NSObject* mt_data;

@end

@interface MTDelegateHeaderFooterView (Private)

@property (nonatomic,strong) NSObject* mt_data;

@end

@interface MTDelegateCollectionReusableView (Private)

@property (nonatomic,strong) NSObject* mt_data;

@end




#define MTEasyReuseIdentifier(id) [NSString stringWithFormat:@"mteasy_%@ReuseIdentifier",(id)]

#define MTEasyDefaultTableViewReuseIdentifier MTEasyReuseIdentifier(NSStringFromClass([MTDelegateTableViewCell class]))

#define MTEasyDefaultTableViewHeaderFooterReuseIdentifier MTEasyReuseIdentifier(NSStringFromClass([MTDelegateHeaderFooterView class]))

#define MTEasyDefaultCollectionViewReuseIdentifier MTEasyReuseIdentifier(NSStringFromClass([MTDelegateCollectionViewCell class]))

#define MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier MTEasyReuseIdentifier(NSStringFromClass([MTDelegateCollectionReusableView class]))

@interface MTDataSource()<MTDelegateProtocol>

@property (nonatomic,weak) MTDelegateTableView* tableView;

@property (nonatomic,weak) MTDelegateCollectionView* collectionView;

@property (nonatomic,weak) MTDelegatePickerView* pickView;

@property (nonatomic,assign) NSInteger sectionCount;

@property (nonatomic,assign) BOOL isEmpty;

@property (nonatomic,strong) NSMutableDictionary* registerCellList;

@property (nonatomic,strong) NSMutableDictionary* registerSectionList;

@property (nonatomic,assign) UIEdgeInsets contentInset;

@property (nonatomic,assign) CGFloat preOffsetX;
@property (nonatomic,assign) CGFloat preOffsetY;

@property (nonatomic,assign) BOOL adjustContentInset;

@property (nonatomic,strong) NSMutableDictionary<NSString*,MTDelegateCollectionViewCell*>* shadowCollectionViewCellList;

@property (nonatomic,strong) NSMutableDictionary<NSString*,MTDelegateTableViewCell*>* shadowTableViewCellList;

@property (nonatomic,strong) NSMutableDictionary<NSString*,MTDelegateCollectionReusableView*>* shadowReusableViewList;


@end



@implementation MTDataSource

+(void)load
{
    /*
     if([[[UIDevice currentDevice] systemVersion] floatValue] < 11)
     {
     class_addMethod([self class],@selector(tableView:estimatedHeightForRowAtIndexPath:),(IMP)mt_estimatedHeightForRowAtIndexPath,"f@:@@");
     
     class_addMethod([self class],@selector(tableView:estimatedHeightForHeaderInSection:),(IMP)mt_estimatedHeightForHeaderInSection,"f@:@i");
     
     class_addMethod([self class],@selector(tableView:estimatedHeightForFooterInSection:),(IMP)mt_estimatedHeightForFooterInSection,"f@:@i");
     }
     */
}

static CGFloat mt_estimatedHeightForHeaderInSection(id self, SEL cmd, UITableView * tableView, NSInteger section) {
    return tableView.halfHeight;
}
static CGFloat mt_estimatedHeightForFooterInSection(id self, SEL cmd, UITableView * tableView, NSInteger section) {
    return tableView.halfHeight;
}
static CGFloat mt_estimatedHeightForRowAtIndexPath(id self, SEL cmd, UITableView * tableView, NSIndexPath* indexPath) {
    return tableView.halfHeight;
}

/*-----------------------------------华丽分割线-----------------------------------*/

-(void)setCollectionView:(MTDelegateCollectionView *)collectionView
{
    _collectionView = collectionView;
    
    [collectionView registerClass:[MTDelegateCollectionViewCell class] forCellWithReuseIdentifier:MTEasyDefaultCollectionViewReuseIdentifier];
    
    [collectionView registerClass:[MTDelegateCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier];
    [collectionView registerClass:[MTDelegateCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier];
}

-(void)setDelegate:(id<MTDelegateProtocol,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UIPickerViewDelegate>)delegate
{
    _delegate = delegate;
    //    [self addMethod];
}

-(void)setTableView:(MTDelegateTableView *)tableView
{
    _tableView = tableView;
    
    [tableView registerClass:[MTDelegateTableViewCell class] forCellReuseIdentifier:MTEasyDefaultTableViewReuseIdentifier];
    [tableView registerClass:[MTDelegateHeaderFooterView class] forHeaderFooterViewReuseIdentifier:MTEasyDefaultTableViewHeaderFooterReuseIdentifier];
}

-(void)setDataList:(NSArray *)dataList
{
    BOOL isAllArr = YES;
    BOOL isAllMutableArr = YES;
    
    for(NSObject* obj in dataList)
    {
        if([obj isKindOfClass:[NSArray class]])
        {
            if(![obj isKindOfClass:[NSMutableArray class]])
                isAllMutableArr = false;
            continue;
        }
                    
        isAllArr = false;        
        isAllMutableArr = [dataList isKindOfClass:[NSMutableArray class]];
        break;
    }
    
    self.sectionCount = isAllArr ? dataList.count : 1;
    self.isEmpty = !self.sectionCount;
    
//    self.tableView.scrollEnabled = !(self.isEmpty && self.emptyData);
    
    if(self.isEmpty && self.emptyData)
    {
        if ((self.tableView.mj_header.state <= 1) && (self.tableView.mj_footer.state <= 1) ) {

            if(!UIEdgeInsetsEqualToEdgeInsets(self.tableView.contentInset, UIEdgeInsetsZero))
                self.contentInset = self.tableView.contentInset;
            {
                self.tableView.contentInset = UIEdgeInsetsZero;
                self.adjustContentInset = YES;
            }
        }
    }
    else
    {
        if(self.adjustContentInset)
        {
            self.tableView.contentInset = self.contentInset;
            self.adjustContentInset = false;
        }
    }
        
    _dataList = isAllArr ? dataList : @[dataList];
    
    if(isAllMutableArr && [self.collectionView isKindOfClass:[MTDragCollectionView class]])
        ((MTDragCollectionView*)self.collectionView).dragItems = (id) _dataList;
    
    if([self.collectionView.viewModel respondsToSelector:@selector(didSetDataList:)])
        [self.collectionView.viewModel didSetDataList:dataList];
    if([self.tableView.viewModel respondsToSelector:@selector(didSetDataList:)])
        [self.tableView.viewModel didSetDataList:dataList];
}

-(void)setSectionList:(NSArray *)sectionList
{
    BOOL isSingle = false;
    for(id obj in sectionList)
    {
        if([obj isKindOfClass:[NSArray class]])
            continue;
        
        isSingle = YES;
        break;
    }
    
    _sectionList = isSingle ? @[sectionList] : sectionList;
}

-(void)addMethod
{
    if(!self.pickView)
        return;
    SEL selector = @selector(pickerView:titleForRow:forComponent:);
    
    if(![self.delegate respondsToSelector:selector])
        class_addMethod([self.delegate class],selector,(IMP)mt_titleForRowAtIndexPath,"v@:@@@");
}

/*-----------------------------------华丽分割线-----------------------------------*/



-(NSObject*)getHeaderDataForSection:(NSInteger)section
{
    return [self getHeaderFooterDataForSection:section Index:0];
}

-(NSObject*)getFooterDataForSection:(NSInteger)section
{
    return [self getHeaderFooterDataForSection:section Index:1];
}


-(NSObject*)getHeaderFooterDataForSection:(NSInteger)section Index:(NSInteger)index
{
    if(index >= self.sectionList.count)
        return nil;
    
    NSArray* sectionData = self.sectionList[index];
    
    if(section >= sectionData.count)
        return nil;
    
    if(![sectionData[section] isKindOfClass:[NSObject class]])
        return nil;
    
    NSObject* data = sectionData[section];
    if(!data.mt_reuseIdentifier && [data isKindOfClass:[NSString class]])
        data.mt_reuseIdentifier = (NSString*)data;
    
    return data;
}

/*-----------------------------------华丽分割线-----------------------------------*/

-(NSArray*)getSectionDataListForSection:(NSInteger)section
{
    NSArray* list;
    if(section >= self.sectionCount) return list;
    
    list = self.dataList[section];
    
    return [list isKindOfClass:[NSArray class]] ? list : nil;
}

-(NSObject*)getDataForIndexPath:(NSIndexPath*)indexPath
{
    if(self.isEmpty && self.emptyData)
    {
        if(!self.emptyData.mt_reuseIdentifier && [self.emptyData isKindOfClass:[NSString class]])
            self.emptyData.mt_reuseIdentifier = (NSString*)self.emptyData;
        
        return self.emptyData;
    }
    
    NSArray* list = [self getSectionDataListForSection:indexPath.section];
    
    return [list getDataByIndex:indexPath.row];
}

-(void)getReusableViewAutomaticDimensionSizeWithData:(NSObject*)data Section:(NSInteger)section SuperView:(UIView*)superView
{
    if(data.mt_tag == kDefault)
        return;
    
    NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
    NSString* identifier = [data.mt_baseCellIdentifier isExist] ? data.mt_baseCellIdentifier : mt_reuseIdentifier;
    if(![mt_reuseIdentifier isExist])
        return;
            
    MTDelegateCollectionReusableView* reusableView = self.shadowReusableViewList[identifier];
    if(!reusableView)
    {
        Class class = NSClassFromString(mt_reuseIdentifier);
        if(![class isSubclassOfClass:[MTDelegateCollectionReusableView class]])
            return;
        
        reusableView = class.new;
        reusableView.automaticDimension();
        reusableView.bindOrder(@"isAssistCell");
        self.shadowReusableViewList[identifier] = reusableView;
        if(self.setupDefaultDict[data.mt_baseCellIdentifier])
            [reusableView setWithObject:self.setupDefaultDict[data.mt_baseCellIdentifier]];
    }
    
    reusableView.section = section;
    reusableView.mt_data = [data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)data).data : ([data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)data).data : data);
    [reusableView layoutIfNeeded];
    data.bindSize([reusableView layoutSubviewsForWidth:superView.width Height:superView.height]);
    if(data.mt_automaticDimensionSize)
        data.mt_automaticDimensionSize(data.mt_itemSize);
    
    data.mt_tag = kDefault;
}

-(void)getAutomaticDimensionSizeWithData:(NSObject*)data IndexPath:(NSIndexPath*)indexPath SuperView:(UIView*)superView
{
    if(data.mt_tag == kDefault)
        return;
    
    NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
    NSString* identifier = [data.mt_baseCellIdentifier isExist] ? data.mt_baseCellIdentifier : mt_reuseIdentifier;
    if(![mt_reuseIdentifier isExist])
        return;
            
    MTDelegateCollectionViewCell* cell = self.shadowCollectionViewCellList[identifier];
    if(!cell)
    {
        Class class = NSClassFromString(mt_reuseIdentifier);
        if(![class isSubclassOfClass:[MTDelegateCollectionViewCell class]])
            return;
        
        cell = class.new;
        cell.automaticDimension();
        cell.bindOrder(@"isAssistCell");
        self.shadowCollectionViewCellList[identifier] = cell;
    }
    
    if(self.setupDefaultDict[data.mt_baseCellIdentifier])
        [cell setWithObject:self.setupDefaultDict[data.mt_baseCellIdentifier]];
    cell.mt_delegate = self;
    cell.indexPath = indexPath;
    cell.mt_data = [data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)data).data : ([data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)data).data : data);
    [cell layoutIfNeeded];
    data.bindSize([cell layoutSubviewsForWidth:superView.width Height:superView.height]);
    if(data.mt_automaticDimensionSize)
        data.mt_automaticDimensionSize(data.mt_itemSize);
    
    data.mt_tag = kDefault;
}

-(void)getAutomaticDimensionHeightWithData:(NSObject*)data IndexPath:(NSIndexPath*)indexPath SuperView:(UIView*)superView
{
    if(data.mt_tag == kDefault)
        return;
    
    NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
    if(![mt_reuseIdentifier isExist])
        return;
            
    MTDelegateTableViewCell* cell = self.shadowTableViewCellList[mt_reuseIdentifier];
    if(!cell)
    {
        Class class = NSClassFromString(mt_reuseIdentifier);
        if(![class isSubclassOfClass:[MTDelegateTableViewCell class]])
            return;
        
        cell = class.new;
        cell.automaticDimension();
        cell.bindOrder(@"isAssistCell");
        self.shadowTableViewCellList[mt_reuseIdentifier] = cell;
    }
    
    cell.indexPath = indexPath;
    cell.mt_data = [data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)data).data : ([data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)data).data : data);
    [cell layoutIfNeeded];
    data.bindHeight([cell layoutSubviewsForWidth:superView.width Height:superView.height].height);
    if(data.mt_automaticDimensionSize)
        data.mt_automaticDimensionSize(CGSizeMake(0, data.mt_itemHeight));
    data.mt_tag = kDefault;
}

-(void)setup3dTouch:(UIView*)view
{
    if(![self.delegate isKindOfClass:[UIViewController class]])
        return;
    
    UIViewController* vc = (UIViewController*)self.delegate;
    if ([vc respondsToSelector:@selector(traitCollection)]) {
        
        if ([vc.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            
            if (@available(iOS 9.0, *)) {
                if (vc.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                    
                    [vc registerForPreviewingWithDelegate:(id)vc sourceView:view];
                }
            }
        }
    }
}

/*-----------------------------------华丽分割线-----------------------------------*/

#pragma mark - tableView数据源

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.delegate respondsToSelector:@selector(numberOfSectionsInTableView:)])
        return [self.delegate numberOfSectionsInTableView:tableView];
    
    return (self.isEmpty && self.emptyData) ? 1 : self.sectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
        return [self.delegate tableView:tableView numberOfRowsInSection:section];
    
    return (self.isEmpty && self.emptyData) ? 1 :  [self getSectionDataListForSection:section].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
        return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    NSObject* data = [self getDataForIndexPath:indexPath];
    
    NSString* identifier = MTEasyReuseIdentifier(data.mt_reuseIdentifier);
    MTDelegateTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell)
    {
        Class c = NSClassFromString(data.mt_reuseIdentifier);
        if(![c isSubclassOfClass:[MTDelegateTableViewCell class]])
            cell = [tableView dequeueReusableCellWithIdentifier:MTEasyDefaultTableViewReuseIdentifier forIndexPath:indexPath];
        else
            cell = [[c alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
//    if(![tableView.cellStateArray.mt_order containsString:MTCellKeepStateOrder])
//    {
//         if(tableView.cellStateArray.count > indexPath.section)
//        {
//            NSMutableArray* arr = tableView.cellStateArray[indexPath.section];
//            if(arr.count > indexPath.row)
//                arr[indexPath.row] = @(kDeselected);
//        }
//    }
                
    indexPath.mt_order = nil;
    cell.indexPath = indexPath;
    cell.mt_delegate = self.delegate;
    cell.mt_data = [data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)data).data : ([data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)data).data : data);
    [cell setNeedsLayout];
    
    if(data.mt_open3dTouch)
        [self setup3dTouch:cell];
    
    return cell;
}

#pragma mark - tableView代理

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.isEmpty && !self.emptyData.mt_headerEmptyShow)
        return nil;
    
    NSObject* item = [self getHeaderDataForSection:section];
    if(!item)
        return nil;
    
    NSString* identifier = MTEasyReuseIdentifier(item.mt_reuseIdentifier);
    MTDelegateHeaderFooterView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if(!view)
    {
        Class c = NSClassFromString(item.mt_reuseIdentifier);
        if(![c isSubclassOfClass:[MTDelegateHeaderFooterView class]])
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MTEasyDefaultTableViewHeaderFooterReuseIdentifier];
        else
            view = [[c alloc] initWithReuseIdentifier:identifier];
    }
    
    view.mt_delegate = self.delegate;
    view.section = section;
    view.mt_data = [item isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)item).data : item;
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(self.isEmpty && self.emptyData)
        return nil;
    
    NSObject* item = [self getFooterDataForSection:section];
    if(!item)
        return nil;
    
    NSString* identifier = MTEasyReuseIdentifier(item.mt_reuseIdentifier);
    MTDelegateHeaderFooterView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if(!view)
    {
        Class c = NSClassFromString(item.mt_reuseIdentifier);
        if(![c isSubclassOfClass:[MTDelegateHeaderFooterView class]])
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MTEasyDefaultTableViewHeaderFooterReuseIdentifier];
        else
            view = [[c alloc] initWithReuseIdentifier:identifier];
    }
    
    view.mt_delegate = self.delegate;
    view.section = section;
    view.mt_data = [item isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)item).data : item;
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.isEmpty && !self.emptyData.mt_headerEmptyShow)
        return 0.000001;
    
    NSObject* item = [self getHeaderDataForSection:section];
    
    return item.mt_itemHeight == 0 ? 0.000001 : item.mt_itemHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.isEmpty && self.emptyData)
        return 0.000001;
    
    NSObject* item = [self getFooterDataForSection:section];
    
    return item.mt_itemHeight == 0 ? 0.000001 : item.mt_itemHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    if(self.isEmpty && self.emptyData)
    {
        CGFloat offset = 0;
        if(self.emptyData.mt_headerEmptyShow)
        {
            NSObject* item = [self getHeaderDataForSection:indexPath.section];
            offset = 2 * item.mt_itemHeight;
        }
        return self.emptyData.mt_itemHeight == 0 ? (tableView.height - offset) : self.emptyData.mt_itemHeight;
    }
        
    NSObject* data = [self getDataForIndexPath:indexPath];
    if(data.mt_automaticDimension)
           [self getAutomaticDimensionHeightWithData:data IndexPath:indexPath SuperView:tableView];
//      if([data.mt_itemEstimateHeight isKindOfClass:NSClassFromString(@"MTEstimateHeight")])
//          NSLog(@"%lf",data.mt_itemEstimateHeight.mt_itemHeight);
    return data.mt_itemHeight == 0 ? ([data.mt_reuseIdentifier isEqualToString:@"MTTenScrollViewCell"] ? tableView.height : 0.000001) : (data.mt_itemHeight + data.mt_itemEstimateHeight.mt_itemHeight);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPath.mt_order = nil;
    tableView.currentSection = indexPath.section;
    tableView.currentIndex = indexPath.row;
    if(self.isEmpty && self.emptyData)
        return;
            
    
    NSObject* data = [self getDataForIndexPath:indexPath];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    indexPath.bindOrder([data.mt_order isExist] ? data.mt_order : ([data.mt_reuseIdentifier isExist] ? data.mt_reuseIdentifier : NSStringFromClass(cell.class)));
    indexPath.mt_order.bindEnum(cell.mt_tag);
    [cell clickWithClearData:indexPath.bindClick(data.mt_click)];
    if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [self.delegate tableView:tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath.bindOrder([data.mt_order isExist] ? data.mt_order : data.mt_reuseIdentifier)];
}

#pragma mark - collectionView数据源

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if([collectionView.viewModel respondsToSelector:@selector(numberOfSectionsInCollectionView:)])
        return [collectionView.viewModel numberOfSectionsInCollectionView:collectionView];
    
    return (self.isEmpty && self.emptyData) ? 1 : self.sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([collectionView.viewModel respondsToSelector:@selector(collectionView:numberOfItemsInSection:)])
        return [collectionView.viewModel collectionView:collectionView numberOfItemsInSection:section];
    
    return (self.isEmpty && self.emptyData) ? 1 :  [self getSectionDataListForSection:section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* list = [self getSectionDataListForSection:indexPath.section];
    NSObject* data = [self getDataForIndexPath:[NSIndexPath indexPathForRow:(indexPath.row % (list.count ? list.count : 1)) inSection:indexPath.section]];
        
//    NSString* mt_reuseIdentifier = list.mt_reuseIdentifier ? list.mt_reuseIdentifier : data.mt_reuseIdentifier;
    NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
        
    NSString* identifier = MTEasyReuseIdentifier([data.mt_baseCellIdentifier isExist] ? data.mt_baseCellIdentifier : mt_reuseIdentifier);
    
    MTDelegateCollectionViewCell* cell;
    if(self.registerCellList[identifier])
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    else
    {
        Class class = NSClassFromString(mt_reuseIdentifier);
        if(![class isSubclassOfClass:[MTDelegateCollectionViewCell class]])
            return [collectionView dequeueReusableCellWithReuseIdentifier:MTEasyDefaultCollectionViewReuseIdentifier forIndexPath:indexPath];
        
        [collectionView registerClass:class forCellWithReuseIdentifier:identifier];
        MTDelegateCollectionViewCell* cell0 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if(!cell0)
            return [collectionView dequeueReusableCellWithReuseIdentifier:MTEasyDefaultCollectionViewReuseIdentifier forIndexPath:indexPath];
        
        self.registerCellList[identifier] = identifier;
        cell = cell0;
    }
    
    if(self.setupDefaultDict[data.mt_baseCellIdentifier])
        [cell setWithObject:self.setupDefaultDict[data.mt_baseCellIdentifier]];
    
    indexPath.mt_order = nil;
    cell.indexPath = indexPath;
    cell.mt_delegate = self;
    cell.mt_data = data;
    [cell setNeedsLayout];
    
    if(data.mt_open3dTouch)
        [self setup3dTouch:cell];
    
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MTDelegateCollectionReusableView* view;
    if(self.isEmpty && self.emptyData)
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier forIndexPath:indexPath];
                
    NSObject* data = [kind isEqualToString:UICollectionElementKindSectionFooter] ? [self getFooterDataForSection:indexPath.section] :  [self getHeaderDataForSection:indexPath.section];
    if(!data)
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier forIndexPath:indexPath];
        
    NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
    NSString* identifier = MTEasyReuseIdentifier([data.mt_baseCellIdentifier isExist] ? data.mt_baseCellIdentifier : mt_reuseIdentifier);
    
    if(self.registerSectionList[identifier])
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    else
    {
        Class class = NSClassFromString(mt_reuseIdentifier);
        if(![class isSubclassOfClass:[MTDelegateCollectionReusableView class]])
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier forIndexPath:indexPath];
        
        [collectionView registerClass:class forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
        
        MTDelegateCollectionReusableView* view0 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        if(!view0)
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MTEasyDefaultCollectionViewHeaderFooterReuseIdentifier forIndexPath:indexPath];
                    
        self.registerSectionList[identifier] = identifier;
        view = view0;
    }
    
    if(self.setupDefaultDict[data.mt_baseCellIdentifier])
        [view setWithObject:self.setupDefaultDict[data.mt_baseCellIdentifier]];
    
    view.mt_delegate = self;
    view.section = indexPath.section;
    view.mt_data = data;
    
    return view;
}


#pragma mark - collectionView代理

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)])
        [self.delegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
        return [self.delegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    
    
    if(self.isEmpty && self.emptyData)
        return UIEdgeInsetsZero;
    
    NSObject* item = [self getHeaderDataForSection:section];
    return item.mt_spacing.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)])
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    
    if(self.isEmpty && self.emptyData)
        return 0;
    
    NSObject* item = [self getHeaderDataForSection:section];
    return item.mt_spacing.minLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)])
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    
    if(self.isEmpty && self.emptyData)
        return 0;
    
    NSObject* item = [self getHeaderDataForSection:section];
    return item.mt_spacing.minItemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize zeroSize = CGSizeMake(0.000001, 0.000001);
    
    if(self.isEmpty && self.emptyData)
        return zeroSize;
    
    NSObject* item = [self getHeaderDataForSection:section];
    
    if(item.mt_automaticDimension)
        [self getReusableViewAutomaticDimensionSizeWithData:item Section:section SuperView:collectionView];
        
    CGSize itemSize = item.mt_itemSize;
    BOOL isZero = CGSizeEqualToSize(CGSizeZero, itemSize);
    if(isZero && item.mt_itemHeight)
    {
        itemSize = CGSizeMake(collectionView.width, item.mt_itemHeight);
        isZero = false;
    }
        
    return isZero ? zeroSize : itemSize;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize zeroSize = CGSizeMake(0.000001, 0.000001);
    
    if(self.isEmpty && self.emptyData)
        return zeroSize;
    
    NSObject* item = [self getFooterDataForSection:section];
    
    if(item.mt_automaticDimension)
        [self getReusableViewAutomaticDimensionSizeWithData:item Section:section SuperView:collectionView];
    
    CGSize itemSize = item.mt_itemSize;
    BOOL isZero = CGSizeEqualToSize(CGSizeZero, item.mt_itemSize);
    if(isZero && item.mt_itemHeight)
    {
        itemSize = CGSizeMake(collectionView.width, item.mt_itemHeight);
        isZero = false;
    }
    
    return isZero ? zeroSize : itemSize;
}

#pragma mark - item的size

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)])
        return [self.delegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    
    CGSize zeroSize = CGSizeMake(0.000001, 0.000001);
    NSArray* list = [self getSectionDataListForSection:indexPath.section];
    NSObject* data = [self getDataForIndexPath:[NSIndexPath indexPathForRow:(indexPath.row % (list.count ? list.count : 1)) inSection:indexPath.section]];
    
    if(data.mt_automaticDimension)
        [self getAutomaticDimensionSizeWithData:data IndexPath:indexPath SuperView:collectionView];
                            
    CGSize itemSize = data.mt_itemSize;
    BOOL isZero = CGSizeEqualToSize(CGSizeZero, itemSize);
    if(isZero)
    {
        if(data.mt_itemHeight)
        {
            itemSize = CGSizeMake(collectionView.width, data.mt_itemHeight);
            isZero = false;
        }
        else
        {
            itemSize = list.mt_itemSize;
            isZero = CGSizeEqualToSize(CGSizeZero, itemSize);
            if(isZero && list.mt_itemHeight)
            {
                itemSize = CGSizeMake(collectionView.width, list.mt_itemHeight);
                isZero = false;
            }
        }
    }
    
    if(itemSize.height == 0)
        itemSize.height = collectionView.height;
        
    if(self.isEmpty && self.emptyData)
        return isZero ? CGSizeMake(collectionView.width, collectionView.height - collectionView.contentInset.bottom) : itemSize;
    
    return isZero ? zeroSize : itemSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexPath.mt_order = nil;
    collectionView.currentSection = indexPath.section;
    collectionView.currentIndex = indexPath.row;
    if(self.isEmpty && self.emptyData)
        return;
    
    NSObject* data = [self getDataForIndexPath:indexPath];
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    indexPath.bindOrder([data.mt_order isExist] ? data.mt_order : ([data.mt_reuseIdentifier isExist] ? data.mt_reuseIdentifier : NSStringFromClass(cell.class)));
    [cell clickWithClearData:indexPath.bindClick(data.mt_click)];
    if([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath.bindOrder([data.mt_order isExist] ? data.mt_order : data.mt_reuseIdentifier)];
}


#pragma mark - scrollView代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.offsetX;
    CGFloat offsetY = scrollView.offsetY;
    NSInteger tagX = 0;
    NSInteger tagY = 0;
    if(offsetX > self.preOffsetX)
        tagX = 1;
    else if(offsetX < self.preOffsetX)
        tagX = -1;
    
    if(offsetY > self.preOffsetY)
        tagY = 1;
    else if(offsetY < self.preOffsetY)
        tagY = -1;
    
    if(scrollView.directionXTag != tagX)
        [scrollView performSelector:@selector(setDirectionXTag:) withObject:@(tagX)];
    if(scrollView.directionYTag != tagY)
        [scrollView performSelector:@selector(setDirectionYTag:) withObject:@(tagY)];
    
    self.preOffsetX = offsetX;
    self.preOffsetY = offsetY;
    
    if([scrollView.viewModel respondsToSelector:@selector(scrollViewDidScroll:)])
        [scrollView.viewModel scrollViewDidScroll:scrollView];
    
    if(scrollView.viewModel == self.delegate) return;
    
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.delegate scrollViewDidScroll:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([scrollView.viewModel respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [scrollView.viewModel scrollViewWillBeginDragging:scrollView];
    
    if(scrollView.viewModel == self.delegate) return;
    
    if([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [self.delegate scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([scrollView.viewModel respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [scrollView.viewModel scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    if(scrollView.viewModel == self.delegate) return;
    
    if([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if([scrollView.viewModel respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [scrollView.viewModel scrollViewDidEndDecelerating:scrollView];
    
    if(scrollView.viewModel == self.delegate) return;
    
    if([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [self.delegate scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if([scrollView.viewModel respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [scrollView.viewModel scrollViewDidEndScrollingAnimation:scrollView];
    
    if(scrollView.viewModel == self.delegate) return;
    
    if([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - MTDelegateProtocol

-(void)doSomeThingForMe:(id)obj withOrder:(NSString*)order
{
    if([order isEqualToString:@"MTWebImageReloadOrder"])
    {
        NSIndexPath* indexPath = obj;
        
        NSArray* list = [self getSectionDataListForSection:indexPath.section];
        NSObject* data = [self getDataForIndexPath:[NSIndexPath indexPathForRow:(indexPath.row % (list.count ? list.count : 1)) inSection:indexPath.section]];
        data.automaticDimension();
        [self getAutomaticDimensionSizeWithData:data IndexPath:indexPath SuperView:self.collectionView];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            if([self.collectionView cellForItemAtIndexPath:indexPath])
                [UIView performWithoutAnimation:^{
                    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
        });
    }
        
    if([self.delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:)])
        [self.delegate doSomeThingForMe:obj withOrder:order];
}

-(id)getSomeThingForMe:(id)obj withOrder:(NSString*)order
{
    if([self.delegate respondsToSelector:@selector(getSomeThingForMe:withOrder:)])
        return [self.delegate getSomeThingForMe:obj withOrder:order];
    
    return nil;
}

-(void)doSomeThingForMe:(id)obj withOrder:(NSString*)order withItem:(id)item
{
    if([self.delegate respondsToSelector:@selector(doSomeThingForMe:withOrder:withItem:)])
        [self.delegate doSomeThingForMe:obj withOrder:order withItem:item];
}

-(id)getSomeThingForMe:(id)obj withOrder:(NSString*)order withItem:(id)item
{
    if([self.delegate respondsToSelector:@selector(getSomeThingForMe:withOrder:withItem:)])
        return [self.delegate getSomeThingForMe:obj withOrder:order withItem:item];
    
    return nil;
}


#pragma mark - pickerView 数据源

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.sectionCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self getSectionDataListForSection:component].count;
}

#pragma mark - pickerView 代理

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    MTDelegatePickerViewCell* cell;
    NSObject* data = [self getDataForIndexPath:cell.indexPath];
    Class cellClass = NSClassFromString(data.mt_reuseIdentifier);
    
    if([view isKindOfClass:[MTDelegatePickerViewCell class]])
        cell = (MTDelegatePickerViewCell*)view;
    else if([pickerView isKindOfClass:[MTDelegatePickerView class]])
    {
        Class c = NSClassFromString(((MTDelegatePickerView*)pickerView).cellClass);
        if([c isSubclassOfClass:[MTDelegatePickerViewCell class]])
            cell = (MTDelegatePickerViewCell*)c.new;
    }
    else if([cellClass isSubclassOfClass:[MTDelegatePickerViewCell class]])
    {
        cell = (MTDelegatePickerViewCell*)cellClass.new;
    }
    if(!cell)
        cell = [MTDelegatePickerViewCell new];
    
    
    cell.selectedRow = [pickerView selectedRowInComponent:component];
    cell.indexPath = [NSIndexPath indexPathForRow:row inSection:component];
    
    
    if([self.delegate respondsToSelector:@selector(pickerView:titleForData:ForRow:forComponent:)] && [NSStringFromClass([cell class]) isEqualToString:@"MTDelegatePickerViewCell"])
        cell.mt_data = [self.delegate pickerView:pickerView titleForData:data ForRow:row forComponent:component];
    else
        cell.mt_data = [data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)data).data : data;
    return cell;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)])
        [self.delegate pickerView:pickerView didSelectRow:row inComponent:component];
    else
        [pickerView reloadAllComponents];
}

static NSString* mt_titleForRowAtIndexPath(id self, SEL cmd, UIPickerView * pickerView, NSInteger row, NSInteger component) {
    if([pickerView isKindOfClass:[MTDelegatePickerView class]])
    {
        MTDelegatePickerView* pView = (MTDelegatePickerView*)pickerView;
        MTDataSource* dataSource = [pView valueForKey:@"mt_dataSource"];
        
        NSObject* data = [dataSource getDataForIndexPath:[NSIndexPath indexPathForRow:row inSection:component]];
        return [data isKindOfClass:[NSString class]] ? (NSString*)data : @"";
    }
    
    return @"";
}

#pragma mark - 懒加载

-(NSMutableDictionary *)registerCellList
{
    if(!_registerCellList)
    {
        _registerCellList = [NSMutableDictionary dictionary];
    }
    
    return _registerCellList;
}

-(NSMutableDictionary *)registerSectionList
{
    if(!_registerSectionList)
    {
        _registerSectionList = [NSMutableDictionary dictionary];
    }
    
    return _registerSectionList;
}

-(NSMutableDictionary<NSString *,MTDelegateCollectionViewCell *> *)shadowCollectionViewCellList
{
    if(!_shadowCollectionViewCellList)
    {
        _shadowCollectionViewCellList = [NSMutableDictionary dictionary];
    }
    
    return _shadowCollectionViewCellList;
}

-(NSMutableDictionary<NSString *,MTDelegateTableViewCell *> *)shadowTableViewCellList
{
    if(!_shadowTableViewCellList)
    {
        _shadowTableViewCellList = [NSMutableDictionary dictionary];
    }
    
    return _shadowTableViewCellList;
}

-(NSMutableDictionary<NSString *,MTDelegateCollectionReusableView *> *)shadowReusableViewList
{
    if(!_shadowReusableViewList)
    {
        _shadowReusableViewList = [NSMutableDictionary dictionary];
    }
    
    return _shadowReusableViewList;
}


@end





#pragma mark - 扩展类

@implementation MTDelegateCollectionViewCell (Private)

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:NSClassFromString(@"MTBaseViewContentModel")] || [obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
        return [super setWithObject:obj];
   
    self.mt_data = obj;
    return self;
}

-(void)setMt_data:(NSObject *)mt_data
{
    NSObject* metaData = mt_data;
    mt_data = [mt_data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)mt_data).data : ([mt_data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)mt_data).data : mt_data);
        
    if(![mt_data isKindOfClass:self.classOfResponseObject])
    {
        if([mt_data isKindOfClass:[NSDictionary class]] && [self.classOfResponseObject isSubclassOfClass:[NSObject class]])
        {
            NSObject* model = [self.classOfResponseObject mj_objectWithKeyValues:mt_data];
            if(!model)
                return;
            
            mt_data = [model copyBindWithObject:metaData];
        }
        else
        {
            if(mt_data.mt_click)
                 self.bindClick(mt_data.mt_click);
                        
            if(self.mt_click && self.mt_click != mt_data.mt_click)
                self.mt_click(self.indexPath);
            return;
        }
    }
    
    [self whenGetResponseObject:mt_data];
}

-(NSObject *)mt_data
{
    return nil;
}

@end

@implementation MTDelegateTableViewCell (Private)

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:NSClassFromString(@"MTBaseViewContentModel")] || [obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
        return [super setWithObject:obj];
   
    self.mt_data = obj;
    return self;
}

-(void)setMt_data:(NSObject *)mt_data
{
    if(![mt_data isKindOfClass:self.classOfResponseObject])
    {
        if([mt_data isKindOfClass:[NSDictionary class]] && [self.classOfResponseObject isSubclassOfClass:[NSObject class]])
        {
            NSObject* model = [self.classOfResponseObject mj_objectWithKeyValues:mt_data];
            if(!model)
                return;
                        
            mt_data.mt_itemEstimateHeight = model.mt_itemEstimateHeight;
            mt_data = [model copyBindWithObject:mt_data];
        }
        else
        {
            if(mt_data.mt_click)
                self.bindClick(mt_data.mt_click);
            return;
        }
    }
    
    [self whenGetResponseObject:mt_data];
}

-(NSObject *)mt_data
{
    return nil;
}

@end

@implementation MTDelegateHeaderFooterView (Private)

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:NSClassFromString(@"MTBaseViewContentModel")] || [obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
        return [super setWithObject:obj];
   
    self.mt_data = obj;
    return self;
}

-(void)setMt_data:(NSObject *)mt_data
{
    if(![mt_data isKindOfClass:self.classOfResponseObject])
    {
        if([mt_data isKindOfClass:[NSDictionary class]] && [self.classOfResponseObject isSubclassOfClass:[NSObject class]])
        {
            NSObject* model = [self.classOfResponseObject mj_objectWithKeyValues:mt_data];
            if(!model)
                return;
            
            mt_data = [model copyBindWithObject:mt_data];
        }
        else
        {
            if(mt_data.mt_click)
                self.bindClick(mt_data.mt_click);
            return;
        }
    }
    
    [self whenGetResponseObject:mt_data];
}

-(NSObject *)mt_data
{
    return nil;
}

@end

@implementation MTDelegateCollectionReusableView (Private)

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:NSClassFromString(@"MTBaseViewContentModel")] || [obj.mt_reuseIdentifier isEqualToString:@"baseContentModel"])
        return [super setWithObject:obj];
   
    self.mt_data = obj;
    return self;
}

-(void)setMt_data:(NSObject *)mt_data
{
    NSObject* metaData = mt_data;
    mt_data = [mt_data isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)mt_data).data : ([mt_data isKindOfClass:[NSWeakReuseObject class]] ? ((NSWeakReuseObject*)mt_data).data : mt_data);
    
    if(![mt_data isKindOfClass:self.classOfResponseObject])
    {
        if([mt_data isKindOfClass:[NSDictionary class]] && [self.classOfResponseObject isSubclassOfClass:[NSObject class]])
        {
            NSObject* model = [self.classOfResponseObject mj_objectWithKeyValues:mt_data];
            if(!model)
                return;
            
            mt_data = [model copyBindWithObject:metaData];
        }
        else
        {
            if(mt_data.mt_click)
                self.bindClick(mt_data.mt_click);
            return;
        }
    }
    
    [self whenGetResponseObject:mt_data];
}

-(NSObject *)mt_data
{
    return nil;
}

@end



