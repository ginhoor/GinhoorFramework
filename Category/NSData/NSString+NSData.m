//
//  NSString+NSData.m
//  LOLBox
//
//  Created by Ginhoor on 14-8-30.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "NSString+NSData.h"

@implementation NSString (NSData)

- (NSData *)stringToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
