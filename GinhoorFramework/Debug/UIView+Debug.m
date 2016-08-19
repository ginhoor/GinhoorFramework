//
//  UIView+Debugger.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/18.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "UIView+Debug.h"

@implementation UIView (Debug)

- (void)printAutoLayoutTrace
{
#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#pragma clang diagnostic pop
#endif
}


@end

