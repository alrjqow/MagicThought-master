//
//  MTImageShowViewContentModel.m
//  QXProject
//
//  Created by monda on 2020/5/9.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTImageShowViewContentModel.h"
#import "NSString+Exist.h"

@interface MTImageShowViewContentModel ()

/**是否为下载的图片*/
@property (nonatomic,assign) BOOL isImageURLImage;

@end

@implementation MTImageShowViewContentModel

-(instancetype)setWithObject:(NSObject *)obj
{
    if([obj isKindOfClass:[MTImageShowControllModel class]])
    {
        self.imageShowControllModel = (MTImageShowControllModel*)obj;
        return self;
    }
    
    return [super setWithObject:obj];
}

-(void)configImageView:(UIImageView*)imageView
{
    BOOL isAssistCell = false;
    UIView* superView = imageView.superview;
    while (superView) {
        if([superView.mt_order isEqualToString:@"isAssistCell"])
        {
            isAssistCell = YES;
            break;
        }
                        
        superView = superView.superview;
    }
    
    NSObject* preImage;
    if(imageView.baseContentModel.image)
        preImage = [[imageView.baseContentModel valueForKey:@"isImageURLImage"] boolValue] ? imageView.baseContentModel.imageURL : imageView.baseContentModel.image;
    else if([imageView.baseContentModel.imageURL isExist])
        preImage = imageView.baseContentModel.imageURL;
    
    NSObject* newImage;
    if(self.image)
        newImage = self.isImageURLImage ? self.imageURL : self.image;
    else if([self.imageURL isExist])
    {
        newImage = self.imageURL;
        self.isImageURLImage = YES;
    }
                
    if(!isAssistCell && newImage && preImage)
    {
        imageView.userInteractionEnabled = false;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.imageShowControllModel performSelector:@selector(removeImageViewBindWithImage:Index:) withObject:preImage withObject:self.mt_index];
#pragma clang diagnostic pop
    }
    
    [imageView setBaseModelConfig:self];
    
    if(isAssistCell)
        return;        
    if(!newImage)
        return;
    
    if(self.imageShowControllModel)
        imageView.userInteractionEnabled = YES;
    imageView.bindIndex(self.mt_currentIndex);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.imageShowControllModel performSelector:@selector(updateImageViewMapWithImage:View:) withObject:newImage withObject:imageView];
#pragma clang diagnostic pop
}

-(void)imageViewTouchesEnded:(UIImageView*)imageView
{
    [self.imageShowControllModel showBigImageWithSmallImageView: imageView];
}

@end



NSString* kImageShowControllModel = @"imageShowControllModel";
@implementation MTBigimageCellContentModel @end
