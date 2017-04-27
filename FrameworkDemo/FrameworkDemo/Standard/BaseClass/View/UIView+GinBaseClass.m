//
//  UIView+BaseClass.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+GinBaseClass.h"

@implementation UIView (GinBaseClass)

- (void)prepareForAutoLayout
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
}


#pragma mark- 交换方法实现

//+ (void)load
//{
//    //    交换deallac方法
//    Method dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//    Method deallocSwizzle = class_getInstanceMethod([self class], @selector(deallocSwizzle));
//    method_exchangeImplementations(dealloc, deallocSwizzle);
//    
//    //    交换awakeFromNib方法
//    Method awakeFromNib = class_getInstanceMethod([self class], NSSelectorFromString(@"awakeFromNib"));
//    Method awakeFromNibSwizzle = class_getInstanceMethod([self class], @selector(awakeFromNibSwizzle));
//    method_exchangeImplementations(awakeFromNib, awakeFromNibSwizzle);
//    
//    //    交换deallac方法
//    Method init = class_getInstanceMethod([self class], NSSelectorFromString(@"init"));
//    Method initSwizzle = class_getInstanceMethod([self class], @selector(initSwizzle));
//    method_exchangeImplementations(init, initSwizzle);
//    
//}

@end
