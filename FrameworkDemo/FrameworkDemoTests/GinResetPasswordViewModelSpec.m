//
//  GinResetPasswordViewModelSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinResetPasswordViewModel.h"


SPEC_BEGIN(GinResetPasswordViewModelSpec)

describe(@"GinResetPasswordViewModel", ^{
    
    __block GinResetPasswordViewModel *VM;
    beforeEach(^{
        VM = [[GinResetPasswordViewModel alloc] init];
    });
    
    afterEach(^{
        VM = nil;
    });
    
    context(@"when password is abc123 and checkPassword is abc123", ^{
        __block BOOL result = NO;
        
        it(@"should reutrn YES", ^{
            VM.password = @"abc123";
            VM.checkPassword = @"abc123";
            
            [[VM isValidPassword] subscribeNext:^(NSNumber *isValid) {
                result = isValid.boolValue;
            }];
            [[theValue(result) should] beYes];
        });
    });
    
    context(@"when password is abc456 and checkPassword is 123456", ^{
        __block BOOL result = NO;
        
        it(@"should return signal that value is NO", ^{
            VM.password = @"abc456";
            VM.checkPassword = @"123456";
            
            [[VM isValidPassword] subscribeNext:^(NSNumber *isValid) {
                result = [isValid boolValue];
            }];
            [[theValue(result) should] beNo];
        });
    });
    
});

SPEC_END
