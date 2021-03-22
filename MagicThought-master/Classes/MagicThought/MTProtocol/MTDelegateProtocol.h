//
//  MTDelegateProtocol.h
//  8kqw
//
//  Created by 王奕聪 on 2016/12/24.
//  Copyright © 2016年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTDelegateProtocol <NSObject>

@optional
-(void)doSomeThingForMe:(id)obj withOrder:(NSString*)order;
-(id)getSomeThingForMe:(id)obj withOrder:(NSString*)order;
-(void)doSomeThingForMe:(id)obj withOrder:(NSString*)order withItem:(id)item;
-(id)getSomeThingForMe:(id)obj withOrder:(NSString*)order withItem:(id)item;

@end



@protocol MTDelegateViewDataProtocol

@optional
@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) NSArray* tenScrollDataList;

@property (nonatomic,strong) NSArray* pageScrollDataList;

@property (nonatomic,strong) NSArray* pageScrollTitleDataList;

@property (nonatomic,strong) NSArray* pageScrollTailDataList;

@property (nonatomic,strong) NSArray* sectionList;

@property (nonatomic,strong) NSObject* emptyData;

@end

@protocol MTExchangeDataProtocol

/**当接收到数据*/
-(void)whenGetResponseObject:(NSObject*)object;

/**接收数据的类型*/
-(Class)classOfResponseObject;

@optional

/**拿一些东西*/
-(NSDictionary*)giveSomeThingToYou;

/**拿一些东西给我做什么*/
-(void)giveSomeThingToMe:(id)obj WithOrder:(NSString*)order;

/**设置父类数据*/
-(void)setSuperResponseObject:(NSObject*)object;

@end


@protocol MTListDataProtocol <UIGestureRecognizerDelegate, UIScrollViewDelegate>

@optional

- (NSArray*)newDataList:(NSArray*)dataList;

- (void)didSetDataList:(NSArray*)dataList;

@end


@protocol MTViewModelProtocol<UICollectionViewDataSource,MTListDataProtocol, MTExchangeDataProtocol>

-(void)layoutSubviews;

@end
