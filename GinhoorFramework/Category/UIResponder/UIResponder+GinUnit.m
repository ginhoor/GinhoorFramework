//
//  UIResponder+GinUnit.m
//  LOLBox
//
//  Created by JunhuaShao on 15/3/3.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import "UIResponder+GinUnit.h"

@implementation UIResponder (GinUnit)

- (UIViewController *)recentlyController
{
    if (!self.nextResponder) {
        return nil;
    }
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:[UIViewController class]];
    return controller;
}

- (UIViewController *)controlerByClass:(Class)mClass
{
    if (!self.nextResponder) {
        return nil;
    }
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:mClass];
    return controller;
}

- (UINavigationController *)recentlyNavigationContoller
{
    if (!self.nextResponder) {
        return nil;
    }
    UINavigationController *controller = (UINavigationController *)[self objectInResponder:self.nextResponder class:[UINavigationController class]];
    
    return controller;
}

- (UIResponder *)findObjectInResponderByclass:(Class)className
{
    if ([self isKindOfClass:className]) {
        return self;
    } else if (self.nextResponder) {
        return [self.nextResponder findObjectInResponderByclass:className];
    } else {
        return nil;
    }
}

@end
