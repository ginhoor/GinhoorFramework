//
//  UIViewController+initController.m
//  LOLBox
//
//  Created by Ginhoor on 14-3-5.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "UIViewController+initController.h"

@implementation UIViewController (initController)

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
