//
//  StoreLoactionMapViewController.m
//  
//
//  Created by JunhuaShao on 15/6/11.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//


#import "StoreLocationMapViewController.h"
#import <MapKit/MapKit.h>
#import "UIAlertView+GinUnit.h"
#import "LocationManager.h"
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Utils/BMKNavigation.h>

static NSString *annotationReuseId = @"Annotation";

@interface StoreLocationMapViewController ()
@property (strong, nonatomic) BMKPointAnnotation* pointAnnotation;
@property (assign, nonatomic) CLLocationCoordinate2D destinationLocation;
@end

@implementation StoreLocationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*****
 
    需要先在AppDelegate配置中 设置
 
 self.mapManager = [[BMKMapManager alloc]init];
 // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
 BOOL ret = [self.mapManager start:BAIDUMAP_API_KEY  generalDelegate:nil];
 if (!ret) {
 DDLogInfo(@"manager start failed!");
 }
 
 另外，定位需要在info中增加描述字段 NSLocationAlwaysUsageDescription
 
*****/

    CGPoint locationPoint = CGPointMake(123, 123);
    
    self.destinationLocation = CLLocationCoordinate2DMake(locationPoint.x, locationPoint.y);
    
    BMKCoordinateRegion region = {self.destinationLocation, {0.01, 0.01}};
    self.mapView.region = region;
    
    self.pointAnnotation = [[BMKPointAnnotation alloc]init];
    self.pointAnnotation.coordinate = self.destinationLocation;
    self.pointAnnotation.title = @"测试";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.mapView addAnnotation:self.pointAnnotation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if (annotation == self.pointAnnotation) {

        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationReuseId];
        
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationReuseId];
            annotationView.pinColor = BMKPinAnnotationColorRed;
            [annotationView setSelected:YES animated:NO];

            
            UIView *paopaoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
            paopaoView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
            paopaoView.layer.cornerRadius = 4;
            paopaoView.layer.masksToBounds = YES;
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 120, 44)];
            [paopaoView addSubview:titleLabel];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = annotationView.annotation.title;
            
            UIButton *navButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 5, 60, 34)];
            [paopaoView addSubview:navButton];
            [navButton addTarget:self action:@selector(navAction:) forControlEvents:UIControlEventTouchUpInside];
            [navButton setTitle:@"导航" forState:UIControlStateNormal];
            navButton.layer.cornerRadius = 4;
            navButton.layer.masksToBounds = YES;
            navButton.backgroundColor = [UIColor lightGrayColor];

            annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
            
        }
        return annotationView;
    }
    
    return nil;    
}


- (void)navAction:(id)sender
{
    if (![LocationManager isLocationEnable]) {
        [UIAlertView alertView:@"导航失败" message:@"定位权限未开启" cancelTitle:@"确定" cancelBlock:^{
            ;
        }];
        return;
    }
    
    if (![LocationManager isLoaded]) {
        [UIAlertView alertView:@"导航失败" message:@"当前位置尚未定位完成，请稍后再试" cancelTitle:@"确定" cancelBlock:^{
            ;
        }];
        return;
    }
    
    CLLocationCoordinate2D startLocation = self.locationServer.userLocation.location.coordinate;
    NSString *urlString;
    //        http://developer.baidu.com/map/uri-intro.htm#idmykey37
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        urlString= [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving",startLocation.latitude,startLocation.longitude,self.destinationLocation.latitude,self.destinationLocation.longitude,@"测试地址"];
        
        
    } else {
        urlString= [NSString stringWithFormat:@"http://api.map.baidu.com/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving&region=全国&output=html",startLocation.latitude,startLocation.longitude,self.destinationLocation.latitude,self.destinationLocation.longitude,@"测试地址"];
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
}


- (void)baiduMapNavigation:(BMK_NAVI_TYPE)type startLocationName:(NSString *)startLocationName startLocation:(CLLocationCoordinate2D)startLocation endName:(NSString *)endLocationName endLocation:(CLLocationCoordinate2D)endLocation
{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //指定导航类型
//    para.naviType = type;
    
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    start.pt = startLocation;
    //指定起点名称
    start.name = startLocationName;
    //指定起点
    para.startPoint = start;

    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //指定终点经纬度
    end.pt = endLocation;
    //指定终点名称
    end.name = endLocationName;
    //指定终点
    para.endPoint = end;
    
    //指定返回自定义scheme
    para.appScheme = @"hme://baidu-map";
    
    //调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];
}


@end
