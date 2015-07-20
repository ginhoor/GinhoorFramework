//
//  BaiduLocationViewModel.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/7/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduLocationViewModel : NSObject


@property (copy, nonatomic) void(^onGetReverseGeoCodeResultBlock)(BMKGeoCodeSearch *searcher,BMKReverseGeoCodeResult *result,BMKSearchErrorCode error);

- (void)cleanDelegate;

@end
