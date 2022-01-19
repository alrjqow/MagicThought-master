//
//  MTHostServiceModel.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/29.
//

#import "MTHostServiceModel.h"
#import "MTViewContentModel+MTAlert.h"
#import "MTBaseCollectionViewCell.h"
#import "MTContentModelPropertyConst.h"
#import "MTHostManager.h"

NSString* MTHostNum = @"MTHostNum";
NSString* MTHostNumViewIndex = @"MTHostNumViewIndex";


@interface MTHostServiceModel ()

@property (nonatomic,strong) NSMutableArray* contentModelList;

@property (nonatomic,assign) CGFloat alertViewHeight;

@property (nonatomic,strong) MTBaseViewContentModel* currentHostModel;

@property (nonatomic,strong) NSArray<NSString*>* hostNameList;

@end

@implementation MTHostServiceModel

-(void)addHostSwitchButton:(NSArray<MTBaseViewContentModel*>*)hostNameList
{
    if(!hostNameList.count)
        return;    
        
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 70, 30) byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = CGRectMake(0, 0, 70, 30);
    maskLayer.path = maskPath.CGPath;
        
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = hex(0xdbb76c);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.mask = maskLayer;
    [btn setTitle:@"切换Host" forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 70, 30);
    btn.x = 0;
    btn.centerY = half(kScreenHeight_mt());
    [self.viewController.view addSubview:btn];
        
    __weak __typeof(self) weakSelf = self;
        
    self.hostNameList = hostNameList;
    
    btn.bindClick(^(id  _Nullable object) {
        
        if(!weakSelf.hostNameList.count)
            return;
        
        [weakSelf alertHostListView];
    });
}

-(void)alertHostListView
{
    __weak __typeof(self) weakSelf = self;
    
    NSNumber* mtHostNumIndex = [[NSUserDefaults standardUserDefaults] objectForKey:MTHostNumViewIndex];
    
    self.currentHostModel.text = [NSString stringWithFormat:@"当前Host：%@", mtHostNumIndex && mtHostNumIndex.integerValue < self.hostNameList.count ? self.hostNameList[mtHostNumIndex.integerValue] : (self.hostNameList.firstObject ? self.hostNameList.firstObject : @"")];
    
    @{
        @"height" : @(self.alertViewHeight),
        kExternContent :  self.contentModelList
    }
    .bind(@"MTHostListView")
    .bindClick(^(NSNumber* index) {
        
        if(![index isKindOfClass:NSNumber.class])
            return;
        
        if(index.integerValue >= weakSelf.hostNameList.count)
            return;
        
        [[NSUserDefaults standardUserDefaults] setObject:index forKey:MTHostNumViewIndex];
    
//        NSLog(@"%@ === %zd", weakSelf.hostNameList[index.integerValue], index.integerValue);
        [MTHostManager registerHostManager].hostNum = weakSelf.hostNameList[index.integerValue].mt_index ? weakSelf.hostNameList[index.integerValue].mt_index.integerValue : index.integerValue;
        
        [[NSUserDefaults standardUserDefaults] setObject:@([MTHostManager registerHostManager].hostNum) forKey:MTHostNum];
    })
    .alertView(
               mt_AlertConfigMake(-1, -1, YES, CGPointZero)
               );
}

-(void)setHostNameList:(NSArray<NSString *> *)hostNameList
{
    _hostNameList = hostNameList;
    
    NSNumber* mtHostNum = [[NSUserDefaults standardUserDefaults] objectForKey:MTHostNum];
    [MTHostManager registerHostManager].hostNum = mtHostNum ? mtHostNum.integerValue : (hostNameList[0].mt_index ? hostNameList[0].mt_index.integerValue : 0);
    [self.contentModelList removeAllObjects];
    self.alertViewHeight = 60 + 50;
    
    if(!hostNameList.count)
        return;
    
    [self.contentModelList addObject:
     @{
         kTitle : self.currentHostModel
     }
     .bind(@"MTHostListViewCell")
     .bindHeight(60)
     ];
    
    for (NSString* hostName in hostNameList) {
        [self.contentModelList addObject:@{
            kTitle : mt_content(hostName)
        }
         .bind(@"MTHostListViewCell")
         .automaticDimension()
         ];
    }
    
    [self.contentModelList addObject:
     @{
         kTitle : mt_content(
                             mt_WordStyleMake(15, @"取消", hex(0x999999))
                             .horizontalAlignment(NSTextAlignmentCenter)
                             )
     }
     .bind(@"MTHostListViewCell")
     .bindHeight(50)
     ];
    
    self.alertViewHeight += hostNameList.count * 44;
    self.alertViewHeight += (hostNameList.count + 1);
    CGFloat maxHeight = kScreenHeight_mt() - kNavigationBarHeight_mt() - kTabBarHeight_mt() - doubles(60);
    
    if(self.alertViewHeight > maxHeight)
        self.alertViewHeight = maxHeight;
}

-(NSMutableArray *)contentModelList
{
    if(!_contentModelList)
    {
        _contentModelList = NSMutableArray.new;
    }
    
    return _contentModelList;
}

-(MTBaseViewContentModel *)currentHostModel
{
    if(!_currentHostModel)
    {
        _currentHostModel = mt_content(
                                       mt_WordStyleMake(14, nil, hex(0xdbb76c))
                                       .horizontalAlignment(NSTextAlignmentCenter)
                                       );
    }
    
    return _currentHostModel;
}

@end

@interface MTHostListView : MTDelegateCollectionView<UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) CGFloat height;

@end

@implementation MTHostListView

-(void)whenGetResponseObject:(NSDictionary *)dict
{
    self.mt_click = dict.mt_click;
    self.height = [dict[@"height"] floatValue];
    [self reloadDataWithDataList:dict[kExternContent] SectionList:@[

        mt_empty().bindSpacing(mt_collectionViewSpacingMake(1, 1, UIEdgeInsetsZero))
    ]];
}

-(void)setupDefault
{
    self.defaultViewContent(
                            hex(0xf0f0f0),
                            mt_BorderStyleMake(0, 6, nil)
                            );
    
    self.showsVerticalScrollIndicator = false;
    self.bounces = false;
    self.contentInset = UIEdgeInsetsZero;
    
    [self addTarget:self];
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    return CGSizeMake(200, self.height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.row)
        return;
    
    if(self.mt_click)
        self.mt_click(@(indexPath.row - 1));
}

-(Class)classOfResponseObject{return [NSDictionary class];}

@end


@interface MTHostListViewCell : MTBaseCollectionViewCell @end

@implementation MTHostListViewCell

-(void)setupDefault
{
    [super setupDefault];
        
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.defaultViewContent(
                                      mt_WordStyleMake(15, nil, hex(0x4d63fd))
                                      .horizontalAlignment(NSTextAlignmentCenter)
                                      );
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    if(self.mt_automaticDimension)
        contentHeight = 44;
    
    self.textLabel.frame = CGRectMake(0, 0, contentWidth, contentHeight);
    
    return CGSizeMake(contentWidth, contentHeight);
}

@end
