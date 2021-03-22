//
//  NSObject+CommonProtocol.h
//  MDKit
//
//  Created by monda on 2019/6/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDelegateProtocol.h"
#import "MTInitProtocol.h"

@interface NSObject (CommonProtocol)<MTDelegateProtocol, MTInitProtocol, MTRequestDataProtocol, MTNotificationProtocol>

@property(nonatomic,weak) id<MTDelegateProtocol> mt_delegate;

@end
