//
//  AppRouter+DemoCode.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+DemoCode.h"


NSString * const kTargetDemoCode = @"CodeDemoAction";
NSString * const kActionDemoCodeController = @"demoCodeController";

@implementation AppRouter (DemoCode)

- (UIViewController *)demoCodeController
{
    return [self performTargetName:kTargetDemoCode actionName:kActionDemoCodeController params:nil];
}

@end
