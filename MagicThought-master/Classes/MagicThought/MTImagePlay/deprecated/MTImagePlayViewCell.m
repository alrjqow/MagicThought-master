//
//  MTImagePlayViewCell.m
//  8kqw
//
//  Created by 王奕聪 on 2017/4/7.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTImagePlayViewCell.h"
#import "UIImageView+WebCache.h"
#import "MTImagePlayView0.h"

@interface MTImagePlayViewCell ()


@end

@implementation MTImagePlayViewCell


-(void)setupDefault
{
    [super setupDefault];
    
    [self setupSubView];
}

-(void)setupSubView
{
    UIImageView* imgView = [UIImageView new];
    
    self.imgView = imgView;
    [self addSubview:imgView];
}

-(void)setImgURL:(NSString *)imgURL
{
    _imgURL = imgURL;
    
    UIImage* placeholderImage;
    if([self.mt_delegate isKindOfClass:[MTImagePlayView0 class]])
        placeholderImage = ((MTImagePlayView0*)self.mt_delegate).placeholderImage;
    
    if(!imgURL)
    {
        self.imgView.image = placeholderImage;
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        return;
    }
    
    
    UIImage* img = [UIImage imageNamed:imgURL];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage: img ? img : placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
        self.imgView.contentMode = image ? UIViewContentModeScaleToFill : UIViewContentModeScaleAspectFill;
    }];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.imgView.frame = self.bounds;
}


@end
