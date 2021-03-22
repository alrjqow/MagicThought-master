//
//  MTLocationManager.h
//  MyTool
//
//  Created by 王奕聪 on 2017/2/9.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MTLocationManager : MTManager

@property(nonatomic,strong) CLLocationManager* mgr;

@property(nonatomic,strong) CLGeocoder* geoC;

@property(nonatomic,strong) CLLocation* location;

@property(nonatomic,strong) NSString* deatilPosition;

@property(nonatomic,strong) NSString* city;

/*!
 根据具体地址打开地图app
 */
-(void)goToMapApp:(NSString*)address;

/*!
 根据地理坐标打开地图app
 */
-(void)openMapWith:(CLLocation*)location;

/*!
 判断定位是否可用
 */
-(BOOL)canLocation;

/*!
 开始定位
 */
-(BOOL)startLocationUpdate;

/*!
 结束定位
 */
-(void)stopLocationUpdate;




@end
