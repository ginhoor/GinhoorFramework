//
//  UIAlertController+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/14.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "UIAlertController+Unit.h"

@implementation UIAlertController (Unit)


+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:submitBlock];

    // 先加入的在左边
    [alertController addAction:cancel];
    [alertController addAction:submit];

    [alertController presentViewController:[self lastPresentedViewController] animated:YES completion:completedBlock];
}


+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [alertController addAction:cancel];
    
    [alertController presentViewController:[self lastPresentedViewController] animated:YES completion:completedBlock];
    
}

+ (UIViewController*)lastPresentedViewController
{
    UIViewController *presentedViewController = [self getChildPresentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return presentedViewController;
}

+ (UIViewController*)getChildPresentViewController:(UIViewController *)vc
{
    if (!vc.presentedViewController) {
        return vc;
    } else {
        return [self getChildPresentViewController:vc.presentedViewController];
    }
}



@end
