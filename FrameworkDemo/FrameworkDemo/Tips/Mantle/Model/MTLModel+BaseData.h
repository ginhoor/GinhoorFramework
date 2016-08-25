//
//  MTLModel+BaseData.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/25.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Mantle.h>

@interface MTLModel (BaseData)

+ (instancetype)data:(NSDictionary *)jsonData;

@end
