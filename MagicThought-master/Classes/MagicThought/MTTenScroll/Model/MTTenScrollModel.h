//
//  MTTenScrollModel.h
//  DaYiProject
//
//  Created by monda on 2018/12/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTTenScrollTitleViewModel.h"
#import "MTDelegateProtocol.h"


extern NSString* MTTenScrollIdentifier;

typedef enum : NSInteger {
    
    /**默认把刷新至于最顶*/
    MTTenScrollModelScrollTypeDefault,
    
    /**顶层标题栏固定,使刷新能置于标题底部*/
    MTTenScrollModelScrollTypeTitleFixed,
    
} MTTenScrollModelScrollType;

@interface MTTenScrollModel : NSObject

@property (nonatomic,assign) MTTenScrollModelScrollType viewState;

@property (nonatomic,weak) NSObject<MTDelegateViewDataProtocol>* delegate;

@property (nonatomic,strong) NSArray* dataList;

@property (nonatomic,strong) MTTenScrollTitleViewModel* titleViewModel;

@property (nonatomic,assign) CGFloat tenScrollHeight;

/**contentView固定的偏移值*/
@property (nonatomic,assign) CGFloat contentViewFixOffset;

@property (nonatomic,assign) NSInteger beginPage;

@end


