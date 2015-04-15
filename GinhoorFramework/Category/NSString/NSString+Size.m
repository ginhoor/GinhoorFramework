//
//  NSString+Size.m
//  LOLBox
//
//  Created by Ginhoor on 14-3-13.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)getStringSizeWithfont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGSize)getStringSizeWithfont:(UIFont *)font height:(CGFloat)height
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(0, height)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGSize)getStringSizeWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

@end
