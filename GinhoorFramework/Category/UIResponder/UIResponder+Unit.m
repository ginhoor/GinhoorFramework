//
//  UIResponder+Unit.m
//  LOLBox
//
//  Created by JunhuaShao on 15/3/3.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import "UIResponder+Unit.h"

@implementation UIResponder (Unit)

- (UIViewController *)recentlyController
{
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:[UIViewController class]];
    return controller;
}

- (UIViewController *)controlerByClass:(Class)mClass
{
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:mClass];
    return controller;
}


- (UINavigationController *)recentlyNavigationContoller
{
    UINavigationController *controller = (UINavigationController *)[self objectInResponder:self.nextResponder class:[UINavigationController class]];
    
    return controller;
}



- (UIResponder *)objectInResponder:(UIResponder *)responder class:(Class)class{
    if ([responder isKindOfClass:class]) {
        return responder;
    } else {
        return [self objectInResponder:responder.nextResponder class:class];
    }
}

@end
