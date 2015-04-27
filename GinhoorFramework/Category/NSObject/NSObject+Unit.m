//
//  NSObject+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/27.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+Unit.h"

@implementation NSObject (Unit)

+ (BOOL)isClassExist:(NSString *)className
{
    Class aClass = NSClassFromString(className);
    return aClass ? YES : NO;
}

@end
