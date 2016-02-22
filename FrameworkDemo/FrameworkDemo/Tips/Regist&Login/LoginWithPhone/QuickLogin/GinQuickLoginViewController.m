//
//  GinQuickLoginViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import <ReactiveCocoa.h>

#import "GinQuickLoginViewController.h"
#import "GinResetPasswordViewController.h"

#import "NSString+RegEx.h"

@interface GinQuickLoginViewController ()

@end

@implementation GinQuickLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nextStep setTitle:@"登录" forState:UIControlStateNormal];

    self.nextStep.rac_command = self.loginVM.loginCommand;
    self.getRandomCode.rac_command = self.loginVM.getRandomCodeCommand;
}


@end
