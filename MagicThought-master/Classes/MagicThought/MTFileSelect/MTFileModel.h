//
//  MTFileModel.h
//  DaYiProject
//
//  Created by monda on 2018/10/29.
//  Copyright © 2018 monda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MTFileModel : NSObject

@property (nonatomic,strong) NSData* data;

@property (nonatomic,strong) NSString* fileName;

@property (nonatomic,strong) NSString* fileSize;

@property (nonatomic,strong) NSString* fileModificationTime;


+(instancetype)setupPropertyWithDocument:(UIDocument*)document;

@end


