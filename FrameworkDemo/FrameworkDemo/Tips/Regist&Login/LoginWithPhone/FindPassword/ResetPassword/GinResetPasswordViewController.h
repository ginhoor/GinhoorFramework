//
//  GinResetPasswordViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
#import "IconTextField.h"
#import "GinResetPasswordViewModel.h"

@interface GinResetPasswordViewController : UIViewController

@property (strong, nonatomic) GinResetPasswordViewModel *resetPasswordVM;

@property (strong, nonatomic) IconTextField *password;
@property (strong, nonatomic) IconTextField *checkPassword;

@property (strong, nonatomic) UIButton *nextStep;

@end
