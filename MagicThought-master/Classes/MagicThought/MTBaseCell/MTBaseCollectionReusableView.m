//
//  MTBaseCollectionReusableView.m
//  SimpleProject
//
//  Created by monda on 2019/5/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseCollectionReusableView.h"
#import "MTContentModelPropertyConst.h"

@interface MTBaseCollectionReusableView ()
{
    UIButton* _button;
    UIButton* _button2;
    UIButton* _button3;
    UIButton* _button4;
}

@end

@implementation MTBaseCollectionReusableView

-(void)whenGetResponseObject:(MTViewContentModel *)contentModel
{
    self.contentModel = contentModel;
}

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    __weak __typeof(self) weakSelf = self;
    
    _contentModel = contentModel;
    
    self.baseContentModel = contentModel;
    
    [self setSubView:_textLabel Model:contentModel.mtTitle For:^UIView *{
        return weakSelf.textLabel;
    }];
    
    [self setSubView:_detailTextLabel Model:contentModel.mtContent For:^UIView *{
        return weakSelf.detailTextLabel;
    }];
    
    [self setSubView:_detailTextLabel2 Model:contentModel.mtContent2 For:^UIView *{
        return weakSelf.detailTextLabel2;
    }];
    
    [self setSubView:_detailTextLabel3 Model:contentModel.mtContent3 For:^UIView *{
        return weakSelf.detailTextLabel3;
    }];
    
    [self setSubView:_imageView Model:contentModel.mtImg For:^UIView *{
        return weakSelf.imageView;
    }];
    
    [self setSubView:_imageView2 Model:contentModel.mtImg2 For:^UIView *{
        return weakSelf.imageView2;
    }];
    
    [self setSubView:_imageView3 Model:contentModel.mtImg3 For:^UIView *{
        return weakSelf.imageView3;
    }];
    
    [self setSubView:_imageView4 Model:contentModel.mtImg4 For:^UIView *{
        return weakSelf.imageView4;
    }];
    
    [self setSubView:_button Model:contentModel.mtBtnTitle For:^UIView *{
        return weakSelf.button;
    }];
    
    [self setSubView:_button2 Model:contentModel.mtBtnTitle2 For:^UIView *{
        return weakSelf.button2;
    }];
    
    [self setSubView:_button3 Model:contentModel.mtBtnTitle3 For:^UIView *{
        return weakSelf.button3;
    }];
    
    [self setSubView:_button4 Model:contentModel.mtBtnTitle4 For:^UIView *{
        return weakSelf.button4;
    }];
       
    [self setSubView:_externView Model:(MTBaseViewContentModel*)contentModel.mtExternContent For:^UIView *{
        return weakSelf.externView;
                                 }];
}

-(void)setSubView:(UIView*)view Model:(MTBaseViewContentModel*)baseViewContentModel For:(UIView* (^)(void))getView
{
    MTBaseViewContentModel* contentModel;
    if(baseViewContentModel)
    {
        if(!view && !getView)
            return;
        if(!view)
            view = getView();
        if(!view)
            return;
        contentModel = baseViewContentModel;
    }
    else
    {
        if(!view)
            return;
        contentModel = view.defaultViewContent;
    }
    
    [self setSubView:view Model:contentModel];
}

-(void)setSubView:(UIView*)view Model:(MTBaseViewContentModel*)baseViewContentModel
{
    NSInteger startViewState = kDefault;
    MTBaseViewContentModel* dataModel;
    MTBaseViewContentModel* reSetModel;
     if([baseViewContentModel isKindOfClass:[NSDictionary class]])
     {
         NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)baseViewContentModel];
         NSNumber* viewState = dict[kViewState];
         if([viewState isKindOfClass:[NSNumber class]])
             startViewState = viewState.integerValue;
         
         dict[kViewState] = @(self.contentModel.viewState);
         dataModel = (MTBaseViewContentModel*)dict;
         
         if(dict[@"beDefault"])
             reSetModel = view.defaultViewContent;
         else
             reSetModel = view.baseContentModel;
     }
    else if([baseViewContentModel isKindOfClass:[MTBaseViewContentModel class]])
    {
        startViewState = baseViewContentModel.viewState;
        
        if(baseViewContentModel.viewState == kDefault)
            baseViewContentModel.viewState = self.contentModel.viewState;
        dataModel = baseViewContentModel;
        
        reSetModel = baseViewContentModel;
    }
    else
    {
        if(baseViewContentModel)
            view.objects(baseViewContentModel);
        return;
    }
    
    if(view == _externView)
        view.objects(dataModel);
    else
        view.baseContentModel = dataModel;
    
    reSetModel.viewState = startViewState;
}

-(void)configButton:(UIButton*)button WithOrder:(NSString*)order
{
    button.bindOrder(order);
    [button setValue:@(YES) forKey:@"autoClick"];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(void)buttonClick:(UIButton*)btn
{
//    btn.selected = !btn.selected;
//    NSObject* obj = @(self.section).bindOrder(btn.mt_order);
//    if(btn.mt_click)
//        btn.mt_click(obj);
//    else if(self.mt_click)
//         self.mt_click(obj);
//    else if(self.baseContentModel.mt_click)
//         self.baseContentModel.mt_click(obj);
    
    if(btn.mt_tag != kSelectedForever && btn.mt_tag != kDefaultForever)
         btn.bindEnum(btn.mt_tag == kSelected ? kDeselected : kSelected);
     [self viewEventWithView:btn Data:@(self.section)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.mt_automaticDimension)
        return;
        
    [self layoutSubviewsForWidth:self.width Height:self.height];
}

#pragma mark - 懒加载

-(Class)classOfResponseObject
{
    return [MTViewContentModel class];
}

-(UILabel *)textLabel
{
    if(!_textLabel)
    {
        _textLabel = [UILabel new];
        [self addSubview:_textLabel];
    }
    
    return _textLabel;
}

-(UILabel *)detailTextLabel
{
    if(!_detailTextLabel)
    {
        _detailTextLabel = [UILabel new];
        [self addSubview:_detailTextLabel];
    }
    
    return _detailTextLabel;
}

-(UILabel *)detailTextLabel2
{
    if(!_detailTextLabel2)
    {
        _detailTextLabel2 = [UILabel new];
        [self addSubview:_detailTextLabel2];
    }
    
    return _detailTextLabel2;
}

-(UILabel *)detailTextLabel3
{
    if(!_detailTextLabel3)
    {
        _detailTextLabel3 = [UILabel new];
        [self addSubview:_detailTextLabel3];
    }
    
    return _detailTextLabel3;
}

-(UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
    }
    
    return _imageView;
}

-(UIImageView *)imageView2
{
    if(!_imageView2)
    {
        _imageView2 = [UIImageView new];
        [self addSubview:_imageView2];
    }
    
    return _imageView2;
}

-(UIImageView *)imageView3
{
    if(!_imageView3)
    {
        _imageView3 = [UIImageView new];
        [self addSubview:_imageView3];
    }
    
    return _imageView3;
}

-(UIImageView *)imageView4
{
    if(!_imageView4)
    {
        _imageView4 = [UIImageView new];
        [self addSubview:_imageView4];
    }
    
    return _imageView4;
}

-(void)setButton:(UIButton *)button
{
    _button = button;
    [self configButton:button WithOrder:kBtnTitle];
}

-(void)setButton2:(UIButton *)button2
{
    _button2 = button2;
    [self configButton:button2 WithOrder:kBtnTitle2];
}

-(void)setButton3:(UIButton *)button3
{
    _button3 = button3;
    [self configButton:button3 WithOrder:kBtnTitle3];
}

-(void)setButton4:(UIButton *)button4
{
    _button4 = button4;
    [self configButton:button4 WithOrder:kBtnTitle4];
}

-(UIButton *)button
{
    if(!_button)
    {
        self.button = [UIButton new];
    }
    
    return _button;
}

-(UIButton *)button2
{
    if(!_button2)
    {
        self.button2 = [UIButton new];
    }
    
    return _button2;
}

-(UIButton *)button3
{
    if(!_button3)
    {
        self.button3 = [UIButton new];
    }
    
    return _button3;
}

-(UIButton *)button4
{
    if(!_button4)
    {
        self.button4 = [UIButton new];
    }
    
    return _button4;
}

-(UIView *)externView
{
    if(!_externView)
    {
        _externView = [UIView new];
        [self addSubview:_externView];
    }
    
    return _externView;
}

@end



