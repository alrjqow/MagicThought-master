//
//  MTFileModel.m
//  DaYiProject
//
//  Created by monda on 2018/10/29.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTFileModel.h"

#import "MTTimer.h"
#import "NSString+Exist.h"


@implementation MTFileModel

+(instancetype)setupPropertyWithDocument:(UIDocument*)document
{
    //             NSLog(@"--%lu---",(unsigned long)docu.documentState);
    //             NSLog(@"--%@---",docu.progress);
    //             NSLog(@"--%@---",docu.fileType);
    //             NSLog(@"--%@---",docu.fileURL);
    MTFileModel* model = [MTFileModel new];
    model.fileName = document.localizedName;
    model.fileModificationTime = [MTTimer getTimeWithDate:document.fileModificationDate Format:nil];
    model.data = [NSData dataWithContentsOfURL:document.fileURL];
    model.fileSize = [NSString stringWithFormat:@"%.2fMB", model.data.length / 1000.0 / 1000.0];
    
    return model;
}

-(NSString *)fileName
{
    return [_fileName isExist] ? _fileName : @"未命名";
}

-(NSString *)fileSize
{
    return [_fileSize isExist] ? _fileSize : @"0MB";
}

-(NSString *)fileModificationTime
{
    return [_fileModificationTime isExist] ? _fileModificationTime : @"";
}

@end
