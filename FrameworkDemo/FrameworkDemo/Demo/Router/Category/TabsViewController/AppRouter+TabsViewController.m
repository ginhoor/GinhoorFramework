//
//  AppRouter+TabsViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+TabsViewController.h"

NSString * const kTargetTabs = @"TabsVCAction";
NSString * const kActionTabsViewController = @"tabsViewController";

@implementation AppRouter (TabsViewController)

- (UIViewController *)tabsViewController
{
    return [self performTargetName:kTargetTabs actionName:kActionTabsViewController params:nil];
}

@end
