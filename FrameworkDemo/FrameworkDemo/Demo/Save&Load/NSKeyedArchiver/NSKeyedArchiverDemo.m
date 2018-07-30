//
//  NSKeyedArchiverDemo.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSKeyedArchiverDemo.h"
#import "Gin_Macro.h"

@interface CityData : NSObject <NSCoding,NSCopying>
@end


@implementation NSKeyedArchiverDemo

+ (CityData *)currentCityData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[USER_DEFAULTS objectForKey:@"cityData"]];
}

+ (void)setCurrentCityData:(CityData *)cityData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cityData];
    [USER_DEFAULTS setObject:data forKey:@"cityData"];
}


@end
