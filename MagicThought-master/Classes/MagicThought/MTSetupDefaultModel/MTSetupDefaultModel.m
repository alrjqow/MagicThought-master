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

-(MTDrawRect)drawRect
{
    __weak __typeof(self) weakSelf = self;
    MTDrawRect drawRect = ^(MTSetupDefault drawRectHandle){
        
        if(!drawRectHandle)
            return weakSelf;
        
        weakSelf.drawRectHandle = drawRectHandle;
        
        return weakSelf;
    };
    
    return drawRect;
}

-(MTUpdateLayout)updateLayout
{
    __weak __typeof(self) weakSelf = self;
    MTUpdateLayout updateLayout = ^(MTUpdateLayoutSubviews updateLayoutSubviews){
        
        if(!updateLayoutSubviews)
            return weakSelf;
        
        weakSelf.updateLayoutSubviews = updateLayoutSubviews;
        
        return weakSelf;
        
    };
    
    return updateLayout;
}

-(MTConfigDataSource)configDataSource
{
    __weak __typeof(self) weakSelf = self;
    MTConfigDataSource configDataSource = ^(MTSetupDefault configDataSourceModel){
        
        if(!configDataSourceModel)
            return weakSelf;
        
        weakSelf.configDataSourceModel = configDataSourceModel;
        
        return weakSelf;
        
    };
    
    return configDataSource;
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
