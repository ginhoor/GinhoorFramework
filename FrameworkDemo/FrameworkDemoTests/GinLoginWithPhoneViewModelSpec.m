//
//  GinLoginWithPhoneViewModelSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinLoginWithPhoneViewModel.h"


SPEC_BEGIN(GinLoginWithPhoneViewModelSpec)

describe(@"GinLoginWithPhoneViewModel", ^{

    __block GinLoginWithPhoneViewModel *VM;
    beforeEach(^{
        VM = [[GinLoginWithPhoneViewModel alloc] init];
    });
    
    afterEach(^{
        VM = nil;
    });
    
    context(@"when username is 15558066089 and randomCode is 123123", ^{
        __block BOOL result = NO;
        
        it(@"should reutrn YES", ^{
            VM.username = @"15558066089";
            VM.randomCode = @"123123";
            
            [[VM isValidUsernameAndRandomCodeSignal] subscribeNext:^(NSNumber *isValid) {
                result = isValid.boolValue;
            }];
            
            [[theValue(result) should] beYes];
        });
    });
    
    context(@"when username is 123456 and password is 123456", ^{
        __block BOOL result = NO;
        
        it(@"should return signal that value is NO", ^{
            VM.username = @"123456";
            VM.randomCode = @"123456";
            
            [[VM isValidUsernameAndRandomCodeSignal] subscribeNext:^(NSNumber *isValid) {
                result = [isValid boolValue];
            }];
            [[theValue(result) should] beNo];
        });
    });
    
    
    
});

SPEC_END
