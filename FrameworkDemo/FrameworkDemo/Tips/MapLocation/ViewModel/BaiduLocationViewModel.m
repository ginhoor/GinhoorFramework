//
//  BaiduLocationViewModel.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/7/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaiduLocationViewModel.h"
#import "LocationManager.h"


@interface BaiduLocationViewModel() <BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) BMKGeoCodeSearch *geoCodeSearcher;

@end

@implementation BaiduLocationViewModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLocationManagerDidUpdateLocations object:nil];
    [self cleanDelegate];
}

- (void)cleanDelegate
{
    self.geoCodeSearcher.delegate = nil;
}

#pragma mark- 百度地图定位

- (BMKGeoCodeSearch *)geoCodeSearcher
{
    if (!_geoCodeSearcher) {
        _geoCodeSearcher = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearcher.delegate = self;
    }
    return _geoCodeSearcher;
}

- (void)searchCurrentLocationByGeoCode
{
    //发起反向地理编码检索
    if ([LocationManager isLoaded]) {
        [self startReverseGeoCodeSearch];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startReverseGeoCodeSearch) name:kLocationManagerDidUpdateLocations object:nil];
    }
}

- (void)startReverseGeoCodeSearch
{
    CLLocationCoordinate2D pt = [LocationManager sharedInstance].location.coordinate;
    
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoCodeSearcher reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag) {
        NSLog(@"反geo检索发送成功");
    }
    else {
        NSLog(@"反geo检索发送失败");
        if (self.onGetReverseGeoCodeResultBlock) {
            self.onGetReverseGeoCodeResultBlock(self.geoCodeSearcher,nil,-1);
        }
    }
}

- (void)searchLocation:(NSString *)city address:(NSString *)address
{
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city = city?:@"";
    geoCodeSearchOption.address = address;
    
    BOOL flag = [self.geoCodeSearcher geoCode:geoCodeSearchOption];
    if(flag) {
        NSLog(@"geo检索发送成功");
    }
    else {
        NSLog(@"geo检索发送失败");
        if (self.onGetGeoCodeResultBlock) {
            self.onGetGeoCodeResultBlock(self.geoCodeSearcher,nil,-1);
        }
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.onGetGeoCodeResultBlock) {
        self.onGetGeoCodeResultBlock(searcher,result,error);
    }
}

//接收反向地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.onGetReverseGeoCodeResultBlock) {
        self.onGetReverseGeoCodeResultBlock(searcher,result,error);
    }
    
    //************* Demo
    //    if (error == BMK_SEARCH_NO_ERROR) {
    //      //在此处理正常结果
    //    }
    //    else {
    //        NSLog(@"抱歉，未找到结果");
    //    }
}



@end
