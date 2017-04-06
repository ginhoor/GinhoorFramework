//
//  UIView+GinDebug.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 2017/4/5.
//  Copyright © 2017年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GinDebug)

// 递归获取子视图
//[self getSub:self.navigationController.navigationBar andLevel:1];
- (void)getSub:(UIView *)view andLevel:(int)level;

@end
