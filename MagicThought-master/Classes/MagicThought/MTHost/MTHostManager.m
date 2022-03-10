//
//  MTHostManager.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2021/5/29.
//

#import "MTHostManager.h"
#import "MTProjectArchitectureManager.h"
#import "NSObject+ReuseIdentifier.h"
#import "MJExtension.h"

@interface MTHostManager ()
    
@property (nonatomic,strong) NSMutableDictionary* hostModelDict;

@property (nonatomic,assign) NSInteger onlineHostNum;


@end

@implementation MTHostManager

-(void)setupDefault
{
    [self.hostModelDict removeAllObjects];
    
    self.onlineHostNum = [kArchitectureManager_mt.baseHostModelDict[kHostOnlineNum] integerValue];
        
    Class c = NSClassFromString(kArchitectureManager_mt.baseHostModelDict.mt_reuseIdentifier);
        
    __weak typeof(self) weakSelf = self;
    [kArchitectureManager_mt.baseHostModelDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if(![key isKindOfClass:NSNumber.class])
            return;
        if(![obj isKindOfClass:NSDictionary.class])
            return;
        
        weakSelf.hostModelDict[key] = c ? [c mj_objectWithKeyValues:obj] : obj;
    }];
}

+(instancetype)registerHostManager{return [self manager];}

-(id)currentHostModel
{
    if(kArchitectureManager_mt.isOnline)
        return self.hostModelDict[@(self.onlineHostNum)];
    
    return self.hostModelDict[@(self.hostNum)];
}

-(NSMutableDictionary *)hostModelDict
{
    if(!_hostModelDict)
    {
        _hostModelDict = NSMutableDictionary.new;
    }
    
    return _hostModelDict;
}

@end
