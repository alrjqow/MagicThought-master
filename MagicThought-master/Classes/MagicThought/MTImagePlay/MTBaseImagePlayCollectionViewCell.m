//
//  MTBaseImagePlayCollectionViewCell.m
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/3/31.
//

#import "MTBaseImagePlayCollectionViewCell.h"


@interface MTBaseImagePlayCollectionViewCell ()
{
    MTImagePlayView * _imagePlayView;
}

@end

@implementation MTBaseImagePlayCollectionViewCell

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
    
    if([self.mt_order containsString:@"isAssistCell"])
        return;
    
    if(self.setupDefaultModel && self.setupDefaultModel.configDataSourceModel)
        self.setupDefaultModel.configDataSourceModel(self.dataSourceModel);
    
    _maxPageCount = self.dataSourceModel.dataList.count;
    
    [self.dataSourceModel reloadListView:_imagePlayView];    
}

-(void)setImagePlayView:(MTImagePlayView *)imagePlayView
{
    _imagePlayView = imagePlayView;
    
    __weak typeof(self) weakSelf = self;
    _imagePlayView.imagePlayViewModel.pageChange = ^(NSInteger currentPage) {
        
        NSInteger page = currentPage + 1;
        if(page > weakSelf.maxPageCount)
            page = weakSelf.maxPageCount;
                
        [weakSelf setupCurrentPage:page];
                
        if(weakSelf.setupDefaultModel && weakSelf.setupDefaultModel.updateUIClick)
            weakSelf.setupDefaultModel.updateUIClick(weakSelf);
                    
        if(weakSelf.setupDefaultModel && weakSelf.setupDefaultModel.updateLayoutSubviews)
            weakSelf.setupDefaultModel.updateLayoutSubviews(weakSelf, weakSelf.width, weakSelf.height);
    };
    
    [self addSubview:_imagePlayView];
}

-(void)setupCurrentPage:(NSInteger)page
{
    _currentPageCount = page;
    _pageControl.currentPage = page - 1;
}

-(MTImagePlayView *)imagePlayView
{
    if(!_imagePlayView)
    {        
        self.imagePlayView = MTImagePlayView.new;
    }
    
    return _imagePlayView;
}

-(MTDataSourceModel *)dataSourceModel
{
    if(!_dataSourceModel)
    {
        _dataSourceModel = MTDataSourceModel.new(self.imagePlayView);
    }
    
    return _dataSourceModel;
}

-(MTPageControl *)pageControl
{
    if(!_pageControl)
    {
        _pageControl = MTPageControl.new;
        [self.contentView addSubview:_pageControl];
    }
    
    return _pageControl;
}

@end
