//
//  BaiduLocationViewModel.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/7/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <BMapKit.h>
#import <Foundation/Foundation.h>

@interface BaiduLocationViewModel : NSObject

@property (copy, nonatomic) void(^onGetGeoCodeResultBlock)(BMKGeoCodeSearch *searcher,BMKGeoCodeResult *result,BMKSearchErrorCode error);

@property (copy, nonatomic) void(^onGetReverseGeoCodeResultBlock)(BMKGeoCodeSearch *searcher,BMKReverseGeoCodeResult *result,BMKSearchErrorCode error);

/**
 *  通过地址查经纬度
 *
 *  @param city    城市名
 *  @param address 地址
 */
- (void)searchLocation:(NSString *)city address:(NSString *)address;
/**
 *  通过当前定位查找经纬度
 */
- (void)searchCurrentLocationByGeoCode;

- (void)cleanDelegate;

@end
