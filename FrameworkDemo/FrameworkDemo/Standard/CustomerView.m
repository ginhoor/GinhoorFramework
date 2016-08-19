//
//  CustomerView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/19.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "CustomerView.h"

@implementation CustomerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setConstraints];
}
// 设置 view的初次约束
- (void)setConstraints
{
 
}
// view 约束更新
// [self needsUpdateConstraints] 涉及约束更新
- (void)updateConstraints
{
    [super updateConstraints];
}

// override point. called by layoutIfNeeded automatically.
// [self layoutIfNeeded] 涉及frame 计算
- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
