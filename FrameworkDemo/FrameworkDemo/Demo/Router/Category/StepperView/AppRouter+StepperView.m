//
//  AppRouter+StepperView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+StepperView.h"

NSString * const kTargetStepperView = @"StepperVCAction";
NSString * const kActionStepperViewController = @"stepperViewController";
@implementation AppRouter (StepperView)

- (UIViewController *)stepperViewController
{
    return [self performTargetName:kTargetStepperView actionName:kActionStepperViewController params:nil];
}


@end
