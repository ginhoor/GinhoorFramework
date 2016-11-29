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

    [self setup3DTouch];
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSLog(@"-->%s",__func__);
//
//}
//
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setup3DTouch
{
    
    if ([self.window respondsToSelector:@selector(traitCollection)])
    {
        if ([self.window.traitCollection respondsToSelector:@selector(forceTouchCapability)])
        {
            if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
            {
                // 支持3D Touch
                [self addShortcutItems];
            }
            else
            {
                // 不支持3D Touch
            }
        }
    }
}

- (void)addShortcutItems
{
    // 3D touch 快捷按钮 动态添加
    UIApplicationShortcutIcon *searchShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *searchShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.liupeng.search" localizedTitle:@"Search" localizedSubtitle:@"Search Subtitle" icon:searchShortcutIcon userInfo:nil];
    
    UIApplicationShortcutIcon *playShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIApplicationShortcutItem *playShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.liupeng.play" localizedTitle:@"Play" localizedSubtitle:@"Play Subtitle" icon:playShortcutIcon userInfo:nil];
    
    UIApplicationShortcutIcon *qrShortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"test"];
    UIApplicationShortcutItem *qrShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.liupeng.qr" localizedTitle:@"QR" localizedSubtitle:@"QR Subtitle" icon:qrShortcutIcon userInfo:nil];
    
    UIApplicationShortcutIcon *payShortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3dtouch"];
    UIApplicationShortcutItem *payShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.liupeng.pay" localizedTitle:@"Pay" localizedSubtitle:@"Pay Subtitle" icon:payShortcutIcon userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[searchShortcutItem, playShortcutItem, qrShortcutItem, payShortcutItem];
}


/**
 当用户通过点击快捷可选项进入应用程序会回调如下方法,我们可以在这里通过快捷可选项的type来加以区分,以便进行不同的操作

 @param application <#application description#>
 @param shortcutItem <#shortcutItem description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"com.liupeng.search"])
    {
        // do something ...
    }
    else if ([shortcutItem.type isEqualToString:@"com.liupeng.play"])
    {
        // do something ...
    }
    // ...
}

@end
