//
//  GinFindPasswordViewControllerSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinFindPasswordViewController.h"
#import "NSString+RegEx.h"

SPEC_BEGIN(GinFindPasswordViewControllerSpec)

describe(@"GinFindPasswordViewController", ^{
    __block GinFindPasswordViewController *loginVC;
    beforeEach(^{
        loginVC = [[GinFindPasswordViewController alloc] init];
        [loginVC view];
    });
    
    afterEach(^{
        loginVC = nil;
    });
    
    context(@"bind ViewModel", ^{
        
        it(@"command bind success", ^{
            [[loginVC.nextStep.rac_command should] equal:loginVC.loginVM.findPasswordCommand];
            [[loginVC.getRandomCode.rac_command should] equal:loginVC.loginVM.getRandomCodeCommand];
        });
    });

});

SPEC_END
