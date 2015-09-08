//
//  GinQuickLoginViewControllerSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinQuickLoginViewController.h"
#import "NSString+RegEx.h"

SPEC_BEGIN(GinQuickLoginViewControllerSpec)

describe(@"GinQuickLoginViewController", ^{
    __block GinQuickLoginViewController *loginVC;
    
    beforeEach(^{
        loginVC = [[GinQuickLoginViewController alloc] init];
        [loginVC view];
    });
    
    afterEach(^{
        loginVC = nil;
    });
    
    context(@"bind ViewModel", ^{
        
        it(@"command bind success", ^{
            [[loginVC.nextStep.rac_command should] equal:loginVC.loginVM.loginCommand];
            [[loginVC.getRandomCode.rac_command should] equal:loginVC.loginVM.getRandomCodeCommand];
        });
    });

});

SPEC_END
