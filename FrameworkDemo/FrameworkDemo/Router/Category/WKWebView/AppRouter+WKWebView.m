//
//  AppRouter+WKWebView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/28.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+WKWebView.h"

NSString * const kTargetDemo4WKWebView = @"Demo4WKWebViewAction";
NSString * const kActionDemo4WKWebViewController = @"demo4WKWebView";

@implementation AppRouter (WKWebView)
- (UIViewController *)demo4WKWebViewController
{
    return [self performTargetName:kTargetDemo4WKWebView actionName:kActionDemo4WKWebViewController params:nil];
}

@end
