//
//  AppRouter+Demo4ExtendMenu.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+Demo4ExtendMenu.h"

NSString * const kTargetDemo4ExtendMenuAction = @"ExtendMenuAction";
NSString * const kActionDynomicTableController = @"DynomicTableController";
NSString * const kActionExtendMenuController = @"ExtendMenuController";

@implementation AppRouter (Demo4ExtendMenu)

- (UIViewController *)DynomicTableController
{
    return [self performTargetName:kTargetDemo4ExtendMenuAction actionName:kActionDynomicTableController params:nil];
}

- (UIViewController *)ExtendMenuController
{
    return [self performTargetName:kTargetDemo4ExtendMenuAction actionName:kActionExtendMenuController params:nil];
}

@end
