//
//  MTAlertSheetController.m
//  DaYiProject
//
//  Created by monda on 2018/9/10.
//  Copyright © 2018 monda. All rights reserved.
//

#import "MTAlertSheetController.h"
#import "UIDevice+DeviceInfo.h"
#import "NSObject+ReuseIdentifier.h"

NSString*  MTBaseAlertDismissOrder_Close = @"MTBaseAlertDismissOrder_True_Close";
NSString*  MTBaseAlertDismissOrder_Enter = @"MTBaseAlertDismissOrder_True_Enter";

@interface MTAlertSheetController() @end

@implementation MTAlertSheetController

-(void)initProperty
{
    [super initProperty];
    
    self.type = MTBaseAlertTypeUp;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.alertView = self.mtListView;
    self.mtListView.bounces = false;
    self.mtListView.contentInset = UIEdgeInsetsZero;
    self.mtListView.currentIndex = self.currentIndex;
}

#pragma mark - 代理

#pragma mark - 懒加载

-(UIScrollView *)mtListView
{
    return self.mtBase_collectionView;
}

-(BOOL)adjustListViewHeightByData
{
    return YES;
}

-(void)dismissCompletion
{
    if([self.mt_order containsString:MTBaseAlertDismissOrder_Close])
    {
        self.mtListView.currentIndex = self.currentIndex;
        self.mtListView.currentSection = self.currentSection;
    }
        
    self.mt_order = nil;
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
        
    if(self.isViewDidLoad)
    {
        self.mtListView.currentIndex = currentIndex;
        [self loadData];
    }
}

-(void)setMt_order:(NSString *)mt_order
{
    [super setMt_order:mt_order];
    
    if([mt_order containsString:MTBaseAlertDismissOrder_Enter] && ![mt_order containsString:MTBaseAlertDismissOrder_Close])
    {
        self.currentIndex = self.mtListView.currentIndex;
        self.currentSection = self.mtListView.currentSection;
        
        if(self.enterBlock)
            self.enterBlock(self.currentIndex, self.currentSection);
    }
}

@end


CGFloat bottomCellHeight_mtAlertHair(CGFloat height)
{
    return height - ([UIDevice isHairScreen] ? 0 : kStatusBarHeight_mt());
}

CGFloat bottomCellHeight_mtAlertNormal(CGFloat height)
{
    return height + ([UIDevice isHairScreen] ?  kStatusBarHeight_mt() : 0.000000001);
}
