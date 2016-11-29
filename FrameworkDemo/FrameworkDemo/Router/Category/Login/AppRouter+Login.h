//
//  AppRouter+Login.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter.h"
#import <UIKit/UIKit.h>

@interface AppRouter (Login)

- (UIViewController *)registViewController;

- (UIViewController *)longinViewController;

- (UIViewController *)findPasswordViewController;

- (UIViewController *)quickLoginViewController;

- (UIViewController *)resetPasswordViewController;


@end
