//
//  MTPopTipServiceModel.h
//  MagicThought-master
//
//  Created by 王奕聪 on 2022/4/1.
//

#import "MTServiceModel.h"

#import <MTSwiftLibrary/MTSwiftLibrary-Swift.h>

@interface MTPopTipServiceModel : MTServiceModel

@property (nonatomic,strong, readonly) PopTip* popTip;

@property (nonatomic,assign) PopTipDirection direction;

@property (nonatomic,assign) CGRect fromRect;

@property (nonatomic,assign) CGSize popViewSize;

@property (nonatomic,strong) NSArray* dataList;

-(void)showPopTips;
-(void)dismissPopTips;

@end

