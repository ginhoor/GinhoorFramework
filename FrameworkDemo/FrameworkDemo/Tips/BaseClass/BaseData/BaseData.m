//
//  BaseData.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseData.h"

@implementation BaseData

+ (instancetype)data:(NSDictionary *)jsonData
{
    NSError *__autoreleasing error = nil;
    
    id data = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:jsonData error:&error];
    
    if (error) {
        NSLog(@"%s error--->%@",__func__,error);
    }
    return data;
}

@end
