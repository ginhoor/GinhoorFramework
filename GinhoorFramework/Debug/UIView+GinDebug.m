//
//  UIView+GinDebug.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2017/4/5.
//  Copyright © 2017年 JunhuaShao. All rights reserved.
//

#import "UIView+GinDebug.h"

@implementation UIView (GinDebug)


- (void)getSub:(UIView *)view andLevel:(int)level {
    NSArray *subviews = [view subviews];
    
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        
        // 打印子视图类名
        NSLog(@"%@%d: %@", blank, level, subview.class);
        
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
        
    }
}

@end
