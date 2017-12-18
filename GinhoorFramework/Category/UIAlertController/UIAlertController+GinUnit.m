//
//  UIAlertController+GinUnit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2017/2/6.
//  Copyright © 2017年 JunhuaShao. All rights reserved.
//

#import "UIAlertController+GinUnit.h"
#import "UIViewController+GinBaseClass.h"

@implementation UIAlertController (GinUnit)

+ (void)alertOnFirstWindow:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock
{
    [self alertOnWindow:[UIApplication sharedApplication].windows.firstObject title:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock completionBlock:completionBlock];
}

+ (void)alertOnFirstWindow:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^ __nullable)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock
{
    [self alertOnWindow:[UIApplication sharedApplication].windows.firstObject title:title message:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:cancelTitle cancelBlock:cancelBlock completionBlock:completionBlock];
}

+ (void)alert:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock
{
    [self alertOnWindow:nil title:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock completionBlock:completionBlock];
}

+ (void)alert:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^ __nullable)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock
{
    [self alertOnWindow:nil title:title message:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:cancelTitle cancelBlock:cancelBlock completionBlock:completionBlock];
}

+ (void)alertOnWindow:(UIWindow * __nullable)window title:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock completionBlock:(void(^)(void))completionBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [alertController addAction:cancel];
    
    UIViewController *presentedViewController;
    if (window) {
        presentedViewController = [UIViewController lastPresentedViewControllerByWindow:window];
    } else {
        presentedViewController = [UIViewController lastPresentedViewController];
    }
    
    [presentedViewController presentViewController:alertController animated:YES completion:completionBlock];
}

+ (void)alertOnWindow:(UIWindow * __nullable)window title:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock completionBlock:(void(^)(void))completionBlock
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:submitBlock];
    
    [alertController addAction:cancel];
    [alertController addAction:submit];
    
    UIViewController *presentedViewController;
    if (window) {
        presentedViewController = [UIViewController lastPresentedViewControllerByWindow:window];
    } else {
        presentedViewController = [UIViewController lastPresentedViewController];
    }

    [presentedViewController presentViewController:alertController animated:YES completion:completionBlock];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
