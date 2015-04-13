//
//  NSDate+RCUtility.m
//  RemoteController
//
//  Created by 吴 辉斌 on 12-11-5.
//  Copyright (c) 2012年 智屏科技. All rights reserved.
//

#import "NSDate+RCUtility.h"

@implementation NSDate (RCUtility)

- (NSString *)timeStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dateAndTimeStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}



- (NSString *)weekDayStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setWeekdaySymbols:@[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]];
    [dateFormatter setShortWeekdaySymbols:dateFormatter.weekdaySymbols];
    [dateFormatter setVeryShortWeekdaySymbols:dateFormatter.weekdaySymbols];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dayStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)yearStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dateStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}


- (NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M月d号"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dayString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d号"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)detailTimeStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)detailDateStringWithCurrentLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd EEE"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setWeekdaySymbols:@[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"]];
    [dateFormatter setShortWeekdaySymbols:dateFormatter.weekdaySymbols];
    [dateFormatter setVeryShortWeekdaySymbols:dateFormatter.weekdaySymbols];
    return [dateFormatter stringFromDate:self];
}


- (BOOL)isToday
{
    return [self isSameDayAsOtherDate:[NSDate date]];
}

- (BOOL)isSameDayAsOtherDate:(NSDate *)date
{
    NSDate *newDate = [[self class] normalizeDate:date];
    return [[[self class] normalizeDate:self] isEqualToDate:newDate];
}

- (BOOL)isSameMonthAsOtherDate:(NSDate *)date
{
    NSDate *newDate = [[self class] monthDate:date];
    return [[[self class] monthDate:self] isEqualToDate:newDate];
}

+ (NSDate *)normalizeDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit)
                                                   fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

+ (NSDate *)monthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit)
                                                   fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString isLocal:(BOOL)isLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    if (isLocal) {
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate *)yesterdayDate
{
    return [NSDate dateWithTimeIntervalSinceNow:-3600*24];
}


- (NSString *)compareWithAnDate:(NSDate *)anDate
{
    NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags =  NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    // 当前系统时间 与 活动结束时间 比较
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:self  toDate:anDate  options:0];
    
    NSInteger diffHour = cps.hour;
    NSInteger diffMinute = cps.minute;
    NSInteger diffSecond = cps.second;
    
    NSString *diffHourStr;
    NSString *diffMinuteStr;
    NSString *diffSecondStr;
    
    if (diffHour < 10) {
        diffHourStr = [NSString stringWithFormat:@"0%@",@(diffHour).stringValue];
    } else {
        diffHourStr = @(diffHour).stringValue;
    }
    
    if (diffMinute < 10) {
        diffMinuteStr = [NSString stringWithFormat:@"0%@",@(diffMinute).stringValue];
    } else {
        diffMinuteStr = @(diffMinute).stringValue;
    }
    
    if (diffSecond < 10) {
        diffSecondStr = [NSString stringWithFormat:@"0%@",@(diffSecond).stringValue];
    } else {
        diffSecondStr = @(diffSecond).stringValue;
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@",diffHourStr,diffMinuteStr,diffSecondStr];
}


- (NSTimeInterval)intervalBetweenAnDate:(NSDate *)date
{
    return self.timeIntervalSinceNow - date.timeIntervalSinceNow;
}

@end
