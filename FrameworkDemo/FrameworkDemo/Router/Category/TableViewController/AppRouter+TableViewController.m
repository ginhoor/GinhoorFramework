//
//  AppRouter+TableViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+TableViewController.h"

NSString * const kTargetTableView = @"TableVCAction";

NSString * const kActionTableViewController = @"tableViewController";

@implementation AppRouter (TableViewController)

- (UIViewController *)tableViewController
{
    return [self performTargetName:kTargetTableView actionName:kActionTableViewController params:nil];
}

@end
