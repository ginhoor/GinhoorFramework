//
//  GinLoginWithPhoneViewControllerSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinLoginWithPhoneViewController.h"
#import "NSString+RegEx.h"

SPEC_BEGIN(GinLoginWithPhoneViewControllerSpec)

describe(@"GinLoginWithPhoneViewController", ^{

    __block GinLoginWithPhoneViewController *loginVC;
    __block NSString *username = @"15558066089";
    __block NSString *randomCode = @"abc123456";
    
    beforeEach(^{
        loginVC = [[GinLoginWithPhoneViewController alloc] init];
        [loginVC view];
    });
    
    afterEach(^{
        loginVC = nil;
    });
    
    context(@"bind ViewModel", ^{
        
        it(@"textfiled bind success", ^{
            loginVC.username.text = username;
            loginVC.randomCode.text = randomCode;
            
            [loginVC.username sendActionsForControlEvents:UIControlEventEditingChanged];
            [loginVC.randomCode sendActionsForControlEvents:UIControlEventEditingChanged];
            
            [[loginVC.loginVM.username should] equal:loginVC.username.text];
            [[loginVC.loginVM.randomCode should] equal:loginVC.randomCode.text];
        });
    });
});

SPEC_END
