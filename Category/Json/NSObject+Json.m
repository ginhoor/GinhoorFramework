//
//  NSObject+Json.m
//  LOLBox
//
//  Created by Ginhoor on 14-8-19.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject (Json)

- (NSString *)JSONString
{
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return [[NSString alloc] initWithData:result
                                 encoding:NSUTF8StringEncoding];
}

@end
