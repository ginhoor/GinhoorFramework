//
//  GinLoginWithPhoneViewModel.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinLoginWithPhoneViewModel.h"
#import "NSString+RegEx.h"
#import "UIAlertController+GinUnit.h"

@implementation GinLoginWithPhoneViewModel


+ (RACSignal *)loginWithUsername:(NSString *)username randomCode:(NSString *)password
{
    
    NSLog(@"登录");
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        <#填写登录逻辑#>
        [subscriber sendNext:@""];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
}

+ (RACSignal *)findPasswordWithUsername:(NSString *)username randomCode:(NSString *)password
{
    NSLog(@"找回密码");
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
//        <#填写找回密码逻辑#>
        [subscriber sendNext:@""];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
    
}

+ (RACSignal *)getRandomCodeWithUsername:(NSString *)username randomCode:(NSString *)password
{
    NSLog(@"获取验证码");

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
        if ([username validateMobile]) {
            [subscriber sendNext:@""];
            [subscriber sendCompleted];
            
        } else {
            [UIAlertController alert:@"提示" message:@"请输入正确的手机号" cancelTitle:@"确认" cancelBlock:^{
                [subscriber sendCompleted];
            } completionBlock:nil];
        }
        
//        <#填写获取验证码逻辑#>
        
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
    
}

- (RACCommand *)loginCommand
{
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:[self isValidUsernameAndRandomCodeSignal] signalBlock:^RACSignal *(id input) {
            return [GinLoginWithPhoneViewModel loginWithUsername:self.username randomCode:self.randomCode];
        }];
    }
    return _loginCommand;
}

- (RACCommand *)findPasswordCommand
{
    if (!_findPasswordCommand) {
        _findPasswordCommand = [[RACCommand alloc] initWithEnabled:[self isValidUsernameAndRandomCodeSignal] signalBlock:^RACSignal *(id input) {
            return [GinLoginWithPhoneViewModel findPasswordWithUsername:self.username randomCode:self.randomCode];
        }];
    }
    return _findPasswordCommand;
}

- (RACCommand *)getRandomCodeCommand
{
    if (!_getRandomCodeCommand) {
        
        _getRandomCodeCommand = [[RACCommand alloc] initWithEnabled:[self isVerifiedCoodDown] signalBlock:^RACSignal *(id input) {
            return [GinLoginWithPhoneViewModel getRandomCodeWithUsername:self.username randomCode:self.randomCode];
        }];
    }
    return _getRandomCodeCommand;
}


- (RACSignal *)isVerifiedCoodDown
{
    return [RACObserve(self, verifiedCoolDown) map:^id(NSNumber *verifiedColdDown) {
        return @([verifiedColdDown isEqualToNumber:@(0)]);
    }];
}

- (RACSignal *)isValidUsernameAndRandomCodeSignal
{
    return [RACSignal combineLatest:@[
                                      RACObserve(self, username),
                                      RACObserve(self, randomCode),
                                      ]
                             reduce:^(NSString *username, NSString *password)
            {
                return @([username validateMobile] && password.length > 0);
            }];
}

@end
