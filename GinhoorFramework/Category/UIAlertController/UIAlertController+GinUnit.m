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

+ (void)alert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [alertController addAction:cancel];
    
    UIViewController *presentedViewController = [UIViewController lastPresentedViewController];
    [presentedViewController presentViewController:alertController animated:YES completion:completionBlock];
}

+ (void)alert:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock completionBlock:(void(^)())completionBlock
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:submitBlock];
    
    [alertController addAction:cancel];
    [alertController addAction:submit];
    
    UIViewController *presentedViewController = [UIViewController lastPresentedViewController];
    [presentedViewController presentViewController:alertController animated:YES completion:completionBlock];
}

@end
