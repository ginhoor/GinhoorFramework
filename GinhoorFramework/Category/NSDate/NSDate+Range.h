//
//  NSDate+Range.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/27.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Range)

- (NSArray *)arrayOfDatesByBeginTime:(NSString *)beginTime endTime:(NSString *)endTime interval:(NSUInteger)interval numberOfdays:(NSUInteger)num constraintsOfCurrentTime:(BOOL)constraint;

@end
