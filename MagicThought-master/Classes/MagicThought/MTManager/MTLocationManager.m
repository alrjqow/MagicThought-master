//
//  MTLocationManager.m
//  MyTool
//
//  Created by 王奕聪 on 2017/2/9.
//  Copyright © 2017年 com.king.app. All rights reserved.
//

#import "MTLocationManager.h"
#import "CLLocation+Mar.h"
#import "NSString+Exist.h"
#import "MTConst.h"

@interface MTLocationManager()<CLLocationManagerDelegate>

@property(nonatomic,assign) BOOL updating;

@end

@implementation MTLocationManager

-(CLLocationManager *)mgr
{
    if(!_mgr)
    {
        _mgr = [CLLocationManager new];
        _mgr.delegate = self;
        _mgr.distanceFilter = 50;
        _mgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //            mgr.allowsBackgroundLocationUpdates = true//ios9需要(当用requestWhenInUseAuthorization才需要,用于开启后台定位)
        [_mgr requestWhenInUseAuthorization];//ios8,9都需要
    }
    
    return _mgr;
}

-(CLGeocoder *)geoC
{
    if(!_geoC)
        _geoC = [CLGeocoder new];
    
    return _geoC;
}

-(void)goToMapApp:(NSString*)address
{
    if(![address isExist]) return;
    
    MTLocationManager* mgr = [MTLocationManager manager];
    
    __weak typeof (self) weakSelf = self;
    [mgr.geoC geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(error) return;
        
        CLPlacemark* mark = placemarks.firstObject;
        [weakSelf openMapWith:mark.location];
    }];
}

-(void)openMapWith:(CLLocation*)location
{
    if(!location) return;
    
    [MKMapItem openMapsWithItems:@[[MKMapItem mapItemForCurrentLocation],[[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil]]] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey:@(true)}];
    
    self.location = location;
}

-(void)getDeatilPosition:(CLLocation*)location
{
    if(!location) return;
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray
    *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                             objectForKey:@"AppleLanguages"];
    
    // 强制 成 简体中文
    [[NSUserDefaults
      standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                       nil] forKey:@"AppleLanguages"];
    
    
    MTLocationManager* mgr = [MTLocationManager manager];
    
    __weak typeof (self) weakSelf = self;
    [mgr.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(error) return;
        
        CLPlacemark* mark = placemarks.firstObject;
        
        
        //        NSLog(@"%@",mark.postalCode);
        NSLog(@"%@",mark.addressDictionary[@"City"]);
        //        NSLog(@"%@",mark.name);
        //        NSLog(@"%@",mark.addressDictionary[@"FormattedAddressLines"][0]);
        //        NSLog(@"%@",mark.addressDictionary[@"Name"]);
        //        NSLog(@"%@",mark.addressDictionary[@"State"]);
        //        NSLog(@"%@",mark.addressDictionary[@"Street"]);
        //        NSLog(@"%@",mark.addressDictionary[@"Thoroughfare"]);
        
        NSString* str = @"";
        if(mark.administrativeArea)
        {
            str = [str stringByAppendingString:mark.administrativeArea];
            if(mark.subAdministrativeArea)
                str = [str stringByAppendingString:mark.subAdministrativeArea];
            str = [str stringByAppendingString:@"·"];
        }
        if(mark.locality)
        {
            str = [str stringByAppendingString:mark.locality];
            if(mark.subLocality)
                str = [str stringByAppendingString:mark.subLocality];
            str = [str stringByAppendingString:@"·"];
        }
        if(mark.thoroughfare)
        {
            str = [str stringByAppendingString:mark.thoroughfare];
            if(mark.subThoroughfare)
                str = [str stringByAppendingString:mark.subThoroughfare];
        }
        else
        {
            if(mark.name)
                str = [str stringByAppendingString:mark.name];
            else if(mark.addressDictionary[@"Name"])
                str = [str stringByAppendingString:mark.addressDictionary[@"Name"]];
            else
                str = mark.addressDictionary[@"FormattedAddressLines"][0];
        }
        
        //        NSLog(@"%@",str);
        weakSelf.deatilPosition = str;
        weakSelf.city = mark.addressDictionary[@"City"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MTUpdatePositionFinishNotification object:nil];
        
        // 还原Device 的语言
        [[NSUserDefaults
          standardUserDefaults] setObject:userDefaultLanguages
         forKey:@"AppleLanguages"];
    }];
}

-(BOOL)canLocation
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    return [CLLocationManager locationServicesEnabled] && (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusAuthorizedAlways);
}

-(BOOL)startLocationUpdate;
{
    if([self canLocation] && !self.updating)
    {
        [self.mgr startUpdatingLocation];
        self.updating = YES;
        
        return YES;
    }
    
    return false;
}

-(void)stopLocationUpdate
{
    [self.mgr stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location = locations.lastObject;
    
    //    //用地球坐标进行反地理编码
    [[MTLocationManager manager] getDeatilPosition:location];
    
    location = [[location locationMarsFromEarth] locationBaiduFromMars];
    [MTLocationManager manager].location = location;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MTUpdateLocationFinishNotification object:nil];
    
    self.updating = false;
    //    NSLog(@"%@",@"定位完成");
}

@end
