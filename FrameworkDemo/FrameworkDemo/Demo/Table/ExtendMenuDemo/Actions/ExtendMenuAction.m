//
//  ExtendMenuAction.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "ExtendMenuAction.h"
#import "DynomicHeightController.h"
#import "UIViewController+GinBaseClass.h"
#import "ExtendMenuTableController.h"

@implementation ExtendMenuAction

- (UIViewController *)ExtendMenuController {
    return [ExtendMenuTableController controller];
}

- (UIViewController *)DynomicTableController
{
    return [DynomicHeightController controller];
}

@end
