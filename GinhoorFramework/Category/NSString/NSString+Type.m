//
//  NSString+Unit.m
//  gameTrailers
//
//  Created by Ginhoor on 13-12-19.
//  Copyright (c) 2013年 Ginhoor. All rights reserved.
//

#import "NSString+Type.h"

@implementation NSString (Type)

- (BOOL)isImageType
{
    return
    [self hasSuffix:@".png"]
    ||[self hasSuffix:@".PNG"]
    ||[self hasSuffix:@".jpg"]
    ||[self hasSuffix:@".JPG"]
    ||[self hasSuffix:@".jpeg"]
    ||[self hasSuffix:@".JPEG"]
    ||[self hasSuffix:@".gif"]
    ||[self hasSuffix:@".GIF"]
    ||[self hasSuffix:@".bmp"]
    ||[self hasSuffix:@".BMP"];
}


- (BOOL)isGif
{
    return
    [self hasSuffix:@".gif"]
    ||[self hasSuffix:@".GIF"];
}

@end
