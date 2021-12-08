//
//  MTRequest.h
//  QXProject
//
//  Created by monda on 2020/11/25.
//  Copyright © 2020 monda. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "MTHeaderFooterRefreshListController.h"

typedef enum : NSUInteger {
    MTEndRefreshStatusNone,
    MTEndRefreshStatusDefault,    
    MTEndRefreshStatusDefaultWithErrorMsg,
    MTEndRefreshStatusDefaultWithCenterToastMsg,
    MTEndRefreshStatusDefaultWithSuccessMsg,
    MTEndRefreshStatusDefaultFooterNoMoreData,
    MTEndRefreshStatusNotStop,    
} MTEndRefreshStatus;

@protocol MTEndRefreshStatusProtocol

-(void)setEndRefreshStatus:(MTEndRefreshStatus)endRefreshStatus Message:(NSString*)message;

-(void)afterSetEndRefreshStatus:(MTEndRefreshStatus)endRefreshStatus Message:(NSString*)message;

@end

@interface MTRequestCallbackHandler : NSObject @end

@class MTRequest;
typedef MTRequest* (^MTSetRequestCallbackHandler)(MTRequestCallbackHandler* handler);
typedef void (^MTStartRequestCallbackHandler)(MTRequestCallbackHandler* handler);
typedef MTEndRefreshStatus (^MTEndRefreshStatusCallback)(id obj, NSString **mssage, BOOL success, MTRequest* request);


@interface MTRequest : YTKRequest

@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) NSDictionary *paramters;

@property (nonatomic, strong) Class cls;

@property (nonatomic,strong) Class responseModelCls;

@property (nonatomic, assign) YTKRequestMethod method;

@property (nonatomic, assign) YTKRequestSerializerType requestContentType;

@property (nonatomic, assign) YTKResponseSerializerType responseContentType;

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *responeMessage;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) id responseJSONModel;

/*发起者*/
@property (nonatomic,weak) id promoterObject;
@property (nonatomic,copy, readonly) MTSetRequestCallbackHandler setHandle;
@property (nonatomic,copy, readonly) MTStartRequestCallbackHandler startHandle;

@end


@interface MTResponseModel : NSObject

@property (nonatomic,weak) MTRequest* request;

@property (nonatomic,strong, readonly) NSDictionary* keyData;

@property (nonatomic, assign, readonly) BOOL success;

@property (nonatomic, copy, readonly) NSString *responeMessage;

@property (nonatomic, assign, readonly) NSInteger totalCount;

-(void)convertComplete:(MTRequest*)request;

@end


CG_EXTERN NSObject* _Nonnull cls_mtRequest(Class cls);
CG_EXTERN NSObject* _Nonnull responseModelCls_mtRequest(Class responseModelCls);
CG_EXTERN NSObject* _Nonnull method_mtRequest(YTKRequestMethod method);

CG_EXTERN NSObject* _Nonnull requestContentType_mtRequest(YTKRequestSerializerType requestContentType);
CG_EXTERN NSObject* _Nonnull responseContentType_mtRequest(YTKResponseSerializerType responseContentType);




typedef MTRequestCallbackHandler* (^MTCreateRequestCallbackHandlerCallback)(MTEndRefreshStatusCallback);

@interface UIViewController (EndRefresh)<MTEndRefreshStatusProtocol>

@property (nonatomic,copy, readonly) MTCreateRequestCallbackHandlerCallback callBack;

@property (nonatomic,copy, readonly) MTCreateRequestCallbackHandlerCallback callBackNoMsg;

@property (nonatomic,copy, readonly) MTCreateRequestCallbackHandlerCallback callBackNoMsgResult;

@end


@interface MTBatchRequest : YTKBatchRequest

+ (instancetype)requestWithArray:(NSArray<MTRequest *> *)requestArray;

@property (nonatomic,copy, readonly) MTStartRequestCallbackHandler startHandle;

@end
