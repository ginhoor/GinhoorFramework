//
//  demo4Exception.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/12/1.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "demo4Exception.h"

@implementation demo4Exception

- (void)main
{
    
    NSString *exceptionName = @"自定义异常";
    NSString *exceptionReason = @"崩溃原因";
    
    NSDictionary * exceptionUserInfo = @{@"time":@"2015-11-11"};
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    
    @throw exception;
    
    
}


@end
