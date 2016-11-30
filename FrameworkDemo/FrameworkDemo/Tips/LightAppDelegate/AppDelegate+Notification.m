//
//  AppDelegate+Notification.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/30.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppDelegate+Notification.h"

/**
 http://www.jianshu.com/p/fa17ffa7262e
 推荐使用个推
 
 本地推送
 1：程序运行在前台来推送
    触发回调：应用在前台，只会触发A回调
    行为：没行为
 
 2：程序运行在后台来推送，我点击【推送消息】进入程序
    触发回调：点击通知栏从后台进入前台，只会触发A回调
    行为：图标有数字，通知栏有通知
 
 3：程序运行在后台来推送，我点击【应用图标】进入程序
    触发回调：点击应用图标从后台进入前台，不会触发A、B回调
    行为：图标有数字，通知栏有通知
 
 4：程序没运行来推送，我点击【推送消息】进入程序
    触发回调：程序没运行，点击通知栏启动程序，不会触发A、B回调，【didFinishLaunchingWithOptions 启动参数】有推送内容
    行为：图标有数字，通知栏有通知
 
 5：程序没运行来推送，我点击【应用图标】进入程序
    触发回调：程序未运行，点击应用图标启动程序，不会触发A、B回调，启动参数也没有内容
 
    行为：图标有数字，通知栏有通知
 
 远程推送
 1：程序运行在前台来推送
 触发回调：应用在前台，会触发C回调
 行为：没行为
 
 2：程序运行在后台来推送，我点击【推送消息】进入程序
 触发回调：点击通知栏从后台进入前台，触发C回调
 行为：图标有数字，通知栏有通知
 
 3：程序运行在后台来推送，我点击【应用图标】进入程序
 触发回调：点击应用图标从后台进入前台，不会触发C回调
 行为：图标有数字，通知栏有通知
 
 4：程序没运行来推送，我点击【推送消息】进入程序
 触发回调：程序没运行，点击通知栏启动程序，不会触发C回调，【didFinishLaunchingWithOptions 启动参数】有推送内容
 行为：图标有数字，通知栏有通知
 
 5：程序没运行来推送，我点击【应用图标】进入程序
 触发回调：程序未运行，点击应用图标启动程序，不会触发C回调，启动参数也没有内容
 
 行为：图标有数字，通知栏有通知
 
 */
@implementation AppDelegate (Notification)


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // launched by a remote notification
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notificationPayload) {
        //处理
    }
    return YES;
}

#pragma mark- 本地

/**
 iOS 4 - later

 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //A回调
}

/**
 iOS 8 - later
 【推送消息】左滑后 点击Action 触发
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    //B回调

    completionHandler();
}

/**
 iOS 9 - later
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler
{
    completionHandler();
}

#pragma mark- 远程通知

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //C回调
}

/**
 
 接收静默推送

 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    //回调B
    completionHandler();

}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler
{
    completionHandler();
}

@end
