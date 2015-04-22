//
//  UIView+BaseClass.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+GinBaseClass.h"

@implementation UIView (GinBaseClass)

#pragma mark- 交换方法实现

+ (void)load
{    
    //    交换deallac方法
    Method init = class_getInstanceMethod([self class], NSSelectorFromString(@"init"));
    Method initSwizzle = class_getInstanceMethod([self class], @selector(initSwizzle));
    method_exchangeImplementations(init, initSwizzle);
    
}

- (instancetype)initSwizzle
{
    self = [self initSwizzle];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
}

- (void)prepareForAutoLayout
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
