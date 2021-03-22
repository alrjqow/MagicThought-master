//
//  MTDocumentPreseter.h
//  SimpleProject
//
//  Created by monda on 2019/6/17.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTManager.h"

#import "MTFileModel.h"

@interface MTDocumentPreseter : MTManager

@property (nonatomic,strong) UIDocumentBrowserViewController* browserController;

+(instancetype)preseter;


-(void)showWithCompletion:(void (^) (BOOL isSuccess, MTFileModel* fileModel))completion;

@end


