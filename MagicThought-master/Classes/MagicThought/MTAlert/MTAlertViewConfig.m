//
//  MTAlertViewConfig.m
//  MTalertView
//
//  Created by 王奕聪 on 2018/3/25.
//  Copyright © 2018年 王奕聪. All rights reserved.
//

#import "MTAlertViewConfig.h"
#import "MTAlertView.h"

#import "MTConst.h"
#import "NSString+WordHeight.h"
#import "NSString+Exist.h"

#import "MJExtension.h"

@interface MTAlertViewConfig ()

@property (nonatomic,weak) MTAlertView* alertView;

@property (nonatomic,assign) CGFloat detailHeight;
@property (nonatomic,assign) CGFloat alertViewHeight;

@end

@implementation MTAlertViewConfig

-(void)setupDefault
{
    [super setupDefault];
        
    [self setupStyle];
}

-(void)setupStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.borderStyle = mt_BorderStyleMake((1/[UIScreen mainScreen].scale), 4, hex(0xCCCCCC));
    
    self.mtContent = MTBaseViewContentModel.new(mt_WordStyleMake(12, nil, hex(0x333333)).lineSpacing(1).horizontalAlignment(NSTextAlignmentCenter), [UIColor clearColor]);
    self.mtContent2 = MTBaseViewContentModel.new(self.borderStyle.borderColor);
    
    self.width = kScreenWidth_mt() - 4 * 25;
    self.splitWidth = 1;
    
    self.buttonHeight = 50;
    self.innerMargin = 20;
    self.detailInnerMargin = 15;
    self.innerTopMargin = self.innerMargin;
    self.logoMargin = UIEdgeInsetsMake(0, 0, 12, 6);
}

#pragma mark - 弹出框
-(void)alert
{
    if(![self.mtTitle.wordStyle.wordName isExist])
        self.mtTitle.wordStyle = mt_WordStyleMake(18, mt_AppName(), hex(0x333333));
        
    self.alertView = [MTAlertView alertWithConfig:self];
    [self.alertView show];
}
-(void)hide
{
    [self.alertView hide];
}

#pragma mark - 懒加载

-(CGFloat)alertViewHeight
{
    CGFloat alertViewHeight = 0;
    
    CGFloat titleHeight = self.innerTopMargin + self.mtTitle.wordStyle.wordSize;
    
    CGFloat detailHeight = (self.mtTitle.text.length > 0  ? self.detailInnerMargin : self.innerMargin) + self.detailHeight;
    
    CGFloat buttonHeight = self.buttonModelList.count < 3 ? self.buttonHeight : self.buttonHeight * self.buttonModelList.count;
    buttonHeight += self.mtContent.text.length > 0  ? self.detailInnerMargin + 2 : self.innerMargin;
    
    alertViewHeight = titleHeight + detailHeight + buttonHeight;
    
    return alertViewHeight;
}

-(CGFloat)detailHeight
{
    CGFloat deatilHeight = 0;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.mtContent.wordStyle.wordLineSpacing; //设置行间距
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:self.mtContent.wordStyle.wordSize], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f};
     deatilHeight = [self.mtContent.text calculateHeightWithWidth:(self.width - 2*self.innerMargin) andAttribute:dic];
    
    return deatilHeight > 120 ? 120 : deatilHeight;
}

-(NSArray<MTBaseViewContentModel *> *)buttonModelList
{
    if(_buttonModelList.count <= 0)
    {
        _buttonModelList = @[
                            mt_stateContent(
                                            mt_WordStyleMake(15, @"确定", hex(0xE76153)),
                                            [UIColor whiteColor],
                                           mt_highlighted(mt_content(mt_textColor(hexa(0xE76153, 0.5))))
                                            )
                                ];
    }
    
    return _buttonModelList;
}

-(MTBaseViewContentModel *)mtTitle
{
    MTBaseViewContentModel* title = [super mtTitle];
    if(!title)
    {
        title = MTBaseViewContentModel.new(mt_WordStyleMake(18, mt_AppName(), hex(0x333333)));
        self.mtTitle = title;
    }
    
    return title;
}

+ (NSDictionary *)mj_objectClassInArray
{    
    return @{
        @"buttonModelList" : [MTAlertViewButtonConfig class]
    };
}

@end


@implementation MTAlertViewButtonConfig @end
