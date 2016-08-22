//
//  BaseData.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Mantle.h>

@interface BaseData : MTLModel

+ (instancetype)data:(NSDictionary *)jsonData;

@end
