//
//  MTDataSource.h
//  MonDaProject
//
//  Created by monda on 2018/6/15.
//  Copyright © 2018 monda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDelegateProtocol.h"

/**互斥按钮, 需要使用请 order包含 MTCellContradict*/
CG_EXTERN NSString* MTCellContradictOrder;
/**保持 cell 的状态*/
CG_EXTERN NSString* MTCellKeepStateOrder;

@protocol MTDelegatePickerViewDelegate;
@interface MTDataSource : NSObject<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,weak) id<MTDelegateProtocol, UITableViewDelegate, UICollectionViewDelegateFlowLayout, MTDelegatePickerViewDelegate, UITableViewDataSource> delegate;

@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) NSArray* sectionList;

@property (nonatomic,strong) NSObject* emptyData;

@end
