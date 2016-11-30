//
//  Demo4AppDelegateWidget.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/30.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "Demo4AppDelegateWidget.h"

#import "AppDelegate.h"

@implementation Demo4AppDelegateWidget


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [self testWidgetOpenUrl:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
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
