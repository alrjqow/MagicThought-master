//
//  MTContentModelPropertyConst.h
//  QXProject
//
//  Created by 王奕聪 on 2019/12/22.
//  Copyright © 2019 monda. All rights reserved.
//

#import <UIKit/UIKit.h>

CG_EXTERN NSString* kTitle;
CG_EXTERN NSString* kContent;
CG_EXTERN NSString* kContent2;
CG_EXTERN NSString* kContent3;
CG_EXTERN NSString* kContent4;
CG_EXTERN NSString* kContent5;
CG_EXTERN NSString* kContent6;
CG_EXTERN NSString* kContent7;
CG_EXTERN NSString* kContent8;

CG_EXTERN NSString* kImg;
CG_EXTERN NSString* kImg2;
CG_EXTERN NSString* kImg3;
CG_EXTERN NSString* kImg4;
CG_EXTERN NSString* kImg5;
CG_EXTERN NSString* kImg6;
CG_EXTERN NSString* kImg7;
CG_EXTERN NSString* kImg8;
CG_EXTERN NSString* kImg9;

CG_EXTERN NSString* kBtnTitle;
CG_EXTERN NSString* kBtnTitle2;
CG_EXTERN NSString* kBtnTitle3;
CG_EXTERN NSString* kBtnTitle4;
CG_EXTERN NSString* kBtnTitle5;
CG_EXTERN NSString* kBtnTitle6;
CG_EXTERN NSString* kBtnTitle7;
CG_EXTERN NSString* kBtnTitle8;
CG_EXTERN NSString* kBtnTitle9;

CG_EXTERN NSString* kTextField;
CG_EXTERN NSString* kTextView;

CG_EXTERN NSString* kBackground;

CG_EXTERN NSString* kExternContent;
CG_EXTERN NSString* kWeakExternContent;

CG_EXTERN NSString* kDataSourceModel;

CG_EXTERN NSString* kSepLineWidth;
CG_EXTERN NSString* kIsCloseSepLine;
CG_EXTERN NSString* kIsArrow;

CG_EXTERN NSString* kMargin;
CG_EXTERN NSString* kHidden;
CG_EXTERN NSString* kMaxWidth;
CG_EXTERN NSString* kMaxHeight;
CG_EXTERN NSString* kMinWidth;
CG_EXTERN NSString* kMinHeight;
CG_EXTERN NSString* kExternData;

CG_EXTERN NSString* kTimer;
CG_EXTERN NSString* kTimeRecord;

CG_EXTERN NSString* kVfCodeString;


CG_EXTERN NSString* kViewState;

CG_EXTERN NSString* kNotification;
CG_EXTERN NSString* kPostNotification;

/**viewState*/
/**按钮无高亮*/
typedef enum : NSInteger {
     kNone = -2,
     kResult = -1,
     kDefault = 0,
     kNoHighlighted = 100,
     kNoAutoMtClick = 101,
     kHighlighted = 102,
     kDisabled = 103,
     kSelected = 104,
     kDeselected = 105,
     kPlaceholder = 106,
     kHeader = 107,
     kFooter = 108,
     kBeginEditing = 109,
     kEndEditing = 110,
    kNew = 111,
    kOld = 112,
    kSelectedForever = 113,
    kDefaultForever = 114,
    kAppear = 115,
    kDisappear = 116,
    kEndEditingReturn = 117,    
    kTextFieldValueChange = 118,
    kTextViewValueChange = 119,
    kTextFieldEndEditing = 120,
    kTextViewEndEditing = 121,
    kTextFieldEndEditingReturn = 122,
    kTextViewEndEditingReturn = 123,
    
} MTViewState;
