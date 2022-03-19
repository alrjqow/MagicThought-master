//
//  MTSetupDefaultModel.m
//  MagicThought-master
//
//  Created by apple on 2022/3/10.
//

#import "MTSetupDefaultModel.h"

@implementation MTSetupDefaultModel

-(MTUpdateUI)updateUI
{
    __weak __typeof(self) weakSelf = self;
    MTUpdateUI updateUI = ^(MTSetupDefault updateUIClick){
        
        if(!updateUIClick)
            return weakSelf;
        
        weakSelf.updateUIClick = updateUIClick;
        
        return weakSelf;
    };
    
    return updateUI;
}

@end


MTSetupDefaultModel* mt_BaseCellDefaultModelMake(MTSetupDefault setupDefault, MTLayoutSubviews layoutSubviews, MTSetContentModel setContentModel)
{
    MTSetupDefaultModel* setupDefaultModel = MTSetupDefaultModel.new;
    setupDefaultModel.setupDefault = setupDefault;
    setupDefaultModel.layoutSubviews = layoutSubviews;
    setupDefaultModel.setContentModel = setContentModel;
    
    return setupDefaultModel;
}
