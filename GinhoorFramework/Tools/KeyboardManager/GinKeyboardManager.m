//
//  GinKeyboardManager.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/3.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinKeyboardManager.h"

@implementation GinKeyboardManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)dealloc
{
    [self removeKeyboardObserver];
}

- (void)removeKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboardHandler:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboardHandler:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)showKeyboardHandler:(NSNotification *)notification
{
    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect frame = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame;
    
    [UIView animateWithDuration:0.15 animations:^{
        
        [UIApplication sharedApplication].keyWindow.rootViewController.view.frame = CGRectMake(0, -keyboardSize.height/2, frame.size.width, frame.size.height);
    }];

}

- (void)hideKeyboardHandler:(NSNotification *)notification
{
    CGRect frame = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame;
    
    [UIView animateWithDuration:0.15 animations:^{
        [UIApplication sharedApplication].keyWindow.rootViewController.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }];
}


@end
