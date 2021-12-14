//
//  MTBaseCollectionViewCell.m
//  SimpleProject
//
//  Created by monda on 2019/5/13.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseCollectionViewCell.h"
#import "MTContentModelPropertyConst.h"

@interface MTBaseCollectionViewCell ()<UITextViewDelegate>
{
    UIButton* _button;
    UIButton* _button2;
    UIButton* _button3;
    UIButton* _button4;
    UIView* _externView;
}

@end


@implementation MTBaseCollectionViewCell

-(void)whenGetResponseObject:(MTViewContentModel *)contentModel
{
    self.contentModel = contentModel;
}

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    __weak __typeof(self) weakSelf = self;
    
    _contentModel = contentModel;
    contentModel.viewState = contentModel.viewState;
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
    
    [self setSubView:_textField Model:contentModel.mtTextField For:^UIView *{
        return weakSelf.textField;
    }];
    
    [self setSubView:_textView Model:contentModel.mtTextView For:^UIView *{
        return weakSelf.textView;
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
        dataModel.viewState = dataModel.viewState;
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
    {        
        if([view isKindOfClass:UIButton.class] || [view isKindOfClass:UIImageView.class])
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
                [dataModel performSelector:@selector(setIndexPath:WithDelegate:) withObject:self.indexPath withObject:self.mt_delegate];
        #pragma clang diagnostic pop
        view.baseContentModel = dataModel;
    }
    
    reSetModel.viewState = startViewState;
}

-(void)setupDefault
{
    [super setupDefault];
    
    self.isDragEnable = false;
    self.contentView.layer.zPosition = 3;
}

-(CGSize)layoutSubviewsForWidth:(CGFloat)contentWidth Height:(CGFloat)contentHeight
{
    [_externView sizeToFit];
    [_textLabel sizeToFit];
    [_detailTextLabel sizeToFit];
    [_detailTextLabel2 sizeToFit];
    [_detailTextLabel3 sizeToFit];
    
    [_imageView sizeToFit];
    [_imageView2 sizeToFit];
    [_imageView3 sizeToFit];
    [_imageView4 sizeToFit];
    
    [_button sizeToFit];
    [_button2 sizeToFit];
    [_button3 sizeToFit];
    [_button4 sizeToFit];
    
    [_textField sizeToFit];
    [_textView sizeToFit];
    
    return CGSizeZero;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
        
    if(self.mt_automaticDimension)
        return;    
                            
    [self layoutSubviewsForWidth:self.width Height:self.height];
}

-(void)configButton:(UIButton*)button WithOrder:(NSString*)order
{
    button.bindOrder(order);
    [button setValue:@(YES) forKey:@"autoClick"];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
}

-(void)buttonClick:(UIButton*)btn
{
    if(btn.mt_tag != kSelectedForever && btn.mt_tag != kDefaultForever)
    {
        btn.baseContentModel.viewState = btn.mt_tag == kSelected ? kDeselected : kSelected;
        btn.baseContentModel = btn.baseContentModel;        
    }
    [self viewEventWithView:btn Data:self.indexPath ? self.indexPath : mt_empty()];
}

#pragma mark - 代理

-(void)didTextValueChange:(UITextField *)textField
{
    textField.bindEnum(kTextFieldValueChange);
    textField.bindTagText(textField.text);
    [self viewEventWithView:_textField Data:self.indexPath];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.bindEnum(kBeginEditing);
    textField.bindTagText(textField.text);
    [self viewEventWithView:_textField Data:self.indexPath];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.bindEnum(kTextFieldEndEditing);
    textField.bindTagText(textField.text);
    [self viewEventWithView:_textField Data:self.indexPath];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    textField.bindEnum(kTextFieldEndEditingReturn);
    textField.bindTagText(textField.text);
    [self viewEventWithView:_textField Data:self.indexPath];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.baseContentModel.wordStyle.isAttributedWord)
        textView.attributedText = [textView.baseContentModel.wordStyle createAttributedWordName:textView.text];
    
    textView.bindEnum(kTextViewValueChange);
    textView.bindTagText(textView.text);
    [self viewEventWithView:textView Data:self.indexPath];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.baseContentModel.wordStyle.isAttributedWord)
           textView.attributedText = [textView.baseContentModel.wordStyle createAttributedWordName:textView.text];
    
    textView.bindEnum(kTextViewEndEditing);
    textView.bindTagText(textView.text);
//    textView.width = textView.width;
//    [textView sizeToFit];
    [self viewEventWithView:textView Data:self.indexPath.bindHeight(ceil(textView.height))];
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
        [self.contentView addSubview:_textLabel];
    }
    
    return _textLabel;
}

-(UILabel *)detailTextLabel
{
    if(!_detailTextLabel)
    {
        _detailTextLabel = [UILabel new];
        [self.contentView addSubview:_detailTextLabel];
    }
    
    return _detailTextLabel;
}

-(UILabel *)detailTextLabel2
{
    if(!_detailTextLabel2)
    {
        _detailTextLabel2 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel2];
    }
    
    return _detailTextLabel2;
}

-(UILabel *)detailTextLabel3
{
    if(!_detailTextLabel3)
    {
        _detailTextLabel3 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel3];
    }
    
    return _detailTextLabel3;
}

-(UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
    }
    
    return _imageView;
}

-(UIImageView *)imageView2
{
    if(!_imageView2)
    {
        _imageView2 = [UIImageView new];
        [self.contentView addSubview:_imageView2];
    }
    
    return _imageView2;
}

-(UIImageView *)imageView3
{
    if(!_imageView3)
    {
        _imageView3 = [UIImageView new];
        [self.contentView addSubview:_imageView3];
    }
    
    return _imageView3;
}

-(UIImageView *)imageView4
{
    if(!_imageView4)
    {
        _imageView4 = [UIImageView new];
        [self.contentView addSubview:_imageView4];
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

-(void)setExternView:(UIView *)externView
{
    _externView = externView;
    [self.contentView addSubview:externView];
}

-(UIView *)externView
{
    if(!_externView)
    {
        self.externView = [UIView new];
    }
    
    return _externView;
}

-(MTTextField *)textField
{
    if(!_textField)
    {
        _textField = [MTTextField new];
        _textField.mt_delegate = self;
        _textField.bindOrder([NSString stringWithFormat:@"%@",kTextField]);
        [self.contentView addSubview:_textField];
    }
    
    return _textField;
}

-(MTTextView *)textView
{
    if(!_textView)
    {
        _textView = [MTTextView new];
        _textView.mt_delegate = self;
        _textView.bindOrder([NSString stringWithFormat:@"%@",kTextView]);
        [self.contentView addSubview:_textView];
    }
    
    return _textView;
}

@end

@interface MTBaseSubCollectionViewCell ()
{
    UIButton* _button5;
}
@end

@implementation MTBaseSubCollectionViewCell

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
    
    __weak __typeof(self) weakSelf = self;
    
    [self setSubView:_detailTextLabel4 Model:contentModel.mtContent4 For:^UIView *{
        return weakSelf.detailTextLabel4;
    }];
    
    [self setSubView:_imageView5 Model:contentModel.mtImg5 For:^UIView *{
        return weakSelf.imageView5;
    }];
    
    [self setSubView:_button5 Model:contentModel.mtBtnTitle5 For:^UIView *{
        return weakSelf.button5;
    }];
}


#pragma mark - 懒加载

-(UILabel *)detailTextLabel4
{
    if(!_detailTextLabel4)
    {
        _detailTextLabel4 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel4];
    }
    
    return _detailTextLabel4;
}

- (UIImageView *)imageView5
{
    if(!_imageView5)
    {
        _imageView5 = [UIImageView new];
        [self.contentView addSubview:_imageView5];
    }
    
    return _imageView5;
}

-(void)setButton5:(UIButton *)button5
{
    _button5 = button5;
    [self configButton:button5 WithOrder:kBtnTitle5];
}

-(UIButton *)button5
{
    if(!_button5)
    {
        self.button5 = [UIButton new];
    }
    
    return _button5;
}

@end

@interface MTBaseSubCollectionViewCell2 ()
{
    UIButton* _button6;
}
@end

@implementation MTBaseSubCollectionViewCell2

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
    
    __weak __typeof(self) weakSelf = self;
    
    [self setSubView:_detailTextLabel5 Model:contentModel.mtContent5 For:^UIView *{
        return weakSelf.detailTextLabel5;
    }];
    
    [self setSubView:_imageView6 Model:contentModel.mtImg6 For:^UIView *{
        return weakSelf.imageView6;
    }];
    
    [self setSubView:_button6 Model:contentModel.mtBtnTitle6 For:^UIView *{
        return weakSelf.button6;
    }];
}

#pragma mark - 懒加载

-(UILabel *)detailTextLabel5
{
    if(!_detailTextLabel5)
    {
        _detailTextLabel5 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel5];
    }
    
    return _detailTextLabel5;
}

-(UIImageView *)imageView6
{
    if(!_imageView6)
    {
        _imageView6 = [UIImageView new];
        [self.contentView addSubview:_imageView6];
    }
    
    return _imageView6;
}

-(void)setButton6:(UIButton *)button6
{
    _button6 = button6;
    [self configButton:button6 WithOrder:kBtnTitle6];
}

-(UIButton *)button6
{
    if(!_button6)
    {
        self.button6 = [UIButton new];
    }
    
    return _button6;
}


@end

@implementation MTBaseSubCollectionViewCell3

-(void)setContentModel:(MTViewContentModel *)contentModel
{
    [super setContentModel:contentModel];
    
    __weak __typeof(self) weakSelf = self;
    
    [self setSubView:_detailTextLabel6 Model:contentModel.mtContent6 For:^UIView *{
        return weakSelf.detailTextLabel6;
    }];
    
    [self setSubView:_detailTextLabel7 Model:contentModel.mtContent7 For:^UIView *{
        return weakSelf.detailTextLabel7;
    }];
    
    [self setSubView:_detailTextLabel8 Model:contentModel.mtContent8 For:^UIView *{
        return weakSelf.detailTextLabel8;
    }];
    
 
    [self setSubView:_imageView7 Model:contentModel.mtImg7 For:^UIView *{
        return weakSelf.imageView7;
    }];
    
    [self setSubView:_imageView8 Model:contentModel.mtImg8 For:^UIView *{
        return weakSelf.imageView8;
    }];
    
    [self setSubView:_imageView9 Model:contentModel.mtImg9 For:^UIView *{
        return weakSelf.imageView9;
    }];
    
    [self setSubView:_button7 Model:contentModel.mtBtnTitle7 For:^UIView *{
        return weakSelf.button7;
    }];
    
    [self setSubView:_button8 Model:contentModel.mtBtnTitle8 For:^UIView *{
        return weakSelf.button8;
    }];
    
    [self setSubView:_button9 Model:contentModel.mtBtnTitle9 For:^UIView *{
        return weakSelf.button9;
    }];
}

#pragma mark - 懒加载

-(UILabel *)detailTextLabel6
{
    if(!_detailTextLabel6)
    {
        _detailTextLabel6 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel6];
    }
    
    return _detailTextLabel6;
}

-(UILabel *)detailTextLabel7
{
    if(!_detailTextLabel7)
    {
        _detailTextLabel7 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel7];
    }
    
    return _detailTextLabel7;
}

-(UILabel *)detailTextLabel8
{
    if(!_detailTextLabel8)
    {
        _detailTextLabel8 = [UILabel new];
        [self.contentView addSubview:_detailTextLabel8];
    }
    
    return _detailTextLabel8;
}

-(UIImageView *)imageView7
{
    if(!_imageView7)
    {
        _imageView7 = [UIImageView new];
        [self.contentView addSubview:_imageView7];
    }
    
    return _imageView7;
}

-(UIImageView *)imageView8
{
    if(!_imageView8)
    {
        _imageView8 = [UIImageView new];
        [self.contentView addSubview:_imageView8];
    }
    
    return _imageView8;
}

-(UIImageView *)imageView9
{
    if(!_imageView9)
    {
        _imageView9 = [UIImageView new];
        [self.contentView addSubview:_imageView9];
    }
    
    return _imageView9;
}

@end


