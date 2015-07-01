//
//  LocationManager.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//


#import "LocationManager.h"

@interface LocationManager() <CLLocationManagerDelegate>
@property (strong, nonatomic, readwrite) CLLocationManager *manager;
@property (strong, nonatomic, readwrite) CLLocation *location;
@property (assign, nonatomic, readwrite) CGPoint point;

@property (assign, nonatomic) BOOL isLoaded;
@end

@implementation LocationManager

+ (instancetype)sharedInstance
{
    static LocationManager *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[LocationManager alloc] init];
    });
    return share;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if ([GinSysInfo iOS8]) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [self.manager requestAlwaysAuthorization];
        } else {
            [self.manager startUpdatingLocation];
        }
    } else {
        if (CLLocationManager.locationServicesEnabled) {
            [self.manager startUpdatingLocation];
        }
    }
    self.isLoaded = NO;
    
}


- (CLLocationManager *)manager
{
    if (!_manager) {
        
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        //选择定位的方式为最优的状态，他又四种方式在文档中能查到
        _manager.desiredAccuracy=kCLLocationAccuracyBest;
        //发生事件的最小距离间隔
        _manager.distanceFilter = 1000.0f;
    }
    return _manager;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [manager startUpdatingLocation];
            break;
        default:
            break;
    }
}

- (CGPoint)currentLocationPoint
{
#ifdef DEBUG
    return CGPointMake(30.12313, 130.4213123);
#else
    return CGPointMake(self.location.coordinate.latitude, self.location.coordinate.longitude);
#endif
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    
    self.location = locations.firstObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerDidUpdateLocations object:locations.firstObject];
    
    self.isLoaded = YES;
    
}


+ (BOOL)isLoaded
{
    return [LocationManager sharedInstance].isLoaded;
}

+ (BOOL)isLocationEnable
{
    DDLogInfo(@"location status: %d",[CLLocationManager authorizationStatus]);
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    return status != kCLAuthorizationStatusNotDetermined &&
    status != kCLAuthorizationStatusDenied &&
    status != kCLAuthorizationStatusRestricted;
}

@end