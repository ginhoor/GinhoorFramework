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

/**
 *  
 
 1、init初始化不会触发layoutSubviews
    但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
 
 2、addSubview会触发layoutSubviews
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

 */

- (void)layoutSubviews
{
    [super layoutSubviews];
}




@end
