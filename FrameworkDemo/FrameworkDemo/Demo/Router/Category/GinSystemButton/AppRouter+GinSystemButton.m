//
//  AppRouter+GinSystemButton.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+GinSystemButton.h"

NSString * const kTargetGinSystemButtonVCAction = @"GinSystemButtonVCAction";
NSString * const kActionSystemButtonViewController = @"systemButtonViewController";


@implementation AppRouter (GinSystemButton)

- (UIViewController *)systemButtonViewController
{
    return [self performTargetName:kTargetGinSystemButtonVCAction actionName:kActionSystemButtonViewController params:nil];
}

@end
