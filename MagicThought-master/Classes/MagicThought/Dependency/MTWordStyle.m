//
//  MTWordStyle.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/19.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTWordStyle.h"
#import "NSString+Exist.h"
#import "NSObject+ReuseIdentifier.h"

#import "MJExtension.h"

@interface MTWordStyle ()

@property (nonatomic,strong) NSMutableParagraphStyle* paragraphStyle;

@property(nonatomic,strong) NSString* defauleWordName;

@end

@implementation MTWordStyle

+(NSArray *)mj_ignoredPropertyNames
{
    return @[@"lineSpacing", @"verticalAlignment", @"horizontalAlignment", @"bold", @"thin", @"attributedWord", @"attributedWordName", @"spacing", @"numberOfLines", @"lineBreakMode", @"attributedDict", @"paragraphStyle", @"range", @"wordRangeMethod", @"rangeMethod", @"wordStyleList", @"tagReplaceList", @"specialTag", @"maximumLineHeight",@"underLine",@"fontName", @"throughLine"];
}

-(UnderLine)underLine
{
    __weak __typeof(self) weakSelf = self;
    UnderLine underLine = ^(NSUnderlineStyle wordUnderLine){
        
        weakSelf.wordUnderLine = wordUnderLine;
        return weakSelf;
    };
    
    return underLine;
}

-(ThroughLine)throughLine
{
    __weak __typeof(self) weakSelf = self;
    ThroughLine throughLine = ^(NSUnderlineStyle wordThroughLine){
        
        weakSelf.wordThroughLine = wordThroughLine;
        return weakSelf;
    };
    
    return throughLine;
}

-(WordReplaceTags)tagReplaceList
{
    __weak __typeof(self) weakSelf = self;
    WordReplaceTags tagReplaceList = ^(NSArray<NSString*>* wordTagReplaceList){
        
        weakSelf.wordTagReplaceList = wordTagReplaceList;
        return weakSelf;
    };
    
    return tagReplaceList;
}

-(WordStyles)styleList
{
    __weak __typeof(self) weakSelf = self;
    WordStyles styleList = ^(NSArray<MTWordStyle*>* wordStyleList){
        
        weakSelf.wordStyleList = wordStyleList;
        return weakSelf;
    };
    
    return styleList;
}

-(RangeMethod)rangeMethod
{
    __weak __typeof(self) weakSelf = self;
    RangeMethod rangeMethod = ^(WordRangeMethod wordRangeMethod){
        
        weakSelf.wordRangeMethod = wordRangeMethod;
        return weakSelf;
    };
    
    return rangeMethod;
}

-(Range)range
{
    __weak __typeof(self) weakSelf = self;
       Range range = ^(NSRange wordRange){
           
           weakSelf.wordRange = wordRange;
           return weakSelf;
       };
       
       return range;
}

-(NumberOfLines)numberOfLines
{
    __weak __typeof(self) weakSelf = self;
    NumberOfLines numberOfLines = ^(NSInteger wordNumberOfLines){
        
        weakSelf.wordNumberOfLines = wordNumberOfLines;
        return weakSelf;
    };
    
    return numberOfLines;
}

-(LineBreakMode)lineBreakMode
{
    __weak __typeof(self) weakSelf = self;
    LineBreakMode lineBreakMode = ^(NSLineBreakMode wordLineBreakMode){
        
        weakSelf.wordLineBreakMode = wordLineBreakMode;
        return weakSelf;
    };
    
    return lineBreakMode;
}

-(AttributedWord)attributedWord
{
    __weak __typeof(self) weakSelf = self;
    AttributedWord attributedWord = ^(BOOL isAttributedWord){
        
        weakSelf.isAttributedWord = isAttributedWord;
        return weakSelf;
    };
    
    return attributedWord;
}

-(Bold)bold
{
    __weak __typeof(self) weakSelf = self;
    Bold wordBold = ^(BOOL bold){
        
        weakSelf.wordBold = bold;
        return weakSelf;
    };
    
    return wordBold;
}

-(Thin)thin
{
    __weak __typeof(self) weakSelf = self;
    Thin wordThin = ^(BOOL thin){
        
        weakSelf.wordThin = thin;
        return weakSelf;
    };
    
    return wordThin;
}

-(SpecialTag)specialTag
{
    __weak __typeof(self) weakSelf = self;
       SpecialTag specialTag = ^(NSString* wordTag){
           
           weakSelf.wordTag = wordTag;
           return weakSelf;
       };
       
       return specialTag;
}

-(VerticalAlignment)verticalAlignment
{
    __weak __typeof(self) weakSelf = self;
    VerticalAlignment verticalAlignment = ^(MTVerticalAlignment verticalAlignment){
        
        weakSelf.wordVerticalAlignment = verticalAlignment;
        return weakSelf;
    };
    
    return verticalAlignment;
}

-(HorizontalAlignment)horizontalAlignment
{
    __weak __typeof(self) weakSelf = self;
    HorizontalAlignment horizontalAlignment = ^(NSTextAlignment horizontalAlignment){
        
        weakSelf.wordHorizontalAlignment = horizontalAlignment;
        return weakSelf;
    };
    
    return horizontalAlignment;
}

-(Spacing)spacing
{
    __weak __typeof(self) weakSelf = self;
    Spacing spacing = ^(CGFloat wordSpacing){
        
        weakSelf.wordSpacing = wordSpacing;
        return weakSelf;
    };
    
    return spacing;
}

-(LineSpacing)lineSpacing
{
    __weak __typeof(self) weakSelf = self;
    LineSpacing lineSpacing = ^(CGFloat lineSpacing){
        
        weakSelf.wordLineSpacing = lineSpacing;
        return weakSelf;
    };
    
    return lineSpacing;
}

-(MaximumLineHeight)maximumLineHeight
{
    __weak __typeof(self) weakSelf = self;
    MaximumLineHeight maximumLineHeight = ^(CGFloat maximumLineHeight){
        
        weakSelf.wordMaximumLineHeight = maximumLineHeight;
        return weakSelf;
    };
    
    return maximumLineHeight;
}

-(FontName)fontName
{
    __weak __typeof(self) weakSelf = self;
    FontName fontName = ^(NSString* wordFontName){
        
        weakSelf.wordFontName = wordFontName;
        return weakSelf;
    };
    
    return fontName;
}

-(void)setWordMaximumLineHeight:(CGFloat)wordMaximumLineHeight
{
    _wordMaximumLineHeight = wordMaximumLineHeight;
}

-(void)configAttributedDict
{
    [self.attributedDict removeAllObjects];
    
    self.paragraphStyle.alignment = self.wordHorizontalAlignment;
    if(self.wordLineSpacing < 1)
        self.wordLineSpacing = 1;
    self.paragraphStyle.lineSpacing = self.wordLineSpacing;
    self.paragraphStyle.maximumLineHeight = self.wordMaximumLineHeight;
    self.paragraphStyle.lineBreakMode = self.wordLineBreakMode;
    self.paragraphStyle.alignment = self.wordHorizontalAlignment;
    
    if(self.wordSpacing < 0.5)
        self.wordSpacing = 0.5;
    self.attributedDict[NSKernAttributeName] = @(self.wordSpacing);
    
    self.attributedDict[NSParagraphStyleAttributeName] = self.paragraphStyle;
    
    if(self.wordColor)
        self.attributedDict[NSForegroundColorAttributeName] = self.wordColor;
    
    if(self.wordSize)
    {
        UIFont* font;
        if([self.wordFontName isExist])
            font = [UIFont fontWithName:self.wordFontName size:self.wordSize];
        else
        {
            if((self.wordBold && self.wordThin) || (!self.wordBold && !self.wordThin) )
                font = [UIFont systemFontOfSize:self.wordSize];
            else if(self.wordBold)
                font = [UIFont boldSystemFontOfSize:self.wordSize];
            else if(self.wordThin)
            {
                if (@available(iOS 8.2, *))
                    font = [UIFont systemFontOfSize:self.wordSize weight:UIFontWeightThin];
                else
                    font = [UIFont systemFontOfSize:self.wordSize];
            }
        }
                
        self.attributedDict[NSFontAttributeName] = font;
                
        if(self.wordNumberOfLines == 1)
        {
            self.attributedDict[NSUnderlineStyleAttributeName] = @(self.wordUnderLine);
            self.attributedDict[NSStrikethroughStyleAttributeName] = @(self.wordThroughLine);
        }
    }
}

-(NSAttributedString *)attributedWordName
{
    if(![self.wordName isExist])
        return nil;
    
    NSString* wordName = [self.wordName.mt_tagIdentifier isExist] ? self.wordName.mt_tagIdentifier : self.wordName;
                    
    return [self createAttributedWordName:wordName];
}

-(NSAttributedString *)createAttributedWordName:(NSString*)wordName
{
    [self configAttributedDict];
    if(self.wordStyleList.count < 1)
        return [[NSAttributedString alloc] initWithString:wordName attributes:self.attributedDict];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:wordName];
    [attrStr addAttributes:self.attributedDict range:NSMakeRange(0, attrStr.length)];
    
    for (MTWordStyle* word in self.wordStyleList) {
        
        if(![word isKindOfClass:[MTWordStyle class]])
            continue;
        
        NSRange range = NSMakeRange(0, 0);
        
        if(!NSEqualRanges(word.wordRange, NSMakeRange(0, 0)))
            range = word.wordRange;
        else if(word.wordRangeMethod)
        {
            if([self.wordName.mt_tagIdentifier isExist])
            {
                NSString* replaceStr = self.wordName;
                for (NSString* replaceTag in self.wordTagReplaceList) {
                    if([replaceTag isEqualToString:word.wordTag])
                        continue;
                    
                    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:replaceTag withString:@""];
                }
                range = word.wordRangeMethod(replaceStr);
            }
            else
                range = word.wordRangeMethod(self.wordName);
        }
        
        if(range.location != NSNotFound)
        {
            if(range.location < 0 || range.location >= attrStr.length)
                range.location = 0;
            
            if(range.length < 0 || range.length > attrStr.length)
                range.length = attrStr.length;
            
            if((range.location + range.length - 1) >= attrStr.length)
                range = NSMakeRange(0, attrStr.length);
            
            [word configAttributedDict];
            [word.attributedDict removeObjectForKey:NSParagraphStyleAttributeName];
            [attrStr addAttributes:word.attributedDict range:range];
        }
    }
    
    return attrStr;
}

-(instancetype)init
{
    if(self = [super init])
    {
        self.wordNumberOfLines = 1;
        self.wordHorizontalAlignment = NSTextAlignmentNatural;        
    }
    
    return self;
}

-(instancetype)copyObject
{
    MTWordStyle* wordStyle = [super copyObject];
    if(self.wordStyleList)
    {
        NSMutableArray* wordStyleList = [NSMutableArray array];
        for (MTWordStyle* style in self.wordStyleList)
        {
            MTWordStyle* copyStyle = [style copyObject];
            if(style.wordRangeMethod)
                copyStyle.wordRangeMethod = [style.wordRangeMethod copy];
            [wordStyleList addObject:copyStyle];
        }
            
        
        wordStyle.wordStyleList = [wordStyleList copy];
    }
    
    return wordStyle;
}

-(NSMutableParagraphStyle *)paragraphStyle
{
    if(!_paragraphStyle)
    {
        _paragraphStyle = [NSMutableParagraphStyle new];
    }
    
    return _paragraphStyle;
}

-(NSMutableDictionary *)attributedDict
{
    if(!_attributedDict)
    {
        _attributedDict = [NSMutableDictionary dictionary];
    }
    
    return _attributedDict;
}

MTWordStyle* mt_WordStyleMake_Bold(CGFloat wordSize, UIColor* wordColor, NSString* wordName)
{
    MTWordStyle* word = mt_WordStyleMake(wordSize, wordColor, wordName);
    word.wordBold = YES;
    
    return word;
}

MTWordStyle* mt_WordStyleMake(CGFloat wordSize, UIColor* wordColor, NSString* wordName)
{
    MTWordStyle* word = [MTWordStyle new];
    
    word.wordSize = wordSize;
    word.wordName = wordName;
    word.wordColor = wordColor;
    word.isMake = YES;
    
    return word;
}

MTWordStyle* mt_AttributedWordStyleMake(CGFloat wordSize, UIColor* wordColor, NSString* wordName)
{
    MTWordStyle* word = [MTWordStyle new];
    
    word.isAttributedWord = YES;
    word.wordSize = wordSize;
    word.wordName = wordName;
    word.wordColor = wordColor;
    word.isMake = YES;
    
    return word;
}

@end
