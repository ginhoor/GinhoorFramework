//
//  NSString+DEBUG.m
//  LOLBox
//
//  Created by JunhuaShao on 15/3/24.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import "NSString+DEBUG.h"

@implementation NSString (Debug)

+ (NSString *)stringForSize:(CGSize)size
{
    return [NSString stringWithFormat:@"%f,%f",size.width,size.height];
}


+ (NSString *)stringForFrame:(CGRect)frame
{
    return [NSString stringWithFormat:@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height];
}

@end
