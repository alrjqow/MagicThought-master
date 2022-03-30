//
//  MTPhotoCutController.h
//  XHProject
//
//  Created by apple on 2022/1/17.
//

#import "MTViewController.h"


@interface MTPhotoCutController : MTViewController

@property (nonatomic,strong) NSArray<UIImage*>* imageArray;

@property (nonatomic,assign) CGFloat whScale;

@property (nonatomic,strong) void (^didFinishGetImage)(NSArray<UIImage*>* imageArray);

@end

