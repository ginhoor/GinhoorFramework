//
//  BaiduMapViewController.h
//  
//
//  Created by JunhuaShao on 15/6/11.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#import <UIKit/UIKit.h>

@interface BaiduMapViewController : UIViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (strong, nonatomic,readonly) BMKMapView *mapView;
@property (strong, nonatomic,readonly) BMKLocationService *locationServer;
@end
