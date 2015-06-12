//
//  NSAttributedString+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/12.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSAttributedString+Unit.h"

@implementation NSAttributedString (Unit)

+ (instancetype)string:(NSString *)string attribute:(NSDictionary *)attributes
{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    return attrString;
}
@end
