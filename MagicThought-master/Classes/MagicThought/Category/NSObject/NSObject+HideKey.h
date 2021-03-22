//
//  NSObject+HideKey.h
//  8kqw
//
//  Created by 八块钱网 on 2017/1/5.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (HideKey)

+(void)getKeyName;


@end

@interface NSObject (Pasteboard)

-(instancetype)copyToPasteboard;

@end
