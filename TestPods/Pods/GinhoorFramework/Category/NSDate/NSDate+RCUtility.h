//
//  NSDate+RCUtility.h
//  RemoteController
//
//  Created by 吴 辉斌 on 12-11-5.
//  Copyright (c) 2012年 智屏科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RCUtility)

// 返回本时区的时间值，格式为 HH:mm
- (NSString *)timeStringWithCurrentLocal;
// 返回本时区的时间值，格式为 XX月XX日 HH:mm
- (NSString *)dateAndTimeStringWithCurrentLocal;


// 返回星期，格式为EEE,（@"周日"至@"周一"）
- (NSString *)weekDayStringWithCurrentLocal;
// 返回日期，格式为yyyy-MM-dd
- (NSString *)dayStringWithCurrentLocal;
// 返回日期，格式为yyyy
- (NSString *)yearStringWithCurrentLocal;
// 返回日期，格式为MM-dd
- (NSString *)dateStringWithCurrentLocal;
// 返回日期 MM 月 dd 号
- (NSString *)dateString;
// 返回日期 dd 号
- (NSString *)dayString;

// 返回日期的详情，格式为XXXX年XX月XX日 XX：XX：XX
- (NSString *)detailTimeStringWithCurrentLocal;
// 返回日期的详情，格式为XXXX年XX月XX日 星期X（@"星期日"至@"星期一"）
- (NSString *)detailDateStringWithCurrentLocal;


// 判断是否是今天
- (BOOL)isToday;

// 判断两天是否相等
- (BOOL)isSameDayAsOtherDate:(NSDate *)date;

// 判断两天是否同一个月
- (BOOL)isSameMonthAsOtherDate:(NSDate *)date;

// 根据String返回Date: formatString 格式可以为yyyy-MM-dd HH:mm:ss, isLocal表示该String的时间是否为local时间
+ (NSDate *)dateFromString:(NSString *)dateFormatString formatString:(NSString *)formatString isLocal:(BOOL)isLocal;

+ (NSDate *)yesterdayDate;

// 比较 与 目标相差多久,返回值格式为 HH:MM:SS
- (NSString *)compareWithAnDate:(NSDate *)anDate;

- (NSTimeInterval)intervalBetweenAnDate:(NSDate *)date;

@end
