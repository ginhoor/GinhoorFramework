//
//  GinLoginViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import <ReactiveCocoa.h>
#import <BlocksKit.h>

#import "UIImage+GinUnit.h"

#import "GinLoginViewController.h"

@interface GinLoginViewController ()

@property (strong, nonatomic) UIView *separator1;

@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat nextStepOffsetY;

@end

@implementation GinLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.minimumLineSpacing = 5;
    self.nextStepOffsetY = 40;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.nextStep];
    
    [self.view addSubview:self.separator1];
    
    [self setConstraints];
    
    RAC(self.loginVM, username) = self.username.rac_textSignal;
    RAC(self.loginVM, password) = self.password.rac_textSignal;
    self.nextStep.rac_command = self.loginVM.loginCommand;
    
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    [self.separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).offset(self.minimumLineSpacing/2);
        make.left.equalTo(self.username);
        make.right.equalTo(self.username);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).offset(self.minimumLineSpacing);
        make.left.equalTo(self.username);
        make.right.equalTo(self.username);
        make.height.offset(30);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(self.nextStepOffsetY);
        make.centerX.offset(0);
        make.size.sizeOffset(CGSizeMake(200, 44));
    }];
}

- (IconTextField *)username
{
    if (!_username) {
        _username = [[IconTextField alloc] init];
        [_username addLeftImage:[UIImage imageNamed:@"gin_user_name"]];
        _username.placeholder = @"手机号";
    }
    return _username;
}

- (IconTextField *)password
{
    if (!_password) {
        _password = [[IconTextField alloc] init];
        [_password addLeftImage:[UIImage imageNamed:@"gin_password"]];
        _password.secureTextEntry = YES;
        _password.placeholder = @"密码";
    }
    return _password;
}

- (GinLoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[GinLoginViewModel alloc] init];
    }
    return _loginVM;
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [[UIButton alloc] init];
        [_nextStep setTitle:@"登录" forState:UIControlStateNormal];
        _nextStep.layer.cornerRadius = 4;
        _nextStep.layer.masksToBounds = YES;

        [_nextStep setBackgroundImage:[UIImage imageByColor:[UIColor colorWithRed:0.106f green:0.749f blue:0.408f alpha:1.000f]] forState:UIControlStateNormal];
        [_nextStep setBackgroundImage:[UIImage imageByColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    }
    return _nextStep;
}


- (UIView *)separator1
{
    if (!_separator1) {
        _separator1 = [[UIView alloc] init];
        _separator1.backgroundColor = [UIColor lightGrayColor];
    }
    return _separator1;
}


@end
