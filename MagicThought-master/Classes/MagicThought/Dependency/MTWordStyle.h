//
//  MTWordStyle.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/19.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    MTVerticalAlignmentMiddle = 0, // default
    MTVerticalAlignmentTop,
    MTVerticalAlignmentBottom,
} MTVerticalAlignment;

@class MTWordStyle;

typedef MTWordStyle* (^Bold)(BOOL bold);
typedef MTWordStyle* (^Thin)(BOOL thin);
typedef MTWordStyle* (^SpecialTag)(NSString* wordTag);
typedef MTWordStyle* (^AttributedWord)(BOOL isAttributedWord);
typedef MTWordStyle* (^VerticalAlignment)(MTVerticalAlignment verticalAlignment);
typedef MTWordStyle* (^HorizontalAlignment)(NSTextAlignment horizontalAlignment);
typedef MTWordStyle* (^LineSpacing)(CGFloat lineSpacing);
typedef MTWordStyle* (^Spacing)(CGFloat wordSpacing);
typedef MTWordStyle* (^NumberOfLines)(NSInteger wordNumberOfLines);
typedef MTWordStyle* (^LineBreakMode)(NSLineBreakMode wordLineBreakMode);
typedef MTWordStyle* (^MaximumLineHeight)(CGFloat maximumLineHeight);
typedef NSRange (^WordRangeMethod)(NSString* text);
typedef MTWordStyle* (^Range)(NSRange wordRange);
typedef MTWordStyle* (^RangeMethod)(WordRangeMethod wordRangeMethod);
typedef MTWordStyle* (^WordStyles)(NSArray<MTWordStyle*>* wordStyleList);
typedef MTWordStyle* (^WordReplaceTags)(NSArray<NSString*>* wordTagReplaceList);
typedef MTWordStyle* (^UnderLine)(NSInteger wordUnderLine);
typedef MTWordStyle* (^FontName)(NSString* wordFontName);

#define wordStyles(...) styleList(@[__VA_ARGS__])
#define wordReplaceTags(...) tagReplaceList(@[__VA_ARGS__])

@interface MTWordStyle : NSObject

@property (nonatomic,assign) BOOL isMake;

@property(nonatomic,assign) CGFloat wordSize;
@property(nonatomic,strong) NSString* wordName;
@property(nonatomic,strong) NSString* wordFontName;
@property(nonatomic,strong) UIColor* wordColor;
@property(nonatomic,strong, readonly) NSAttributedString *attributedWordName;

@property(nonatomic,assign) NSInteger wordUnderLine;

@property(nonatomic,assign) MTVerticalAlignment wordVerticalAlignment;
@property(nonatomic,assign) NSTextAlignment  wordHorizontalAlignment;

@property (nonatomic,assign) BOOL wordThin;
@property (nonatomic,assign) BOOL wordBold;
@property (nonatomic,assign) BOOL isAttributedWord;

/**特殊标记*/
@property (nonatomic,strong) NSString* wordTag;
/**去除特殊标记*/
@property (nonatomic,strong) NSArray<NSString*>* wordTagReplaceList;

@property(nonatomic,assign) CGFloat wordSpacing;
@property(nonatomic,assign) CGFloat wordLineSpacing;
@property(nonatomic,assign) NSInteger wordNumberOfLines;
@property(nonatomic,assign) NSLineBreakMode wordLineBreakMode;
@property(nonatomic,assign) CGFloat wordMaximumLineHeight;

@property (nonatomic,assign) NSRange wordRange;
@property (nonatomic,strong) NSArray<MTWordStyle*>* wordStyleList;
@property (nonatomic,copy)  WordRangeMethod wordRangeMethod;

/**为了能识别出宏 wordStyles*/
@property (nonatomic,assign,readonly)  NSInteger wordStyles;
@property (nonatomic,assign,readonly)  NSInteger wordReplaceTags;

@property (nonatomic,copy,readonly)  FontName fontName;
@property (nonatomic,copy,readonly)  MaximumLineHeight maximumLineHeight;
@property (nonatomic,copy,readonly)  WordReplaceTags tagReplaceList;
@property (nonatomic,copy,readonly)  WordStyles styleList;
@property (nonatomic,copy,readonly)  Range range;
@property (nonatomic,copy,readonly)  RangeMethod rangeMethod;
@property (nonatomic,copy,readonly)  NumberOfLines numberOfLines;
@property (nonatomic,copy,readonly)  LineBreakMode lineBreakMode;
@property (nonatomic,copy,readonly)  AttributedWord attributedWord;
@property (nonatomic,copy,readonly)  Spacing spacing;
@property (nonatomic,copy,readonly)  LineSpacing lineSpacing;
@property (nonatomic,copy,readonly)  VerticalAlignment verticalAlignment;
@property (nonatomic,copy,readonly)  HorizontalAlignment horizontalAlignment;
@property (nonatomic,copy,readonly)  Bold bold;
@property (nonatomic,copy,readonly)  Thin thin;
@property (nonatomic,copy,readonly)  SpecialTag specialTag;
@property (nonatomic,copy,readonly)  UnderLine underLine;

-(NSAttributedString *)createAttributedWordName:(NSString*)wordName;

@end


CG_EXTERN MTWordStyle* mt_WordStyleMake(CGFloat wordSize, NSString* wordName,UIColor* wordColor);
CG_EXTERN MTWordStyle* mt_AttributedWordStyleMake(CGFloat wordSize, NSString* wordName, UIColor* wordColor);

