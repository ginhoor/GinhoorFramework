//
//  BaiduLocationViewModel.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/7/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <BMapKit.h>
#import "BaiduLocationViewModel.h"
#import "LocationManager.h"

@interface BaiduLocationViewModel() <BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate>

@property (strong, nonatomic) BMKGeoCodeSearch *geoCodeSearcher;

@property (strong, nonatomic) BMKSuggestionSearch *suggestion;

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
    self.suggestion.delegate = nil;
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
    [self setupLocalCity];
}


#pragma mark- 百度地图定位

- (void)setupLocalCity
{
    self.geoCodeSearcher = [[BMKGeoCodeSearch alloc]init];
    self.geoCodeSearcher.delegate = self;
    
    //发起反向地理编码检索
    
    if ([LocationManager isLoaded]) {
        [self startGeoCodeSearch];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startGeoCodeSearch) name:kLocationManagerDidUpdateLocations object:nil];
    }
}

- (void)startGeoCodeSearch
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
    }
}

//接收反向地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (self.onGetReverseGeoCodeResultBlock) {
        self.onGetReverseGeoCodeResultBlock(searcher,result,error);
    }
    
    //************* Demo
    //    if (error == BMK_SEARCH_NO_ERROR) {
    //      //在此处理正常结果
    //        NSLog(@"当前城市:%@",result.addressDetail.city);
    //        self.localCity = [self.totalCityList bk_match:^BOOL(CityData *city) {
    //            NSRange foundRange = [result.addressDetail.city rangeOfString:city.name options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch range:NSMakeRange(0, result.addressDetail.city.length)];
    //            return foundRange.length > 0;
    //        }];
    //
    //        if (self.localCity) {
    //            [self.localCityButton setTitle:self.localCity.name forState:UIControlStateNormal];
    //
    //        } else {
    //            [self.localCityButton setTitle:@"定位失败" forState:UIControlStateNormal];
    //        }
    //    }
    //    else {
    //        NSLog(@"抱歉，未找到结果");
    //    }
}



@end
