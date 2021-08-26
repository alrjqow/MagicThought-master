//
//  MTAlertBigImageController.m
//  QXProject
//
//  Created by monda on 2020/5/11.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTAlertBigImageController.h"
#import "MTImageShowControllModel.h"
#import "UIView+MTBaseViewContentModel.h"
#import "MTContentModelPropertyConst.h"
#import "NSObject+ReuseIdentifier.h"
#import "MTImageShowViewContentModel.h"

#import "MJExtension.h"

@interface MTAlertBigImageController ()<UIScrollViewDelegate>

@property (nonatomic,strong,readonly) MTBigimageCellModel* bigimageCellModel;

@end

@implementation MTAlertBigImageController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:YES];
}

-(void)setupDefault
{
    [super setupDefault];
        
    self.blackView.backgroundColor = [UIColor blackColor];
    self.mtListView.bounces = YES;
}

-(void)setupSubview
{
    [super setupSubview];
    
    self.imagePlayView.width += self.bigimageCellModel.bigImageCellSpacing;
}

-(void)alertCompletion
{
    self.bigimageCellModel.bindOrder(@"alertCompletion");
    self.imagePlayView.scrollEnabled = !self.bigimageCellModel.bigImageSingleShow;
    [self.imagePlayView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.bigimageCellModel.bigImageShowIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}

-(void)dismissCompletion
{
    self.blackView.alpha = 1;
     self.blackView.backgroundColor = [UIColor blackColor];
}


#pragma mark - 代理

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.offsetX / scrollView.width;
    
    [self.imageShowControllModel checkVideoWithIndex:index];    
}

#pragma mark - Getter、Setter

-(NSArray *)dataList
{
        __weak __typeof(self) weakSelf = self;
    NSMutableArray* array = [NSMutableArray array];
    for(NSInteger index = 0; index < self.imageShowControllModel.imageArray.count; index++)
    {
        UIImage* image = self.imageShowControllModel.imageArray[index];
        [array addObject:
             @{
                 kImg : mt_content(image, mt_bind.bindIndex(index),
                                 mt_placeholderImage(self.imageShowControllModel.bigimageCellModel.placeholderImage),
                                   mt_bind.bindOrder(@"MTBigimageCellOrder")
                                   ),
                 kImageShowControllModel : mt_weakReuse(weakSelf.imageShowControllModel)
             }.bind(weakSelf.bigimageCellModel.bigImageCellClassName)
             .bindSize(CGSizeMake(weakSelf.imagePlayView.width, weakSelf.imagePlayView.height))         
         ];
//        [array addObject:
//                  @{
//                      kImg : mt_content(@"dog")
//                  }.bind(@"MTImageCell")
//                  .bindSize(CGSizeMake(self.imagePlayView.width - 4 * outterMargin, self.imagePlayView.height))
//                 .bindClick(^(id  _Nullable object) {
//
//            [weakSelf dismiss];
//                })
//              ];
    }
    
    return array;
}

-(MTBaseAlertType)type
{
    return MTBaseAlertTypeDefault;
}

-(UIScrollView *)mtListView
{
    return self.imagePlayView;
}

-(MTBigimageCellModel *)bigimageCellModel
{
    return self.imageShowControllModel.bigimageCellModel;
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:[MTAlertBigImageController class]])
        return keyValues;
    
    return [super mj_objectWithKeyValues:keyValues context:context];
}

-(MTBaseImagePlayView *)imagePlayView
{
    if(!_imagePlayView)
    {        
        _imagePlayView = [[MTBaseImagePlayView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _imagePlayView.backgroundColor = [UIColor clearColor];
        [_imagePlayView addTarget:self];
    }
    
    return _imagePlayView;
}

-(UICollectionViewFlowLayout *)createCollectionViewFlowLayout
{return nil;}

@end
