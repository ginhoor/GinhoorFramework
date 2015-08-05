//
//  LocationManager.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

static  NSString  *const kLocationManagerDidUpdateLocations = @"kLocationManagerDidUpdateLocations";

@interface LocationManager : NSObject

@property (strong, nonatomic, readonly) CLLocationManager *manager;
@property (strong, nonatomic, readonly) CLLocation *location;
@property (assign, nonatomic, readonly) CGPoint currentLocationPoint;

+ (instancetype)sharedInstance;

+ (BOOL)isLoaded;

+ (BOOL)isLocationEnable;
@end
