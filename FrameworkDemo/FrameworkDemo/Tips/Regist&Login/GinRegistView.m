//
//  GinRegistView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinRegistView.h"
#import <Masonry.h>


@interface GinRegistView ()

@property (strong, nonatomic) UIView *separator1;

@property (assign, nonatomic) NSUInteger verifiedColdDown;
@end

@implementation GinRegistView

- (instancetype)initWithType:(GinRegistViewType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        [self setup];
    }
    return self;
    
}


- (void)setup
{
    switch (self.type) {
        case GinRegistViewTypeLogin:
            [self addSubview:self.userName];
            [self addSubview:self.password];
            break;
        case GinRegistViewTypeQuickLogin:
        case GinRegistViewTypeRegist:
            [self addSubview:self.userPhone];
            [self addSubview:self.randomCode];
            [self addSubview:self.getRandomCode];
            break;
        case GinRegistViewTypeFindPassword:
            [self addSubview:self.password];
            [self addSubview:self.checkPassword];
            break;
            
        default:
            break;
    }
    
    self.nextStepButtonOffsetY = 40;
    self.minimumLineSpacing = 0;
    
    
    [self addSubview:self.separator1];
    
    [self updateConstraintsIfNeeded];
}


- (void)updateConstraints
{
    [super updateConstraints];
    
    
    switch (self.type) {
        case GinRegistViewTypeLogin:
        {       [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(0);
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(30);
            }];
            
            [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.userName.mas_bottom).offset(self.minimumLineSpacing);
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(30);
            }];
            break;
        }
        case GinRegistViewTypeQuickLogin:
            break;
        case GinRegistViewTypeRegist:
            break;
        case GinRegistViewTypeFindPassword:
            break;
            
        default:
            break;
    }
    
    
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.userName);
    }];
    
    [self.separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(self.minimumLineSpacing/2);
        make.left.equalTo(self.userName);
        make.right.equalTo(self.userName);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
    
    [self.randomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(self.minimumLineSpacing);
        make.left.offset(0);
        make.right.equalTo(self.getRandomCode.mas_left).offset(-5);
        make.height.offset(30);
    }];
    
    [self.getRandomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.randomCode);
        make.left.equalTo(self.randomCode.mas_right).offset(5);
        make.right.offset(0);
        make.width.offset(100);
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

- (IconTextField *)checkPassword
{
    if (!_checkPassword) {
        _checkPassword = [[IconTextField alloc] init];
        [_checkPassword addLeftImage:[UIImage imageNamed:@"gin_password"]];
        _checkPassword.secureTextEntry = YES;
        _password.placeholder = @"再次输入密码";
    }
    return _checkPassword;
}

- (IconTextField *)userPhone
{
    if (!_userPhone) {
        _userPhone = [[IconTextField alloc] init];
        [_userPhone addLeftImage:[UIImage imageNamed:@"gin_user_phone"]];
        _userPhone.placeholder = @"手机号";

    }
    return _userPhone;
}


- (IconTextField *)randomCode
{
    if (!_randomCode) {
        _randomCode = [[IconTextField alloc] init];
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
        [_getRandomCode addTarget:self action:@selector(getRandomCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getRandomCode;
}

- (void)getRandomCodeAction:(id)sender
{
    self.verifiedColdDown = 60;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    [timer fire];
    [self.randomCode becomeFirstResponder];
    
}

- (void)timerHandler:(id)sender
{
    if (self.verifiedColdDown-- == 0) {
        self.getRandomCode.enabled = YES;
        [self.getRandomCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getRandomCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [((NSTimer *)sender) invalidate];
    } else {
        self.getRandomCode.enabled = NO;
        [self.getRandomCode setTitle:[NSString stringWithFormat:@"%@秒后重新获取",@(self.verifiedColdDown)] forState:UIControlStateNormal];
        [self.getRandomCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [[UIButton alloc] init];

        switch (self.type) {
            case GinRegistViewTypeLogin:
                [_nextStep setTitle:@"登录" forState:UIControlStateNormal];
                break;
            case GinRegistViewTypeQuickLogin:
                [_nextStep setTitle:@"登录" forState:UIControlStateNormal];
                break;
            case GinRegistViewTypeRegist:
                [_nextStep setTitle:@"注册" forState:UIControlStateNormal];
                break;
            case GinRegistViewTypeFindPassword:
                [_nextStep setTitle:@"设置密码" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
        _nextStep.backgroundColor = [UIColor colorWithRed:0.106f green:0.749f blue:0.408f alpha:1.000f];
        _nextStep.layer.cornerRadius = 4;
        [_nextStep addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}


- (void)nextStepAction:(id)sender
{
    switch (self.type) {
        case GinRegistViewTypeLogin:
            ;
            break;
        case GinRegistViewTypeQuickLogin:
            ;
            break;
        case GinRegistViewTypeRegist:
            ;
            break;
        case GinRegistViewTypeFindPassword:
            ;
            break;
            
        default:
            break;
    }
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
