//
//  AppDelegate.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置导航栏
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.f]}];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    // 取消毛玻璃效果
    //    [UINavigationBar appearance].translucent = NO;
    
    // 设置状态栏颜色
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    self.window.backgroundColor = [UIColor whiteColor];
    //    self.window.rootViewController = xxx
    //    [self.window makeKeyAndVisible];
    
    

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [self testWidgetOpenUrl:url];
    return YES;
}

- (void)testWidgetOpenUrl:(NSURL *)url
{
    if ([url.scheme isEqualToString:@"toMyWiget"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExtenicationNotification" object:url.host];
        NSLog(@"toMyWiget--->%@",url);
    }
}

@end
