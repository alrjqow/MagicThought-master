//
//  MTBaseViewContentModel.m
//  QXProject
//
//  Created by monda on 2019/12/10.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTBaseViewContentModel.h"
#import "MJExtension.h"
#import "NSString+Exist.h"
#import "UILabel+Size.h"
#import "MTContentModelPropertyConst.h"

@interface MTBaseViewContentModel ()

@property (nonatomic,assign) CGFloat viewHeight;

@property (nonatomic,assign) BOOL isNoMatchHidden;
@property (nonatomic,assign) BOOL isNoMatchBackgroundColor;
@property (nonatomic,assign) BOOL isNoMatchText;
@property (nonatomic,assign) BOOL isNoMatchWordStyle;
@property (nonatomic,assign) BOOL isNoMatchBorderStyle;
@property (nonatomic,assign) BOOL isNoMatchShadowStyle;
@property (nonatomic,assign) BOOL isNoMatchJianBianStyle;
@property (nonatomic,assign) BOOL isNoMatchTextColor;
@property (nonatomic,assign) BOOL isNoMatchUserInteractionEnabled;
@property (nonatomic,assign) BOOL isNoMatchMargin;
@property (nonatomic,assign) BOOL isNoMatchKeyboardType;
@property (nonatomic,assign) BOOL isNoMatchPadding;
@property (nonatomic,assign) BOOL isNoMatchImage;
@property (nonatomic,assign) BOOL isNoMatchPlaceholderImage;
@property (nonatomic,assign) BOOL isNoMatchBackgroundImage;
@property (nonatomic,assign) BOOL isNoMatchVerticalAlignment;
@property (nonatomic,assign) BOOL isNoMatchHorizontalAlignment;
@property (nonatomic,assign) BOOL isNoMatchClearButtonMode;
@property (nonatomic,assign) BOOL isNoMatchReturnKeyType;
@property (nonatomic,assign) BOOL isNoMatchNoHighLight;


@property (nonatomic,weak) MTBaseViewContentModel* finalModel;
@property (nonatomic,weak) MTBaseViewContentModel* superModel;
@property (nonatomic,weak) MTBaseViewContentModel* superOriginModel;

@property (nonatomic,assign) MTBaseViewContentModel* isPlaceholder;

//关联的默认model
@property (nonatomic,weak) MTBaseViewContentModel* associatedDefaultModel;

//默认 model 关联的同级 model
@property (nonatomic,weak) MTBaseViewContentModel* associatedModel;

@end

@implementation MTBaseViewContentModel

-(BOOL)isDefaultOriginModel
{
    return self.superOriginModel.beDefault != nil || self.beDefault != nil;
}

-(instancetype)init
{
    if(self = [super init])
    {
        [self setupDefault];
    }
    
    return self;
}

-(instancetype)setWithObject:(NSObject *)obj
{
    [super setWithObject:obj];
    
    NSObject* data = [obj isKindOfClass:[NSReuseObject class]] ? ((NSReuseObject*)obj).data : obj;
    if([obj.mt_keyName isExist])
    {
        if(data)
        {
            if([obj.mt_keyName isEqualToString:kExternData])
                self.externData = data;
            else
                [self mj_setKeyValues:@{obj.mt_keyName : data}];
        }
        return self;
    }
                        
    NSDictionary* dict;
    obj = data;
    if([obj isKindOfClass:[NSDictionary class]])
        dict = (NSDictionary*)obj;
    else if([obj isKindOfClass:[NSString class]])
        dict = @{@"text" : obj};
    else if([obj isKindOfClass:[UIImage class]])
        dict = @{@"image" : obj};
    else if([obj isKindOfClass:[MTWordStyle class]])
        dict = @{@"wordStyle" : obj};
    else if([obj isKindOfClass:[MTBorderStyle class]])
        dict = @{@"borderStyle" : obj};
    else if([obj isKindOfClass:[MTShadowStyle class]])
        dict = @{@"shadowStyle" : obj};
    else if([obj isKindOfClass:[MTJianBianStyle class]])
        dict = @{@"jianBianStyle" : obj};
    else if([obj isKindOfClass:[UIColor class]])
        dict = @{@"backgroundColor" : obj};
    else if([obj isKindOfClass:[NSNumber class]])
        dict = @{@"viewState" : obj};
    else if([obj isKindOfClass:[NSValue class]])
        self.margin = (NSValue*)obj;
    else if([obj isKindOfClass:[MTBaseViewContentModel class]])
        dict = obj.mj_keyValues;
            
    return [self mj_setKeyValues:dict];
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    if([keyValues isKindOfClass:self])
        return keyValues;
        
    NSObject* externData;
    if([keyValues isKindOfClass:[NSDictionary class]])
        externData = ((NSDictionary*)keyValues)[kExternData];
        
    MTBaseViewContentModel* model = [super mj_objectWithKeyValues:keyValues context:context];
    if(externData && [model isKindOfClass:[MTBaseViewContentModel class]])
        model.externData = externData;
        
    return model;
}

-(void)setMt_tagIdentifier:(NSString *)mt_tagIdentifier
{
    if([self.mt_tagIdentifier isEqualToString:mt_tagIdentifier])
        return;
    
    [super setMt_tagIdentifier:mt_tagIdentifier];
    self.text = mt_tagIdentifier;
}

-(void)setViewState:(NSInteger)viewState
{
    _viewState = viewState;
    self.finalModel = nil;
}

-(CGFloat)viewHeight
{
    if(self.maxWidth.floatValue <= 0)
        return self.minHeight.floatValue > 0 ? self.minHeight.floatValue : 0;
            
    if(!_viewHeight)
    {
        _viewHeight = [UILabel getRectWithRect:CGRectMake(0, 0, self.maxWidth.floatValue, 0) WordStyle:self.wordStyle].size.height;
        if(_viewHeight)
        {
            if(self.maxHeight && _viewHeight > self.maxHeight.floatValue)
                _viewHeight = self.maxHeight.floatValue;
        }
        else
            _viewHeight = self.minHeight.floatValue > 0 ? self.minHeight.floatValue : 0.0000001;
    }
    
    return _viewHeight;
}

-(MTWordStyle *)wordStyle
{
    if(!_wordStyle)
        _wordStyle = MTWordStyle.new;
        
    if(self.text && _wordStyle.wordName != self.text)
        _wordStyle.wordName = self.text;
    if(self.textColor && _wordStyle.wordColor != self.textColor)
        _wordStyle.wordColor = self.textColor;
    
    if(self.beDefault)
    {
        NSString* defauleWordName = [_wordStyle valueForKey:@"defauleWordName"];
        if(!defauleWordName)
            [_wordStyle setValue:_wordStyle.wordName forKey:@"defauleWordName"];
        else
            _wordStyle.wordName = defauleWordName;
    }
        
    return _wordStyle;
}

-(NSString *)imageURL
{
    if(!_imageURL)
    {
        if([self.text isExist])
            _imageURL = self.text;
        else if([self.wordStyle.wordName isExist])
            _imageURL = self.wordStyle.wordName;
    }
    
    return _imageURL;
}

@end

@interface MTBaseViewContentStateModel ()
{
    MTBaseViewContentModel * _highlighted;
    MTBaseViewContentModel * _disabled;
    MTBaseViewContentModel * _selected;
    MTBaseViewContentModel * _placeholder;
    MTBaseViewContentModel * _header;
    MTBaseViewContentModel * _footer;
}

@property (nonatomic,weak) MTBaseViewContentModel* matchHighlighted;
@property (nonatomic,weak) MTBaseViewContentModel* matchDisabled;
@property (nonatomic,weak) MTBaseViewContentModel* matchSelected;
@property (nonatomic,weak) MTBaseViewContentModel* matchPlaceholder;

@end

@implementation MTBaseViewContentStateModel

-(void)setViewState:(NSInteger)viewState
{
    if([self.finalModel isKindOfClass:[MTBaseViewContentStateModel class]])
    {
        MTBaseViewContentStateModel* finalModel = (MTBaseViewContentStateModel*)self.finalModel;
        finalModel.matchHighlighted = finalModel.matchDisabled = finalModel.matchSelected = finalModel.matchPlaceholder = nil;
    }
        
    [super setViewState:viewState];
}

-(void)setHighlighted:(MTBaseViewContentModel *)highlighted
{
    _highlighted = highlighted;
    [_highlighted setValue:self forKey:@"superModel"];
    [_highlighted setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(void)setDisabled:(MTBaseViewContentModel *)disabled
{
    _disabled = disabled;
    [_disabled setValue:self forKey:@"superModel"];
    [_disabled setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(void)setSelected:(MTBaseViewContentModel *)selected
{
    _selected = selected;
    [_selected setValue:self forKey:@"superModel"];
    [_selected setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(void)setPlaceholder:(MTBaseViewContentModel *)placeholder
{
    _placeholder = placeholder;
    [_placeholder setValue:@(YES) forKey:@"isPlaceholder"];    
    [_placeholder setValue:self forKey:@"superModel"];
    [_placeholder setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(void)setHeader:(MTBaseViewContentModel *)header
{
    _header = header;
    [_header setValue:self forKey:@"superModel"];
    [_header setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(void)setFooter:(MTBaseViewContentModel *)footer
{
    _footer = footer;
    [_footer setValue:self forKey:@"superModel"];
    [_footer setValue:self.superOriginModel ? self.superOriginModel : self forKey:@"superOriginModel"];
}

-(MTBaseViewContentModel *)highlighted
{
    if(_highlighted && self.beDefault && !_highlighted.beDefault)
        _highlighted.beDefault = mt_empty().bindEnum(kHighlighted);
    return _highlighted;
}

-(MTBaseViewContentModel *)disabled
{
    if(_disabled && self.beDefault && !_disabled.beDefault)
        _disabled.beDefault = mt_empty().bindEnum(kDisabled);
    return _disabled;
}

-(MTBaseViewContentModel *)selected
{
    if(_selected && self.beDefault && !_selected.beDefault)
        _selected.beDefault = mt_empty().bindEnum(kSelected);
    return _selected;
}

-(MTBaseViewContentModel *)placeholder
{
    if(_placeholder && self.beDefault && !_placeholder.beDefault)
        _placeholder.beDefault = mt_empty().bindEnum(kPlaceholder);
    return _placeholder;
}

-(MTBaseViewContentModel *)header
{
    if(_header && self.beDefault && !_header.beDefault)
        _header.beDefault = mt_empty().bindEnum(kHeader);
    return _header;
}

-(MTBaseViewContentModel *)footer
{
    if(_footer && self.beDefault && !_footer.beDefault)
        _footer.beDefault = mt_empty().bindEnum(kFooter);
    return _footer;
}

@end

NSObject* _Nonnull mt_externData(NSObject* externData)
{return mt_reuse(externData).bindKey(kExternData);}

MTBaseViewContentModel* _Nonnull mt_highlighted(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"highlighted");}

MTBaseViewContentModel* _Nonnull mt_disabled(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"disabled");}

MTBaseViewContentModel* _Nonnull mt_selected(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"selected");}

MTBaseViewContentModel* _Nonnull mt_placeholder(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"placeholder");}

MTBaseViewContentModel* _Nonnull mt_header(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"header");}

MTBaseViewContentModel* _Nonnull mt_footer(MTBaseViewContentModel* _Nullable model)
{return model.bindKey(@"footer");}

NSObject* _Nonnull mt_beDefault(void)
{return mt_empty().bindKey(@"beDefault");}

NSObject* _Nonnull mt_userInteractionEnabled(BOOL userInteractionEnabled)
{return mt_reuse(@(userInteractionEnabled)).bindKey(@"userInteractionEnabled");}

NSObject* _Nonnull mt_verticalAlignment(MTViewContentVerticalAlignment verticalAlignment)
{return mt_reuse(@(verticalAlignment)).bindKey(@"verticalAlignment");}

NSObject* _Nonnull mt_horizontalAlignment(MTViewContentHorizontalAlignment horizontalAlignment)
{return mt_reuse(@(horizontalAlignment)).bindKey(@"horizontalAlignment");}

NSObject* _Nonnull mt_clearButtonMode(UITextFieldViewMode clearButtonMode)
{return mt_reuse(@(clearButtonMode)).bindKey(@"clearButtonMode");}

NSObject* _Nonnull mt_returnKeyType(UIReturnKeyType returnKeyType)
{return mt_reuse(@(returnKeyType)).bindKey(@"returnKeyType");}

NSObject* _Nonnull mt_keyboardType(UIKeyboardType keyboardType)
{return mt_reuse(@(keyboardType)).bindKey(@"keyboardType");}

NSString* _Nonnull mt_css(NSString* _Nullable str)
{return mt_reuse(str).bindKey(@"cssClass");}

NSObject* _Nonnull mt_textColor(UIColor* _Nullable color)
{return mt_reuse(color).bindKey(@"textColor");}

NSValue* _Nonnull mt_margin(UIEdgeInsets margin)
{
    return [NSValue valueWithUIEdgeInsets:margin];    
}

NSValue* _Nonnull mt_padding(UIEdgeInsets padding)
{
    return [NSValue valueWithUIEdgeInsets:padding].bindKey(@"padding");
}

NSObject* _Nonnull mt_hidden(BOOL hidden)
{    
    return mt_reuse(@(hidden)).bindKey(@"isHidden");
}

NSObject* _Nonnull mt_noHighLight(BOOL noHighLight)
{
    return mt_reuse(@(noHighLight)).bindKey(@"noHighLight");
}

NSObject* _Nonnull mt_maxWidth(CGFloat maxWidth)
{
    return mt_reuse(@(maxWidth)).bindKey(@"maxWidth");
}

NSObject* _Nonnull mt_maxHeight(CGFloat maxHeight)
{
    return mt_reuse(@(maxHeight)).bindKey(@"maxHeight");
}

NSObject* _Nonnull mt_minWidth(CGFloat minWidth)
{
    return mt_reuse(@(minWidth)).bindKey(@"minWidth");
}

NSObject* _Nonnull mt_minHeight(CGFloat minHeight)
{
    return mt_reuse(@(minHeight)).bindKey(@"minHeight");
}

NSObject* _Nonnull mt_image_bg(NSObject* _Nullable img_bg)
{return mt_reuse(img_bg).bindKey(@"image_bg");}

NSObject* _Nonnull mt_placeholderImage(id _Nullable placeholderImage)
{return mt_reuse(placeholderImage).bindKey(@"placeholderImage");}

NSObject* _Nonnull mt_image_url(NSString* _Nullable imageURL)
{return mt_reuse(imageURL).bindKey(@"imageURL");}

NSObject* _Nonnull mt_closeSepLine(BOOL isCloseSepLine)
{return mt_reuse(@(isCloseSepLine)).bindKey(kIsCloseSepLine);}

NSObject* _Nonnull mt_isArrow(BOOL isArrow)
{return mt_reuse(@(isArrow)).bindKey(kIsArrow);}

@implementation MTBaseViewContentModel(MJExtension)

+(NSArray *)mj_ignoredPropertyNames
{
    return @[
        @"viewHeight", @"isNoMatchHidden", @"isNoMatchBackgroundColor", @"isNoMatchText", @"isNoMatchWordStyle", @"isNoMatchBorderStyle", @"isNoMatchShadowStyle",
        @"isNoMatchJianBianStyle", @"isNoMatchTextColor", @"isNoMatchUserInteractionEnabled", @"isNoMatchMargin", @"isNoMatchKeyboardType", @"isNoMatchPadding", @"isNoMatchImage", @"isNoMatchPlaceholderImage", @"isNoMatchBackgroundImage", @"isNoMatchVerticalAlignment", @"isNoMatchHorizontalAlignment", @"isNoMatchClearButtonMode", @"finalModel", @"superModel", @"superOriginModel", @"isPlaceholder", @"associatedDefaultModel", @"associatedModel", @"matchHighlighted", @"matchDisabled", @"matchSelected", @"matchPlaceholder",@"isNoMatchReturnKeyType"
        ,@"isNoMatchNoHighLight"
    ];
}

-(NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary* dict = [super mj_keyValues];
    dict[@"backgroundColor"] = self.backgroundColor;
    dict[@"textColor"] = self.textColor;
    dict[@"image"] = self.image;
    dict[@"image_bg"] = self.image_bg;
    return dict;
}

@end
