//
//  AppDelegate+Light.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/11/23.
//  Copyright © 2015年 JunhuaShao. All rights reserved.
//

#import "AppDelegate+Light.h"
#import <CocoaLumberjack.h>
#import <MobClick.h>

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelInfo;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif


@implementation AppDelegate (Light)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupSwizzlingMethod];
    });
}

+ (void)setupSwizzlingMethod
{
    [self ty_swizzleMethodWithOrignalSel:@selector(application:didFinishLaunchingWithOptions:) replacementSel:@selector(light_application:didFinishLaunchingWithOptions:)];
}

- (BOOL)light_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setupDDLog];

    
    return [self light_application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)light_applicationWillResignActive:(UIApplication *)application
{
    [self light_applicationWillResignActive:application];
}

- (void)light_applicationDidEnterBackground:(UIApplication *)application
{
    [self light_applicationDidEnterBackground:application];
}

- (void)light_applicationWillEnterForeground:(UIApplication *)application
{
    [self light_applicationWillEnterForeground:application];
}


- (void)light_applicationDidBecomeActive:(UIApplication *)application
{
    [self light_applicationDidBecomeActive:application];
}

- (void)light_applicationWillTerminate:(UIApplication *)application
{
    [self light_applicationDidBecomeActive:application];

}

#pragma mark - 初始化log插件
- (void)setupDDLog
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc ] init];
    fileLogger.rollingFrequency = 60 * 60 * 24 ; // 记录长度为1填
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;//记录文件为7个
    [DDLog addLogger:fileLogger];
}


#pragma mark - 友盟SDK

- (void)umengTrack
{
    // 是否需要捕捉异常
    [MobClick setCrashReportEnabled:YES];
    
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [MobClick setLogEnabled:YES];
    
    //    [MobClick setAppVersion:[GinSysInfo appVersion]]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    
    NSString *channelID = @"AppStore";
    
    //    [UMFeedback setLogEnabled:YES];
    
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    // ********  channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    [MobClick startWithAppkey:@"5554501067e58ed181006fb8" reportPolicy:(ReportPolicy) REALTIME channelId:channelID];
    
    //自动更新检查
    //    [MobClick checkUpdate];
    //自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    //开启在线参数配置
    //    [MobClick updateOnlineConfig];
    
    //获取所有参数
    //    [MobClick getConfigParams];
    
    //检测是否在线参数是否更新
    //如果此时未联网或在线参数获取失败，这个通知是不会被发出的。
    
    //    [NOTIFICATION_CENTER addObserver:self
    //                            selector:@selector(onlineConfigCallBack:)
    //                                name:UMOnlineConfigDidFinishedNotification
    //                              object:nil];
}


@end
