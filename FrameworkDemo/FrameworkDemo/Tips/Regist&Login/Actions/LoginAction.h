//
//  LoginAction.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoginAction : NSObject

- (UIViewController *)registViewController;

- (UIViewController *)longinViewController;

- (UIViewController *)findPasswordViewController;

- (UIViewController *)quickLoginViewController;

- (UIViewController *)resetPasswordViewController;

@end
