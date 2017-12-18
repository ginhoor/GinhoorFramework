//
//  UIAlertController+GinUnit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 2017/2/6.
//  Copyright © 2017年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (GinUnit)

+ (void)alertOnFirstWindow:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock;

+ (void)alertOnFirstWindow:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^ __nullable)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock;

+ (void)alert:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock;

+ (void)alert:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^ __nullable)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^ __nullable)(UIAlertAction *action))cancelBlock completionBlock:(void(^ __nullable)(void))completionBlock;

+ (void)alertOnWindow:(UIWindow * __nullable)window title:(NSString * __nullable)title message:(NSString * __nullable)message cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock completionBlock:(void(^)(void))completionBlock;

+ (void)alertOnWindow:(UIWindow * __nullable)window title:(NSString * __nullable)title message:(NSString * __nullable)message submitTitle:(NSString * __nullable)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock cancelTitle:(NSString * __nullable)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock completionBlock:(void(^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END

