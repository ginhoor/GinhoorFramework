//
//  GinFindPasswordViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinFindPasswordViewController.h"
#import "GinResetPasswordViewController.h"

@interface GinFindPasswordViewController ()

@end

@implementation GinFindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    
    self.nextStep.rac_command = self.loginVM.findPasswordCommand;
    self.getRandomCode.rac_command = self.loginVM.getRandomCodeCommand;
    
    [self.loginVM.findPasswordCommand.executionSignals subscribeNext:^(RACSignal *signal) {
        
        [signal subscribeNext:^(id x) {
            GinResetPasswordViewController *vc = [[GinResetPasswordViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }];
    
}



@end
