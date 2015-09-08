//
//  GinResetPasswordViewModel.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinResetPasswordViewModel.h"
#import "NSString+GinUnit.h"
@implementation GinResetPasswordViewModel


+ (RACSignal *)resetPasswordBy:(NSString *)password
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
}

- (RACCommand *)resetPasswordCommond
{
    if (!_resetPasswordCommond) {
        _resetPasswordCommond = [[RACCommand alloc] initWithEnabled:[self isValidPassword] signalBlock:^RACSignal *(id input) {
            return [GinResetPasswordViewModel resetPasswordBy:self.password];
        }];
    }
    return _resetPasswordCommond;
}

- (RACSignal *)isValidPassword
{
    return [RACSignal combineLatest:@[RACObserve(self, password),
                                      RACObserve(self, checkPassword)]
                             reduce:^(NSString *password, NSString *checkPassword)
    {
        return @(!isBlankString(password) && !isBlankString(checkPassword) && [password isEqualToString:checkPassword]);
    }];
}
@end
