//
//  NSValueTransformer+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSValueTransformer+Unit.h"
#import <MTLValueTransformer.h>

NSString * const GinRelativePathTransformerName = @"GinRelativePathTransformerName";
NSString * const GinTimeIntervalValueTransformerName = @"GinTimeIntervalValueValueTransformerName";

@implementation NSValueTransformer (Unit)

+ (void)setupRelativePathValueTransformer:(NSString *)basePath
{
    MTLValueTransformer *relativePathTransformer = [MTLValueTransformer transformerUsingForwardBlock:^NSURL *(NSString *relativePath, BOOL *success, NSError *__autoreleasing *error) {
        NSURL *baseURL = [NSURL URLWithString:basePath];
        return [NSURL URLWithString:relativePath relativeToURL:baseURL];
    } reverseBlock:^NSString *(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return url.relativePath;
    }];
    
    [NSValueTransformer setValueTransformer:relativePathTransformer forName:GinRelativePathTransformerName];
}


+ (void)setupTimeIntervalValueTransformer
{
    MTLValueTransformer *dateValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^NSDate *(NSNumber *ts, BOOL *success, NSError *__autoreleasing *error) {
        if (ts && ![ts isEqualToNumber:@(0)]) {
            return [NSDate dateWithTimeIntervalSince1970:ts.doubleValue/1000];
        } else {
            return nil;
        }
    } reverseBlock:^NSNumber *(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        if (date) {
            return @(date.timeIntervalSince1970*1000);
        } else {
            return nil;
        }
    }];
    
    [NSValueTransformer setValueTransformer:dateValueTransformer forName:GinTimeIntervalValueTransformerName];
}


@end
