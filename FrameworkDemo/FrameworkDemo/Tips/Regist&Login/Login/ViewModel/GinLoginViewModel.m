//
//  GinLoginViewModel.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinLoginViewModel.h"
#import "NSString+RegEx.h"
@implementation GinLoginViewModel


+ (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password
{

    NSLog(@"登录");
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
#warning 填写登录逻辑
            [subscriber sendNext:@""];
            [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
}

- (RACCommand *)loginCommand
{
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:[self isValidUsernameAndPasswordSignal] signalBlock:^RACSignal *(id input) {
            return [GinLoginViewModel loginWithUsername:self.username password:self.password];
        }];
    }
    return _loginCommand;
}

- (RACSignal *)isValidUsernameAndPasswordSignal
{
    return [RACSignal combineLatest:@[
                                      RACObserve(self, username),
                                      RACObserve(self, password),
                                      ]
                             reduce:^(NSString *username, NSString *password)
            {
                return @([username validateMobile] && password.length > 0);
            }];
}

@end
