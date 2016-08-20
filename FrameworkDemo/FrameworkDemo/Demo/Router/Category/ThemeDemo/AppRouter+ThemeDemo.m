//
//  AppRouter+ThemeDemo.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/19.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+ThemeDemo.h"


NSString * const kTargetThemeDemo = @"ThemeDemoAction";
NSString * const kActionThemeDemoController = @"themeDemoController";


@implementation AppRouter (ThemeDemo)

- (UIViewController *)themeDemoController
{
    return [self performTargetName:kTargetThemeDemo actionName:kActionThemeDemoController params:nil];
}


@end
