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

@interface MTLoginController ()

propertyClass(NSMutableArray, loginDataList)

propertyClass(NSMutableDictionary, loginSetupDefaultDict)


@end

@implementation MTLoginController

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
    
    self.loginServiceModel.tagIdentifier = nil;
    
    NSMutableArray* dataList = NSMutableArray.new;
    
    __weak typeof(self) weakSelf = self;
    
    for (NSObject* data in loginDataList) {
    
        MTClick dataClick = data.mt_click;
        NSString* mt_reuseIdentifier = data.mt_reuseIdentifier;
        
        self.loginServiceModel.tagIdentifier = [self.loginServiceModel.tagIdentifier stringByAppendingString:data.mt_tagIdentifier];
        
        [self configSetupDefault:data.mt_tagIdentifier];
        
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
                
                dataClick(indexPath);
            });
        }
        
        if([data.mt_tagIdentifier isEqualToString:kIsVfcode])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if(indexPath.mt_order.mt_tag == kTextFieldValueChange)
                    weakSelf.loginServiceModel.vfCode = indexPath.mt_order.mt_tagIdentifier;
                
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
                                    
                dataClick(indexPath);
                if(isLoad)
                   [weakSelf loadData];
            });
        }
        
        if([data.mt_tagIdentifier isEqualToString:kIsLogin])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if([weakSelf.loginServiceModel canLogin])
                    dataClick(indexPath);
            });
        }
        
        [dataList addObject:data];
    }
    
    return dataList;
}

-(void)configSetupDefault:(NSString*)tagIdentifier
{
    MTSetupDefaultModel* setupDefaultModel = kArchitectureManager_mt.loginSetupDefaultDict[tagIdentifier];
    
    if([tagIdentifier isEqualToString:kIsVfcode])
    {
        if(!setupDefaultModel)
            setupDefaultModel = MTSetupDefaultModel.new;
        
        MTSetContentModel setContentModel = setupDefaultModel.setContentModel;
         
        __weak __typeof(self) weakSelf = self;
        setupDefaultModel.setContentModel = ^(MTBaseCollectionViewCell* cell, MTViewContentModel *contentModel) {
                        
            [cell.timerModel removeObserver:cell];
            if(![cell.mt_order containsString:@"isAssistCell"])
            {
                cell.timerModel = weakSelf.loginServiceModel.timerModel;
                [cell.timerModel addObserver:self];
                
                [cell.timeRecordModel clearTimeRecord];
                
                {
                    NSTimeInterval vfCodeTotalSecond = [contentModel.mtTimeRecord getTotalSecond];
                    if(!vfCodeTotalSecond)
                        vfCodeTotalSecond = weakSelf.loginServiceModel.maxVfCodeTotalSecond;
                    
                    NSTimeInterval isOver = [MTTimer didValueBetweenCurrentZoneTimeStampAndLastStamp:[kUserDefaults_mt() integerForKey:weakSelf.loginServiceModel.vfCodeIdentifier] IsOver:vfCodeTotalSecond];
                    
                    cell.timeRecordModel.addSecond(isOver < 0 ? -isOver : 0);
                }
            }
                        
            if(setContentModel)
                setContentModel(cell, contentModel);
        };
        
        MTSetupDefault updateUIClick = setupDefaultModel.updateUIClick;
        
        setupDefaultModel.updateUIClick = ^(MTBaseCollectionViewCell* cell) {
          
            [cell.timeRecordModel reduceTImeWithModel:cell.timerModel];
                        
            if(weakSelf.loginServiceModel.isVfCodeOver >= 0)
                [cell.timeRecordModel clearTimeRecord];
                                        
            if(updateUIClick)
                updateUIClick(cell);
        };
    }
    
    self.loginSetupDefaultDict[tagIdentifier] = setupDefaultModel;
}

-(void)loadData
{
    [self.loginDataList removeAllObjects];
    [self.loginSetupDefaultDict removeAllObjects];
    
    BOOL isAllArray = kArchitectureManager_mt.loginDataList.isAllArray;
    
    if(!isAllArray)
        self.loginDataList = (id)[self configLoginDataList:kArchitectureManager_mt.loginDataList];
    else
    {
        self.loginDataList = NSMutableArray.new;
        for (NSArray* array in kArchitectureManager_mt.loginDataList)
            [self.loginDataList addObject:[self configLoginDataList:array]];
    }
    
    [super loadData];
}

-(NSArray *)dataList{return self.loginDataList;}

-(NSArray *)sectionList{return kArchitectureManager_mt.loginSectionList;}

-(NSDictionary *)setupDefaultDict{return kArchitectureManager_mt.loginSetupDefaultDict;}

emptyClassWithNew(MTLoginServiceModel, loginServiceModel, self)

emptyClass(NSMutableArray, loginDataList)

emptyClass(NSMutableDictionary, loginSetupDefaultDict)

@end
