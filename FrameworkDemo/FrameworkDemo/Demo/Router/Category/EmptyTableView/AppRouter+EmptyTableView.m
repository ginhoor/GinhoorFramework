//
//  AppRouter+EmptyTableView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+EmptyTableView.h"

NSString * const kTargetEmptyTableVC = @"EmptyTableVCAction";
NSString * const kActionEmptyTableViewController = @"emptyTableViewController";

@implementation AppRouter (EmptyTableView)

- (UIViewController *)emptyTableViewController
{
    return [self performTargetName:kTargetEmptyTableVC actionName:kActionEmptyTableViewController params:nil];
}

@end
