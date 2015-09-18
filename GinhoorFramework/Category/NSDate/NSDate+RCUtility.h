//
//  NSDate+RCUtility.h
//  RemoteController
//
//  Created by 吴 辉斌 on 12-11-5.
//  Copyright (c) 2012年 智屏科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RCUtility)
/**
 *  自定义排版
 *
 *  @param dateString       时间字符串
 *  @param formatString     模板
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString;
/**
 *  昨天
 *
 *  @return NSDate
 */
+ (NSDate *)yesterdayDate;
/**
 *  yyyy
 *
 *  @return NSString
 */
- (NSString *)yearString;
/**
 *  MM-dd
 *
 *  @return NSString
 */
- (NSString *)dateString;

/**
 *  EEE,（@"周日"至@"周一"）
 *
 *  @return NSString
 */
- (NSString *)weekString;

/**
 *  HH:mm
 *
 *  @return NSString
 */
- (NSString *)timeString;

/**
 *  MM-dd HH:mm:ss
 *
 *  @return NSString
 */
- (NSString *)dateAndTimeString;

/**
 *  yyyy-MM-dd
 *
 *  @return NSString
 */
- (NSString *)detailDateString;

/**
 *  yyyy-MM-dd HH:mm:ss
 *
 *  @return NSString
 */
- (NSString *)detailDateAndTimeString;
/**
 *  yyyy-MM-dd HH:mm:ss EEE
 *
 *  @return NSString
 */
- (NSString *)detailDateTimeWeekString;
/**
 *  自定义排版
 *
 *  @param format 模板
 *
 *  @return NSString
 */
- (NSString *)customDateString:(NSString *)format;


// 判断是否是今天 (统一使用Datetools)
//- (BOOL)isToday;

/**
 *  判断两天是否相等
 *
 *  @param date NSDate
 *
 *  @return BOOL
 */
- (BOOL)isSameDayAsOtherDate:(NSDate *)date;

/**
 *  判断两天是否同一个月
 *
 *  @param date NSDate
 *
 *  @return BOOL
 */
- (BOOL)isSameMonthAsOtherDate:(NSDate *)date;

/**
 *  比较 与 目标时间相差多久,返回值格式为 HH:MM:SS
 *
 *  @param anDate NSDate
 *
 *  @return NSString
 */
- (NSString *)compareWithAnDate:(NSDate *)anDate;
/**
 *  比较两个date的时间戳相差时间
 *
 *  @param date NSDate
 *
 *  @return NSTimeInterval
 */
- (NSTimeInterval)intervalBetweenDates:(NSDate *)date;

@end
