//
//  NSDate+RCUtility.h
//  RemoteController
//
//  Created by 吴 辉斌 on 12-11-5.
//  Copyright (c) 2012年 智屏科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RCUtility)

+ (NSDate *)dateFromString:(NSString *)dateFormatString formatString:(NSString *)formatString;

+ (NSDate *)yesterdayDate;
// yyyy
- (NSString *)yearString;
// MM-dd
- (NSString *)dateString;

// EEE,（@"周日"至@"周一"）
- (NSString *)weekString;

// HH:mm
- (NSString *)timeString;

// MM-dd HH:mm:ss
- (NSString *)dateAndTimeString;

// yyyy-MM-dd
- (NSString *)detailDateString;

// yyyy-MM-dd HH:mm:ss
- (NSString *)detailDateAndTimeString;

- (NSString *)detailDateTimeWeekString;

- (NSString *)customDateString:(NSString *)format;


// 判断是否是今天
- (BOOL)isToday;

// 判断两天是否相等
- (BOOL)isSameDayAsOtherDate:(NSDate *)date;

// 判断两天是否同一个月
- (BOOL)isSameMonthAsOtherDate:(NSDate *)date;

// 比较 与 目标时间相差多久,返回值格式为 HH:MM:SS
- (NSString *)compareWithAnDate:(NSDate *)anDate;
// 比较两个date的时间戳相差时间
- (NSTimeInterval)intervalBetweenAnDate:(NSDate *)date;

@end
