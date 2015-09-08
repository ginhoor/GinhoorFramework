//
//  GinResetPasswordViewControllerSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinResetPasswordViewController.h"


SPEC_BEGIN(GinResetPasswordViewControllerSpec)

describe(@"GinResetPasswordViewController", ^{

    __block GinResetPasswordViewController *resetPasswordVC;
    __block NSString *password = @"abc123456";
    __block NSString *checkPassword = @"abc123456";
    
    beforeEach(^{
        resetPasswordVC = [[GinResetPasswordViewController alloc] init];
        [resetPasswordVC view];
    });
    
    afterEach(^{
        resetPasswordVC = nil;
    });
    
    context(@"bind ViewModel", ^{
        
        it(@"textfiled bind success", ^{
            
            resetPasswordVC.password.text = password;
            resetPasswordVC.checkPassword.text = checkPassword;
            
            [resetPasswordVC.password sendActionsForControlEvents:UIControlEventEditingChanged];
            [resetPasswordVC.checkPassword sendActionsForControlEvents:UIControlEventEditingChanged];
            
            [[resetPasswordVC.resetPasswordVM.password should] equal:resetPasswordVC.password.text];
            [[resetPasswordVC.resetPasswordVM.checkPassword should] equal:resetPasswordVC.checkPassword.text];
        });
        
        it(@"button bind success", ^{
            [[resetPasswordVC.nextStep.rac_command should] equal:resetPasswordVC.resetPasswordVM.resetPasswordCommond];
        });
        
    });

});

SPEC_END
