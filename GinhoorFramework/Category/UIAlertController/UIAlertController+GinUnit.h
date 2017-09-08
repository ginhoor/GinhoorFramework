//
//  UIAlertController+GinUnit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 2017/2/6.
//  Copyright © 2017年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (GinUnit)

+ (void)alertOnFirstWindow:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;
+ (void)alertOnFirstWindow:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;

+ (void)alert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;

+ (void)alert:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;


+ (void)alertOnWindow:(UIWindow *)window title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;

+ (void)alertOnWindow:(UIWindow *)window title:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock;


@end
