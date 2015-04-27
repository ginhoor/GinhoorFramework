//
//  UIView+Debugger.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/18.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "UIView+Debug.h"

@implementation UIView (UIView+Debug)

- (void)printAutoLayoutTrace
{
#ifdef DEBUG
    NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#endif
}

@end

