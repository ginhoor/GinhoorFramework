//
//  NSString+Json.m
//  LOLBox
//
//  Created by Ginhoor on 14-8-19.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString (Json)

- (NSDictionary *)jsonDictionary
{
    return [self JSONValue];
}

- (NSArray *)jsonArray
{
    return [self JSONValue];
}

- (id)JSONValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


@end
