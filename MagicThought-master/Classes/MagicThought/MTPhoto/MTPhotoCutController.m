//
//  MTPhotoCutController.m
//  XHProject
//
//  Created by apple on 2022/1/17.
//

#import "MTPhotoCutController.h"
#import "CyhImageCutview.h"

@interface MTPhotoCutController ()

@property (nonatomic , strong) CyhImageCutview * ImageCutview;

@end

@implementation MTPhotoCutController

-(void)setupSubview
{
    [super setupSubview];
    
    if(![self.imageArray.firstObject isKindOfClass:UIImage.class])
        return;
    
    self.ImageCutview = [[CyhImageCutview alloc] init];
    self.ImageCutview.whScale = self.whScale;
    
    __weak typeof(self) weakSelf = self;
    UIView * view = [self.ImageCutview setView_cutViewWithImage:self.imageArray.firstObject addSuperclassView:self.view PinScale:3.0 complet:^(UIImage *Cutimage) {
        
        if(!Cutimage)
            return;
        
        if(weakSelf.didFinishGetImage)
            weakSelf.didFinishGetImage(@[Cutimage]);
    }];
    
    [self.view addSubview:view];
}

-(void)navigationBarRightBtnClick
{
    [self.ImageCutview sureCutImage];
}

-(NSString *)navigationBarClassName{return @"XHPhotoCutNavigationBar";}

@end
