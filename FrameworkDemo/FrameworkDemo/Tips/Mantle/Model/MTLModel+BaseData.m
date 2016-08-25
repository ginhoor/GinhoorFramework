//
//  MTLModel+BaseData.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/25.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "MTLModel+BaseData.h"

@implementation MTLModel (BaseData)

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
