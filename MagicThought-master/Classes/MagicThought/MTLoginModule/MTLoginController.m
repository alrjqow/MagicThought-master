//
//  MTLoginController.m
//  MagicThought-master
//
//  Created by apple on 2022/3/10.
//

#import "MTLoginController.h"
#import "MTContentModelPropertyConst.h"
#import "MTLoginServiceModel.h"

@interface MTLoginController ()

propertyClass(MTLoginServiceModel, loginServiceModel)

@end

@implementation MTLoginController

-(NSArray*)configLoginDataList:(NSArray*)loginDataList
{
    if(!loginDataList.count)
        return loginDataList;
    
    self.loginServiceModel.tagIdentifier = nil;
    
    NSMutableArray* dataList = NSMutableArray.new;
    
    __weak typeof(self) weakSelf = self;
    
    for (NSObject* data in loginDataList) {
    
        MTClick dataClick = data.mt_click;
        
        self.loginServiceModel.tagIdentifier = [self.loginServiceModel.tagIdentifier stringByAppendingString:data.mt_tagIdentifier];
        
        if([data.mt_tagIdentifier isEqualToString:kIsUserPhone] || [data.mt_tagIdentifier isEqualToString:kIsPassword] || [data.mt_tagIdentifier isEqualToString:kIsVfcode])
        {
            data.bindClick(^(NSIndexPath* indexPath) {
                
                if(indexPath.mt_order.mt_tag == kTextFieldValueChange)
                {
                    NSString* tagIdentifier = indexPath.mt_order.mt_tagIdentifier;
                    
                    if([data.mt_tagIdentifier isEqualToString:kIsUserPhone])
                        weakSelf.loginServiceModel.userPhone = tagIdentifier;
                    
                    if([data.mt_tagIdentifier isEqualToString:kIsPassword])
                        weakSelf.loginServiceModel.password = tagIdentifier;
                    
                    if([data.mt_tagIdentifier isEqualToString:kIsVfcode])
                        weakSelf.loginServiceModel.vfCode = tagIdentifier;
                }
                
                dataClick(indexPath);
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


-(NSArray *)dataList{
    
    NSMutableArray* loginDataList;
    
    BOOL isAllArray = kArchitectureManager_mt.loginDataList.isAllArray;
    
    if(!isAllArray)
        loginDataList = (id)[self configLoginDataList:kArchitectureManager_mt.loginDataList];
    else
    {
        loginDataList = NSMutableArray.new;
        for (NSArray* array in kArchitectureManager_mt.loginDataList)
            [loginDataList addObject:[self configLoginDataList:array]];
    }
        
    return loginDataList;
}

-(NSArray *)sectionList{return kArchitectureManager_mt.loginSectionList;}

emptyClassWithNew(MTLoginServiceModel, loginServiceModel, self)

@end
