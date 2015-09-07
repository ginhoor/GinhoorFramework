//
//  People.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/6.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "People.h"

@implementation People

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"name":@"uname",
             @"avatar":@"pic"};
}

+ (NSValueTransformer *)avatarJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
