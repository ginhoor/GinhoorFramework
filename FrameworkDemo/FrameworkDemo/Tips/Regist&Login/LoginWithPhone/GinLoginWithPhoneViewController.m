//
//  GinLoginWithPhoneViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//


#import <Masonry.h>
#import "UIImage+GinUnit.h"
#import "GinLoginWithPhoneViewController.h"

@interface GinLoginWithPhoneViewController ()

@property (strong, nonatomic) UIView *separator1;

@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat nextStepOffsetY;

@property (assign, nonatomic) NSUInteger verifiedColdDown;


@end

@implementation GinLoginWithPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minimumLineSpacing = 5;
    self.nextStepOffsetY = 40;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.randomCode];
    [self.view addSubview:self.getRandomCode];
    
    [self.view addSubview:self.nextStep];
    [self.view addSubview:self.separator1];
    
    [self.view updateConstraintsIfNeeded];
    
    RAC(self.loginVM, username) = self.username.rac_textSignal;
    RAC(self.loginVM, randomCode) = self.randomCode.rac_textSignal;
    
    [self.loginVM.getRandomCodeCommand.executionSignals subscribeNext:^(RACSignal *subscribedSignal) {
        [subscribedSignal subscribeNext:^(id x) {
            ;
        }];
        
        [subscribedSignal subscribeCompleted:^{
            self.loginVM.verifiedCoolDown = 60;
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
            [timer fire];
        }];
    }];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
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
    
    [self.randomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).offset(self.minimumLineSpacing);
        make.left.equalTo(self.username);
        make.right.equalTo(self.getRandomCode.mas_left).offset(-5);
        make.height.offset(30);
    }];
    
    [self.getRandomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.randomCode);
        make.left.equalTo(self.randomCode.mas_right).offset(5);
        make.right.equalTo(self.username);
        make.width.offset(100);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.randomCode.mas_bottom).offset(self.nextStepOffsetY);
        make.centerX.offset(0);
        make.size.sizeOffset(CGSizeMake(200, 44));
    }];
    
}

- (GinLoginWithPhoneViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[GinLoginWithPhoneViewModel alloc] init];
    }
    return _loginVM;
}

- (IconTextField *)username
{
    if (!_username) {
        _username = [[IconTextField alloc] init];
        _username.backgroundColor = [UIColor clearColor];
        [_username addLeftImage:[UIImage imageNamed:@"gin_user_phone"]];
        _username.placeholder = @"手机号";
    }
    return _username;
}

- (IconTextField *)randomCode
{
    if (!_randomCode) {
        _randomCode = [[IconTextField alloc] init];
        _randomCode.backgroundColor = [UIColor clearColor];
        [_randomCode addLeftImage:[UIImage imageNamed:@"gin_random_code"]];
        _randomCode.placeholder = @"验证码";
        
    }
    return _randomCode;
}

- (UIButton *)getRandomCode
{
    if (!_getRandomCode) {
        _getRandomCode = [[UIButton alloc] init];
        [_getRandomCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getRandomCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _getRandomCode.titleLabel.adjustsFontSizeToFitWidth = YES;
        _getRandomCode.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _getRandomCode;
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [[UIButton alloc] init];
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

- (void)timerHandler:(id)sender
{
    if (self.loginVM.verifiedCoolDown-- == 0) {
        self.getRandomCode.enabled = YES;
        [self.getRandomCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getRandomCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [((NSTimer *)sender) invalidate];
    } else {
        self.getRandomCode.enabled = NO;
        [self.getRandomCode setTitle:[NSString stringWithFormat:@"%@秒后重新获取",@(self.loginVM.verifiedCoolDown)] forState:UIControlStateNormal];
        [self.getRandomCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

@end
