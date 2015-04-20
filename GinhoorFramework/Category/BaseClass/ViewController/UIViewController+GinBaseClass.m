//
//  UIViewController+BaseClass.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "UIViewController+GinBaseClass.h"

@implementation UIViewController (GinBaseClass)

+ (instancetype)controller
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
    return [storyBoard instantiateInitialViewController];
}

+ (instancetype)controllerByDefaultName
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)controllerByStoryboard:(UIStoryboard *)storyboard
{
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (UIViewController *)lastPresentedViewController
{
    return [self getChildPresentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)getChildPresentViewController:(UIViewController *)parentViewController
{
    if (parentViewController.presentedViewController == nil) {
        return parentViewController;
    } else {
        return [self getChildPresentViewController:parentViewController.presentedViewController];
    }
}

@end
