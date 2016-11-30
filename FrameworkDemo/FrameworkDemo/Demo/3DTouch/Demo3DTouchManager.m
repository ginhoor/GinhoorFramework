//
//  Demo3DTouchManager.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/30.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "Demo3DTouchManager.h"

#import "AppDelegate.h"

@interface Demo3DTouchManager ()

@property (strong, nonatomic) UIWindow *window;

@end

@implementation Demo3DTouchManager

//
//  AppDelegate.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setup3DTouch];
    
    
    return YES;
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
