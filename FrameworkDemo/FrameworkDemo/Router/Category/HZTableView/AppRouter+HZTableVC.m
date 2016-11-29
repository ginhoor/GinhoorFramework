//
//  AppRouter+HZTableVC.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+HZTableVC.h"

NSString * const kTargetHZTableVCAction = @"HZTableVCAction";
NSString * const kActionHZTableViewController = @"HZTableViewController";
@implementation AppRouter (HZTableVC)

- (UIViewController *)HZTableViewController
{
    return [self performTargetName:kTargetHZTableVCAction actionName:kActionHZTableViewController params:nil];
}

@end
