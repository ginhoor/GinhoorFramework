//
//  UIAlertView+Unit.m
//  LOLBox
//
//  Created by JunhuaShao on 15/4/2.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import <BlocksKit+UIKit.h>

#import "UIAlertView+Unit.h"
#import "UIViewController+GinBaseClass.h"

@implementation UIAlertView (Unit)


+ (void)alertView:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
        
        [alertController addAction:cancel];
        
        UIViewController *presentedViewController = [UIApplication sharedApplication].keyWindow.rootViewController.lastPresentedViewController;
        [presentedViewController presentViewController:alertController animated:YES completion:cancelBlock];
    } else {
        [self alertViewDeprecated:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock];
    }
#else
    [self alertViewDeprecated:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock];
#endif

}

+ (void)alertViewDeprecated:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alert bk_setHandler:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }forButtonAtIndex:0];
    [alert show];
}

+ (void)alertView:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
        
        UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:submitBlock];
        
        [alertController addAction:cancel];
        [alertController addAction:submit];
        
        UIViewController *presentedViewController = [UIApplication sharedApplication].keyWindow.rootViewController.lastPresentedViewController;
        [presentedViewController presentViewController:alertController animated:YES completion:cancelBlock];
    } else {
        [self alertViewDeprecated:title message:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:cancelTitle cancelBlock:cancelBlock];
    }
#else
    [self alertViewDeprecated:title message:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:cancelTitle cancelBlock:cancelBlock];
#endif
    
}

+ (void)alertViewDeprecated:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:submitTitle, nil];
    [alert bk_setHandler:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }forButtonAtIndex:0];
    
    [alert bk_setHandler:^{
        if (submitBlock) {
            submitBlock();
        }
    } forButtonAtIndex:1];
    [alert show];
}



@end
