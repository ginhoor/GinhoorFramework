//
//  GinLoginViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinLoginViewController.h"
#import <Masonry.h>
#import "IconTextField.h"

@interface GinLoginViewController ()

@property (strong, nonatomic) IconTextField *userName;
@property (strong, nonatomic) IconTextField *password;

@property (strong, nonatomic) UIButton *nextStep;
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
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.password];
    [self.view addSubview:self.nextStep];
    
    [self.view addSubview:self.separator1];
    
    [self.view updateConstraintsIfNeeded];

}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    [self.separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(self.minimumLineSpacing/2);
        make.left.equalTo(self.userName);
        make.right.equalTo(self.userName);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(self.minimumLineSpacing);
        make.left.equalTo(self.userName);
        make.right.equalTo(self.userName);
        make.height.offset(30);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(self.nextStepOffsetY);
        make.centerX.offset(0);
        make.size.sizeOffset(CGSizeMake(200, 44));
    }];
    
}

- (IconTextField *)userName
{
    if (!_userName) {
        _userName = [[IconTextField alloc] init];
        [_userName addLeftImage:[UIImage imageNamed:@"gin_user_name"]];
        _userName.placeholder = @"用户名/手机号";
    }
    return _userName;
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



- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [[UIButton alloc] init];
        [_nextStep setTitle:@"登录" forState:UIControlStateNormal];
        _nextStep.backgroundColor = [UIColor colorWithRed:0.106f green:0.749f blue:0.408f alpha:1.000f];
        _nextStep.layer.cornerRadius = 4;
        [_nextStep addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}


- (void)nextStepAction:(id)sender
{
    
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
