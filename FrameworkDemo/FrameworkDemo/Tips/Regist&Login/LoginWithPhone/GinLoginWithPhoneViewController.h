//
//  GinLoginWithPhoneViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
#import "IconTextField.h"
#import "GinLoginWithPhoneViewModel.h"

@interface GinLoginWithPhoneViewController : UIViewController

@property (strong, nonatomic) GinLoginWithPhoneViewModel *loginVM;

@property (strong, nonatomic) IconTextField *username;
@property (strong, nonatomic) IconTextField *randomCode;

@property (strong, nonatomic) UIButton *getRandomCode;
@property (strong, nonatomic) UIButton *nextStep;


@end
