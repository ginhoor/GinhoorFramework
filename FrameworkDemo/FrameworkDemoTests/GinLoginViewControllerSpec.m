//
//  GinLoginViewControllerSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinLoginViewController.h"
#import "NSString+RegEx.h"

SPEC_BEGIN(GinLoginViewControllerSpec)

describe(@"GinLoginViewController", ^{

    __block GinLoginViewController *loginVC;
    __block NSString *username = @"15558066089";
    __block NSString *password = @"abc123456";

    beforeEach(^{
        loginVC = [[GinLoginViewController alloc] init];
        [loginVC view];
    });
    
    afterEach(^{
        loginVC = nil;
    });
    
    context(@"putin username and password", ^{
        
        it(@"username should be mobile number", ^{
            [[theValue([username validateMobile]) should] beYes];
        });
        
        it(@"password", ^{
            [[password shouldNot] beNil];
            [[theValue(password.length) should] beGreaterThanOrEqualTo:theValue(6)];
        });
    });
    
    context(@"bind ViewModel", ^{
        
        it(@"bind success", ^{
            loginVC.username.text = username;
            loginVC.password.text = password;
            
            [loginVC.username sendActionsForControlEvents:UIControlEventEditingChanged];
            [loginVC.password sendActionsForControlEvents:UIControlEventEditingChanged];
            
            [[loginVC.loginVM.username should] equal:loginVC.username.text];
            [[loginVC.loginVM.password should] equal:loginVC.password.text];
        });
    });
});

SPEC_END
