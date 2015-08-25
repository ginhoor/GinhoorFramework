//
//  GUIFont.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GUIFont.h"

@implementation GUIFont


// 获得 字体的数量

+ (void)getNumberOfLine
{
    UILabel *label;
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / label.font.lineHeight);
    NSLog(@"共 %td 行", [count integerValue]);
}
@end
