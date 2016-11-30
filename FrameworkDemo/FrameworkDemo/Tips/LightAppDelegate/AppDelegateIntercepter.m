//
//  AppDelegateIntercepter.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppDelegateIntercepter.h"
#import "AppDelegate.h"
#import <Aspects.h>
#import <CocoaLumberjack.h>
#import <MobClick.h>
#import "GinLoggerManager.h"

@implementation AppDelegateIntercepter

+ (instancetype)sharedInstance
{
    static AppDelegateIntercepter* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDelegateIntercepter alloc] init];
    });

    return instance;
}

+ (void)load
{
    [super load];
    [AppDelegateIntercepter sharedInstance];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [AppDelegate aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UIApplication *application, NSDictionary *launchOptions){
            
            
            [[GinLoggerManager sharedInstance] setupDDLog];
        } error:nil];
        
    }
    return self;
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
