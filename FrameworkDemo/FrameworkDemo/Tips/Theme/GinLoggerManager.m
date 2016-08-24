//
//  GinLoggerManager.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/22.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "GinLoggerManager.h"

/*
    将下列代码加入到pch文件中
#import <CocoaLumberjack/CocoaLumberjack.h>
 
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelDebug;
#else
static const int ddLogLevel = DDLogLevelError;
#endif

#pragma clang diagnostic pop

 */

@interface GinLoggerFormater : NSObject <DDLogFormatter>
@end


@implementation GinLoggerManager

+ (instancetype)sharedInstance
{
    static GinLoggerManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GinLoggerManager alloc] init];
    });

    return instance;
}


#pragma mark - 初始化log插件
- (void)setupDDLog
{
    GinLoggerFormater *formater = [[GinLoggerFormater alloc] init];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]]; //发送到苹果服务器
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; //发送到Xcode控制台
    
    [DDASLLogger sharedInstance].logFormatter = formater;
    [DDTTYLogger sharedInstance].logFormatter = formater;
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc ] init];
    fileLogger.logFormatter = formater;
    fileLogger.rollingFrequency = 60 * 60 * 24 ; // 记录长度为1天
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;//记录文件为7个
    [DDLog addLogger:fileLogger];
}


@end



@implementation  GinLoggerFormater

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    
    switch (logMessage.flag) {
        case DDLogFlagError    : logLevel = @"E"; break;
        case DDLogFlagWarning  : logLevel = @"W"; break;
        case DDLogFlagInfo     : logLevel = @"I"; break;
        case DDLogFlagDebug    : logLevel = @"D"; break;
        default                : logLevel = @"V"; break;
    }
    //取得文件名
    NSString *locationString;
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    if ([parts count] > 0)
        locationString = [parts lastObject];
    if ([locationString length] == 0)
        locationString = @"No file";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.FFF"];
    
    NSString *logString;
    logString = [NSString stringWithFormat:@"%@=%@ [%@:%@:%@] %@(%@:%lu)\n\n%@\n",
                 logLevel,
                 [formatter stringFromDate: logMessage.timestamp],
                 logMessage.threadName,
                 logMessage.threadID,
                 logMessage.queueLabel,
                 logMessage.function,
                 locationString,
                 logMessage.line,
                 logMessage.message
                 ];

    return logString;
    
    //尝试将logDict内容转为字符串，其实这里可以直接构造字符串，但真实项目中，肯定需要很多其他的信息，不可能仅仅文件名、行数和函数名就够了的。
//    NSError *__autoreleasing error = nil;
//    NSData *outputJson = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:&error];
//    
//    if (error)
//        return error.localizedDescription;
//    
//    NSString *jsonString = [[NSString alloc] initWithData:outputJson
//                                                 encoding:NSUTF8StringEncoding];
//    return jsonString;
}

@end
