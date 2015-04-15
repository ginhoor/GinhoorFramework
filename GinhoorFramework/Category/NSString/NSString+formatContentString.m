//
//  NSString+formatContentString.m
//  LOLBox
//
//  Created by Ginhoor on 14-3-14.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "NSString+formatContentString.h"

@implementation NSString (formatContentString)

- (NSString *)formatContentWithtag:(NSString*)tag
{
    if (self.length > 0) {
        return [NSString stringWithFormat:@"%@：%@",tag,self];
    } else {
        return [NSString stringWithFormat:@"%@：无",tag];
    }
}

- (NSString *)formatWebString
{
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    value = [value stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    value = [value stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    value = [value stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    value = [value stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    value = [value stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    value = [value stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
    value = [value stringByReplacingOccurrencesOfString:@"\\f" withString:@"\f"];
    value = [value stringByReplacingOccurrencesOfString:@"\\b" withString:@"\f"];
    
    return value;
}

@end
