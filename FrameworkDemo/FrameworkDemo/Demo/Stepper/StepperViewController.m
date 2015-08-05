//
//  StepperViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/15.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "StepperViewController.h"
#import "GinStepperView.h"
#import <Masonry.h>

@implementation StepperViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    GinStepperView *stepper = [[GinStepperView alloc] init];

    [self.view addSubview:stepper];
    
    [stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(100);
        make.height.offset(30);
    }];

    
    GinStepperView *stepper1 = [[GinStepperView alloc] init];
    
    stepper1.type = GinStepperTypeRectangled;
    
    [self.view addSubview:stepper1];
    
    [stepper1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(200);
        make.height.offset(30);
    }];
    
    
    GinStepperView *stepper2 = [[GinStepperView alloc] init];
    
    [self.view addSubview:stepper2];
    stepper2.toggleAmianted = NO;
    
    [stepper2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(300);
        make.height.offset(30);
    }];
    
    
    GinStepperView *stepper3 = [[GinStepperView alloc] init];
    
    stepper3.type = GinStepperTypeRectangled;
    stepper3.toggleAmianted = NO;
    [self.view addSubview:stepper3];
    
    [stepper3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(400);
        make.height.offset(30);
    }];

}

@end
