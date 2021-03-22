//
//  MTDeviceManager.m
//  8kqw
//
//  Created by 王奕聪 on 2017/3/20.
//  Copyright © 2017年 com.bkqw.app. All rights reserved.
//

#import "MTDeviceManager.h"
#import <AVFoundation/AVFoundation.h>

@interface MTDeviceManager ()

@property (nonatomic,assign) NSTimeInterval updateInterval;

@end

@implementation MTDeviceManager

/** 打开(关闭)闪光灯*/
+ (NSInteger)openOrCloseFlash
{
    static BOOL isOpenFlash = false;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            
            if (!isOpenFlash) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                isOpenFlash = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                isOpenFlash = false;
            }
            [device unlockForConfiguration];
            
            return isOpenFlash;
        }
        
        return -1;
    }
    
    return -1;
}

+(void)callMobile:(NSString *)number
{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", number];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}


//获取屏幕方向
+(void)getOrientationWithHandler:(BOOL (^)(UIDeviceOrientation))handler
{
    [[MTDeviceManager manager] startUpdateAccelerometerResult:handler];
}

- (void)startUpdateAccelerometerResult:(BOOL (^)(UIDeviceOrientation))result
{
    if ([self.motionManager isAccelerometerAvailable]) {
        //回调会一直调用,建议获取到就调用下面的停止方法，需要再重新开始，当然如果需求是实时不间断的话可以等离开页面之后再stop
        [self.motionManager stopAccelerometerUpdates];
        [self.motionManager setAccelerometerUpdateInterval:self.updateInterval];
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             UIDeviceOrientation orientation = UIDeviceOrientationUnknown;
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             double z = accelerometerData.acceleration.z;
             
             
             if((x > -0.75 && x < 0.75) && (z > -0.75 && z < 0.75))
                 orientation = y < 0 ? UIDeviceOrientationPortrait : UIDeviceOrientationPortraitUpsideDown;
             else if((y > -0.75 && y < 0.75) && (z > -0.75 && z < 0.75))
                 orientation = x < 0 ? UIDeviceOrientationLandscapeLeft : UIDeviceOrientationLandscapeRight;
             else if((x > -0.75 && x < 0.75) && (y > -0.75 && y < 0.75))
                 orientation = z < 0 ? UIDeviceOrientationFaceUp : UIDeviceOrientationFaceDown;
             
//             if(orientation == UIDeviceOrientationUnknown)
//                 NSLog(@"%lf=======%lf=======%lf",x, y, z);
//             NSLog(@"%zd", orientation);
             
             
             if(result && result(orientation))
                [[MTDeviceManager manager] stopMotionUpdate];
         }];
    }
}

- (void)stopMotionUpdate
{
    if ([self.motionManager isAccelerometerActive])
        [self.motionManager stopAccelerometerUpdates];
}

#pragma mark - 生命周期

- (void)dealloc
{
    [self stopMotionUpdate];
    _motionManager = nil;
}

#pragma mark - 懒加载

- (CMMotionManager *)motionManager
{
    if (!_motionManager) {
        self.updateInterval = 1.0/15.0;
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}


@end
