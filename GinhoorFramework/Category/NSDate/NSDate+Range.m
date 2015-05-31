//
//  NSDate+Range.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/27.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSDate+Range.h"

@implementation NSDate (Range)

- (NSArray *)arrayOfDatesByBeginTime:(NSString*)beginTimeString endTime:(NSString*)endTimeString interval:(NSUInteger)interval numberOfdays:(NSUInteger)num constraintsOfCurrentTime:(BOOL)constraint
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *currentDateComponents = [calendar components:
                                        NSCalendarUnitHour|NSCalendarUnitMinute
                                                   fromDate:[NSDate date]];
    
    
    NSArray *beginTime = [self timeArray:beginTimeString];
    NSDateComponents *beginDateComponents = [currentDateComponents copy];
    beginDateComponents.hour = ((NSString *)beginTime[0]).integerValue;
    beginDateComponents.minute = ((NSString *)beginTime[1]).integerValue;

    NSArray *endTime = [self timeArray:endTimeString];
    NSDateComponents *endDateComponents = [currentDateComponents copy];
    endDateComponents.hour = ((NSString *)endTime[0]).integerValue;
    endDateComponents.minute = ((NSString *)endTime[1]).integerValue;
    
    
//    NSDate *beginDate = [calendar dateFromComponents:beginDateComponents];
//    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    
    NSMutableArray *daysArray = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < num; i++ ) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSUInteger j = beginDateComponents.hour; j < endDateComponents.hour; j++) {

            NSDateComponents *beginTemp = [beginDateComponents copy];
            NSDateComponents *endTemp = [endDateComponents copy];

            for (NSUInteger k = 0 ; k < 60; k+=interval) {
                beginTemp.minute = k;
                [tempArray addObject:beginTemp];
            }
            
        }

        beginDateComponents.day++;
        endDateComponents.day++;
        [daysArray addObject:tempArray];
    }
    
    
    
    
    return @[];
}

- (NSArray *)timeArray:(NSString *)timeString
{
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    return array;
}


//上一个月的日期
- (NSDate *)lastMonthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    if ([components month] == 1) {
        [components setMonth:12];
        [components setYear:[components year] - 1];
    } else {
        [components setMonth:[components month] - 1];
    }
    NSDate *lastMonth = [calendar dateFromComponents:components];
    return lastMonth;
}

//下一个月的日期
- (NSDate *)nextMonthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    if ([components month] == 12) {
        [components setMonth:1];
        [components setYear:[components year] + 1];
    } else {
        [components setMonth:[components month] + 1];
        
    }
    NSDate *lastMonth = [calendar dateFromComponents:components];
    return lastMonth;
}


@end
