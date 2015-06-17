//
//  NSArray+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/15.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSArray+Unit.h"

@implementation NSArray (Unit)

- (BOOL)isEmpty
{
    return self.count>0;
}

- (BOOL)hasElement
{
    return (self && self.count>0);
}

@end
