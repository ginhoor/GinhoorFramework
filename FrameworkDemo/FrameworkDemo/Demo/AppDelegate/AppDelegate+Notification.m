//
//  AppDelegate+Notification.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/30.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppDelegate+Notification.h"

@implementation AppDelegate (Notification)


//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // launched by a remote notification
//    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (notificationPayload) {
//        //处理
//    }
//    return YES;
//}
//
//#pragma mark- 本地
//
///**
// iOS (4.0 and later)
// */
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    //A回调
//}
//
///**
// iOS (8.0 and later)
// 【推送消息】左滑后 点击Action 触发
// */
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
//{
//    //B回调
//
//    completionHandler();
//}
//
///**
// iOS (9.0 and later)
// */
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler
//{
//    completionHandler();
//}
//
//#pragma mark- 远程通知
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //C回调
//}
//
///**
// 
// 接收静默推送
//
// */
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
//{
//    //回调B
//    completionHandler();
//
//}
//
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler
//{
//    completionHandler();
//}

@end
