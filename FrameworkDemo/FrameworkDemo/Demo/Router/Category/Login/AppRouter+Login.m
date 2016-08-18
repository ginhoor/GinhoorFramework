//
//  AppRouter+Login.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+Login.h"

NSString * const kTargetLogin = @"LoginAction";
NSString * const kActionLoginVC = @"longinViewController";
NSString * const kActionQuickLoginVC = @"quickLoginViewController";
NSString * const kActionFindPwdVC = @"findPasswordViewController";
NSString * const kActionResetPwdVC = @"resetPasswordViewController";
NSString * const kActionRegistVC = @"registViewController";


@implementation AppRouter (Login)

- (UIViewController *)registViewController
{
    return [self performTargetName:kTargetLogin actionName:kActionRegistVC params:nil];
}

- (UIViewController *)longinViewController
{
    return [self performTargetName:kTargetLogin actionName:kActionLoginVC params:nil];
}

- (UIViewController *)findPasswordViewController
{
    return [self performTargetName:kTargetLogin actionName:kActionFindPwdVC params:nil];
}

- (UIViewController *)quickLoginViewController
{
    return [self performTargetName:kTargetLogin actionName:kActionQuickLoginVC params:nil];
}

- (UIViewController *)resetPasswordViewController
{
    return [self performTargetName:kTargetLogin actionName:kActionResetPwdVC params:nil];
}


@end
