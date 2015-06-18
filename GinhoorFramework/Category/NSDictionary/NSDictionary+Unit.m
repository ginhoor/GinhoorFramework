//
//  NSDictionary+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/18.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSDictionary+Unit.h"

@implementation NSDictionary (Unit)

- (BOOL)isEmpty
{
    return !self || self.allKeys.count == 0;
}

- (BOOL)hasElements
{
    return (self && self.allKeys.count>0);
}

@end
