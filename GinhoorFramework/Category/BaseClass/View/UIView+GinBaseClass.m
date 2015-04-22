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

- (void)prepareForAutoLayout
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
