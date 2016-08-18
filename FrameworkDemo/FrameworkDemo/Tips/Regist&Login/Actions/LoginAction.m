//
//  LoginAction.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "LoginAction.h"
#import "RegistViewVC.h"
#import "GinLoginViewController.h"
#import "GinQuickLoginViewController.h"
#import "GinResetPasswordViewController.h"
#import "GinFindPasswordViewController.h"
#import "RegistViewVC.h"

@implementation LoginAction

- (UIViewController *)registViewController {
    return [[RegistViewVC alloc] init];
}

- (UIViewController *)longinViewController
{
    return [[GinLoginViewController alloc] init];
}

- (UIViewController *)findPasswordViewController
{
    return [[GinFindPasswordViewController alloc] init];
}

- (UIViewController *)quickLoginViewController
{
    return [[GinQuickLoginViewController alloc] init];
}

- (UIViewController *)resetPasswordViewController
{
    return [[GinResetPasswordViewController alloc] init];
}

@end
