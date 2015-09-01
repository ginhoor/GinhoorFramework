//
//  GinQuickLoginViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>

#import "GinQuickLoginViewController.h"
#import "GinResetPasswordViewController.h"

#import "IconTextField.h"
#import "NSString+RegEx.h"

@interface GinQuickLoginViewController ()


@property (strong, nonatomic) IconTextField *userPhone;
@property (strong, nonatomic) IconTextField *randomCode;
@property (strong, nonatomic) UIButton *getRandomCode;

@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIView *separator1;

@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat nextStepOffsetY;

@property (assign, nonatomic) NSUInteger verifiedColdDown;

@end

@implementation GinQuickLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minimumLineSpacing = 5;
    self.nextStepOffsetY = 40;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.userPhone];
    [self.view addSubview:self.randomCode];
    [self.view addSubview:self.getRandomCode];
    
    [self.view addSubview:self.nextStep];
    [self.view addSubview:self.separator1];
    
    [self.view updateConstraintsIfNeeded];

    RAC(self.nextStep, enabled) =
    [RACSignal combineLatest:@[self.userPhone.rac_textSignal,
                               self.randomCode.rac_textSignal]
                      reduce:^(NSString *userPhone, NSString *randomCode)
     {
         return @([userPhone validateMobile] && randomCode.length > 0);
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
    
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    [self.separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userPhone.mas_bottom).offset(self.minimumLineSpacing/2);
        make.left.equalTo(self.userPhone);
        make.right.equalTo(self.userPhone);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
    
    [self.randomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userPhone.mas_bottom).offset(self.minimumLineSpacing);
        make.left.equalTo(self.userPhone);
        make.right.equalTo(self.getRandomCode.mas_left).offset(-5);
        make.height.offset(30);
    }];
    
    [self.getRandomCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.randomCode);
        make.left.equalTo(self.randomCode.mas_right).offset(5);
        make.right.equalTo(self.userPhone);
        make.width.offset(100);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.randomCode.mas_bottom).offset(self.nextStepOffsetY);
        make.centerX.offset(0);
        make.size.sizeOffset(CGSizeMake(200, 44));
    }];
    
}


- (IconTextField *)userPhone
{
    if (!_userPhone) {
        _userPhone = [[IconTextField alloc] init];
        _userPhone.backgroundColor = [UIColor clearColor];
        [_userPhone addLeftImage:[UIImage imageNamed:@"gin_user_phone"]];
        _userPhone.placeholder = @"手机号";
    }
    return _userPhone;
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
            case GinRegistViewTypeQuickLogin:
                [_nextStep setTitle:@"登录" forState:UIControlStateNormal];
                break;
            case GinRegistViewTypeFindPassword:
                [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        _nextStep.enabled = NO;
        _nextStep.layer.cornerRadius = 4;
        [_nextStep addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}


- (void)nextStepAction:(id)sender
{
    switch (self.type) {
        case GinRegistViewTypeQuickLogin:
        {
            
            break;
        }
        case GinRegistViewTypeFindPassword:
        {
            [self.navigationController pushViewController:[[GinResetPasswordViewController alloc] init] animated:YES];
            break;
        }
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
