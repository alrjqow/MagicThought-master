//
//  MTLoginController.m
//  MagicThought-master
//
//  Created by apple on 2022/3/10.
//

#import "MTLoginController.h"
#import "MTContentModelPropertyConst.h"
#import "MTSetupDefaultModel.h"
#import "MTBaseCollectionViewCell.h"
#import "MTRequest.h"
#import "MTLoginServiceModel.h"

@interface MTLoginController ()

propertyClass(NSMutableArray, loginDataList)

propertyClass(NSMutableDictionary, loginSetupDefaultDict)

propertyClass(MTLoginServiceModel, loginServiceModel)

@end

@implementation MTLoginController

-(void)setupSubview
{
    [super setupSubview];
    
    if(self.loginServiceModel.setupSubview)
        self.loginServiceModel.setupSubview(self);
}


-(void)successDefaultHandle:(NSString *)tagIdentifier
{
    if(![tagIdentifier isEqualToString:kIsVfcode])
        return;
    
    [self.loginServiceModel startVfcodeCount];
}


-(NSArray*)configLoginDataList:(NSArray*)loginDataList
{
    if(!loginDataList.count)
        return loginDataList;
    
    NSMutableArray* dataList = NSMutableArray.new;
    
    __weak typeof(self) weakSelf = self;
    
    for (NSObject* data in loginDataList) {
    
        MTClick dataClick = data.mt_click;
        NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
        
        if(data.mt_tagIdentifier)
            self.loginServiceModel.tagIdentifier = [self.loginServiceModel.tagIdentifier stringByAppendingString:data.mt_tagIdentifier];
        
        [self configSetupDefault:data];
                
        if([data.mt_tagIdentifier isEqualToString:kIsUserPhone] || [data.mt_tagIdentifier isEqualToString:kIsPassword])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if(indexPath.mt_order.mt_tag == kTextFieldValueChange)
                {
                    NSString* tagIdentifier = indexPath.mt_order.mt_tagIdentifier;
                    
                    if([data.mt_tagIdentifier isEqualToString:kIsUserPhone])
                        weakSelf.loginServiceModel.userPhone = tagIdentifier;
                    
                    if([data.mt_tagIdentifier isEqualToString:kIsPassword])
                        weakSelf.loginServiceModel.password = tagIdentifier;
                }
                
                if(dataClick)
                    dataClick(indexPath);
            });
        }
        
        if([data.mt_tagIdentifier isEqualToString:kIsVfcode])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if(indexPath.mt_order.mt_tag == kTextFieldValueChange)
                    weakSelf.loginServiceModel.vfCode = indexPath.mt_order.mt_tagIdentifier;
                
                if(dataClick)
                    dataClick(indexPath);
            });
        }
        
        if([data.mt_tagIdentifier isEqualToString:kIsAgree])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                                
                BOOL isLoad = false;
                if([indexPath.mt_order isEqualToString:mt_reuseIdentifier] || [indexPath.mt_order isEqualToString:kBtnTitle])
                {
                    weakSelf.loginServiceModel.isAgree = !weakSelf.loginServiceModel.isAgree;
                    isLoad = YES;
                }
                                    
                if(dataClick)
                    dataClick(indexPath);
                if(isLoad)
                   [weakSelf loadData];
            });
        }
        
        if([data.mt_tagIdentifier isEqualToString:kIsGoback])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
                        
        if([data.mt_tagIdentifier isEqualToString:kIsLogin] || [data.mt_tagIdentifier isEqualToString:kIsRegister] || [data.mt_tagIdentifier isEqualToString:kIsForgetPassword])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if([weakSelf.loginServiceModel canLogin] && dataClick)
                    dataClick(indexPath);
            });
        }                
        
        if([data.mt_tagIdentifier isEqualToString:kIsGoToRegister] || [data.mt_tagIdentifier isEqualToString:kIsGoToForgetPassword])
            data.bindClick(^(NSIndexPath* indexPath) {
                
                MTLoginController* loginController = MTLoginController.new;
                loginController.loginServiceModel.bindTag([data.mt_tagIdentifier isEqualToString:kIsGoToRegister] ? kIsGoToRegister : kIsGoToForgetPassword);
                                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                
                SEL selector = [data.mt_tagIdentifier isEqualToString:kIsGoToRegister] ? @selector(configRegisterData:) : @selector(configForgetPasswordData:);
                if([[UIApplication sharedApplication].delegate respondsToSelector:selector])
                    [[UIApplication sharedApplication].delegate performSelector:selector withObject:loginController.loginServiceModel];
#pragma clang diagnostic pop                
                
                [weakSelf.navigationController pushViewController:loginController animated:YES];
            });
        
        [dataList addObject:data];
    }
    
    return dataList;
}

-(void)configSetupDefault:(NSObject*)data
{
    if(!data.mt_tagIdentifier)
        return;
        
    MTSetupDefaultModel* setupDefaultModel = kArchitectureManager_mt.loginSetupDefaultDict[data.mt_baseCellIdentifier];
    
    if([data.mt_tagIdentifier isEqualToString:kIsVfcode])
    {
        if(!setupDefaultModel)
            setupDefaultModel = MTSetupDefaultModel.new;
        
        __weak __typeof(self) weakSelf = self;
        
        MTSetContentModel setContentModel = setupDefaultModel.setContentModel;
        
        setupDefaultModel.adjustSetContentModel = ^(MTBaseCollectionViewCell* cell, MTViewContentModel *contentModel) {
                        
            [cell.timerModel removeObserver:cell];
            
            if(![cell.mt_order containsString:@"isAssistCell"])
            {
                cell.timerModel = weakSelf.loginServiceModel.timerModel;
                [cell.timerModel addObserver:cell];
                
                NSTimeInterval vfCodeTotalSecond = [contentModel.mtTimeRecord getTotalSecond];
                if(!vfCodeTotalSecond)
                    vfCodeTotalSecond = weakSelf.loginServiceModel.maxVfCodeTotalSecond;
                            
                NSTimeInterval isOver = [MTTimer didValueBetweenCurrentZoneTimeStampAndLastStamp:[kUserDefaults_mt() integerForKey:weakSelf.loginServiceModel.vfCodeIdentifier] IsOver:vfCodeTotalSecond];
                
                if(isOver < 0)
                   [weakSelf.loginServiceModel.timerModel start];                
            }
                        
            if(setContentModel)
                setContentModel(cell, contentModel);
        };
        
        MTSetupDefault updateUIClick = setupDefaultModel.updateUIClick;
        
        setupDefaultModel.adjustUpdateUIClick = ^(MTBaseCollectionViewCell* cell) {
          
            if([cell.mt_order containsString:@"isAssistCell"])
                return;
                        
            [cell.timeRecordModel clearTimeRecord];
                                
            NSTimeInterval vfCodeTotalSecond = [cell.contentModel.mtTimeRecord getTotalSecond];
            if(!vfCodeTotalSecond)
                vfCodeTotalSecond = weakSelf.loginServiceModel.maxVfCodeTotalSecond;
                        
            NSTimeInterval isOver = [MTTimer didValueBetweenCurrentZoneTimeStampAndLastStamp:[kUserDefaults_mt() integerForKey:weakSelf.loginServiceModel.vfCodeIdentifier] IsOver:vfCodeTotalSecond];
            
            cell.timeRecordModel.addSecond(isOver < 0 ? -isOver : 0);
                                        
            if(updateUIClick)
                updateUIClick(cell);
        };
    }
        
    self.loginSetupDefaultDict[data.mt_baseCellIdentifier] = setupDefaultModel;
}

-(void)loadData
{
    self.loginServiceModel.tagIdentifier = @"";
    [self.loginDataList removeAllObjects];
    [self.loginSetupDefaultDict removeAllObjects];
    
    BOOL isAllArray = self.loginServiceModel.dataList.isAllArray;
    
    if(!isAllArray)
        self.loginDataList = (id)[self configLoginDataList:self.loginServiceModel.dataList];
    else
    {
        self.loginDataList = NSMutableArray.new;
        for (NSArray* array in self.loginServiceModel.dataList)
            [self.loginDataList addObject:[self configLoginDataList:array]];
    }
    
    [super loadData];
}

-(NSArray *)dataList{return self.loginDataList;}

-(NSArray *)sectionList{return self.loginServiceModel.sectionList;}

-(NSDictionary *)setupDefaultDict{return kArchitectureManager_mt.loginSetupDefaultDict;}

emptyClassWithNew(MTLoginServiceModel, loginServiceModel, self)

emptyClass(NSMutableArray, loginDataList)

emptyClass(NSMutableDictionary, loginSetupDefaultDict)

@end
