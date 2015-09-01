//
//  GinResetPasswordViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>

#import "GinResetPasswordViewController.h"
#import "IconTextField.h"

@interface GinResetPasswordViewController ()

@property (strong, nonatomic) IconTextField *password;
@property (strong, nonatomic) IconTextField *checkPassword;

@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIView *separator1;

@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat nextStepOffsetY;

@end

@implementation GinResetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.minimumLineSpacing = 5;
    self.nextStepOffsetY = 40;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.password];
    [self.view addSubview:self.checkPassword];
    [self.view addSubview:self.nextStep];
    
    [self.view addSubview:self.separator1];
    
    [self.view updateConstraintsIfNeeded];

    RAC(self.nextStep, enabled) =
    [RACSignal combineLatest:@[self.password.rac_textSignal,
                               self.checkPassword.rac_textSignal]
                      reduce:^(NSString *password, NSString *checkPassword)
     {
         return @(password.length>0 && checkPassword.length>0 && [password isEqualToString:checkPassword]);
     }];
    
    [RACObserve(self.nextStep, enabled) subscribeNext:^(NSNumber *enabled) {
        if (enabled.boolValue) {
            _nextStep.backgroundColor = [UIColor colorWithRed:0.106f green:0.749f blue:0.408f alpha:1.000f];
        } else {
            _nextStep.backgroundColor = [UIColor lightGrayColor];
        }
    }];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    [self.separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(self.minimumLineSpacing/2);
        make.left.equalTo(self.password);
        make.right.equalTo(self.password);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
    
    [self.checkPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(self.minimumLineSpacing);
        make.left.equalTo(self.password);
        make.right.equalTo(self.password);
        make.height.offset(30);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkPassword.mas_bottom).offset(self.nextStepOffsetY);
        make.centerX.offset(0);
        make.size.sizeOffset(CGSizeMake(200, 44));
    }];
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

- (IconTextField *)checkPassword
{
    if (!_checkPassword) {
        _checkPassword = [[IconTextField alloc] init];
        [_checkPassword addLeftImage:[UIImage imageNamed:@"gin_password"]];
        _checkPassword.secureTextEntry = YES;
        _checkPassword.placeholder = @"再次输入密码";
    }
    return _checkPassword;
}


- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [[UIButton alloc] init];
        [_nextStep setTitle:@"完成" forState:UIControlStateNormal];
        _nextStep.enabled = NO;
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
