//
//  AppRouter+LoggerDemo.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/22.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+LoggerDemo.h"


NSString * const kTargetDemoLoggerAction = @"LoggerDemoAction";
NSString * const kActionDemoLoggerVC = @"loggerDemoViewController";

@implementation AppRouter (LoggerDemo)

- (UIViewController *)loggerDemoViewController {

    return [self performTargetName:kTargetDemoLoggerAction actionName:kActionDemoLoggerVC params:nil];
}

@end
