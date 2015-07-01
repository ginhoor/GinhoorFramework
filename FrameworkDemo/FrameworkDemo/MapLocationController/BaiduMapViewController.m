//
//  BaiduMapViewController.m
//  
//
//  Created by JunhuaShao on 15/6/11.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "BaiduMapViewController.h"

@interface BaiduMapViewController()
@property (strong, nonatomic,readwrite) BMKMapView *mapView;
@property (strong, nonatomic,readwrite) BMKLocationService *locationServer;

@end

@implementation BaiduMapViewController

- (void)dealloc
{
    if (self.mapView) {
        self.mapView = nil;
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    //设置地图缩放级别
    [self.mapView setZoomLevel:11];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [self.locationServer startUserLocationService];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil; // 不用时，置nil
    [self.locationServer stopUserLocationService];

}


- (BMKLocationService *)locationServer
{
    if (!_locationServer) {
        _locationServer = [[BMKLocationService alloc] init];
        _locationServer.delegate = self;
    }
    return _locationServer;
}


@end
