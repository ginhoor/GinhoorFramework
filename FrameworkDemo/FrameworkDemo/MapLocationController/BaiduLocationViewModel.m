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

@interface BaiduLocationViewModel() <BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate ,BMKSuggestionSearchDelegate>

@property (strong, nonatomic) BMKGeoCodeSearch *geoCodeSearcher;
@property (strong, nonatomic) BMKPoiSearch *poiSearcher;
@property (strong, nonatomic) BMKSuggestionSearch *suggestion;

@end

@implementation BaiduLocationViewModel

- (void)dealloc
{
    [self cleanDelegate];
}

- (void)cleanDelegate
{
    self.geoCodeSearcher.delegate = nil;
    self.poiSearcher.delegate = nil;
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
    //初始化检索对象
    self.suggestion = [[BMKSuggestionSearch alloc]init];
    self.suggestion.delegate = self;
    
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = @"北京";
    option.keyword  = @"中关村";
    BOOL flag = [self.suggestion suggestionSearch:option];

    if(flag) {
        NSLog(@"建议检索发送成功");
    } else {
        NSLog(@"建议检索发送失败");
    }
    
}
//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


#pragma mark- 百度地图定位

- (void)setupLocalCity
{
    self.geoCodeSearcher = [[BMKGeoCodeSearch alloc]init];
    self.geoCodeSearcher.delegate = self;
    
    //发起反向地理编码检索
    
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
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"当前城市:%@",result.addressDetail.city);
        
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
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


////实现PoiSearchDeleage处理回调结果
//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResultList errorCode:(BMKSearchErrorCode)error
//{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        //在此处理正常结果
//        DDLogInfo(@"city--->%@",poiResultList);
//        DDLogInfo(@"city--->%@",poiResultList.cityList);
//    }
//    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
//        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
//        // result.cityList;
//        DDLogInfo(@"起始点有歧义");
//    } else {
//        DDLogInfo(@"抱歉，未找到结果");
//    }
//}


@end
