//
//  GinLoginViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconTextField.h"
#import "GinLoginViewModel.h"

@interface GinLoginViewController : UIViewController

@property (strong, nonatomic) GinLoginViewModel *loginVM;

@property (strong, nonatomic) IconTextField *username;
@property (strong, nonatomic) IconTextField *password;

@end
