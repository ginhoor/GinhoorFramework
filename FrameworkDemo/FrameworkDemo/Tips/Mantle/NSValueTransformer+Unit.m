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
NSString * const GinTimeIntervalValueValueTransformerName = @"GinTimeIntervalValueValueTransformerName";

@implementation NSValueTransformer (Unit)

+ (void)setupRelativePathValueTransformer:(NSString *)basePath
{
    MTLValueTransformer *relativePathTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSURL *(NSString *relativePath) {
        NSURL *baseURL = [NSURL URLWithString:basePath];
        return [NSURL URLWithString:relativePath relativeToURL:baseURL];
    } reverseBlock:^NSString *(NSURL *url) {
        return url.relativePath;
    }];
    [NSValueTransformer setValueTransformer:relativePathTransformer forName:GinRelativePathTransformerName];
}


+ (void)setupTimeIntervalValueTransformer
{
    MTLValueTransformer *dateValueTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSDate *(NSNumber *ts) {
        return [NSDate dateWithTimeIntervalSince1970:ts.doubleValue/1000];
    } reverseBlock:^NSNumber *(NSDate *date) {
        return @(date.timeIntervalSince1970);
    }];
    
    [NSValueTransformer setValueTransformer:dateValueTransformer forName:GinTimeIntervalValueValueTransformerName];
}


@end
