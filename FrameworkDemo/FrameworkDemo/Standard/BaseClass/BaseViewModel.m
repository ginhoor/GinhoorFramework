//
//  BaseViewModel.m
//  LOLBox2
//
//  Created by JunhuaShao on 15/9/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseViewModel.h"


@interface BaseViewModel ()

@property (nonatomic, weak) id<APIManager> child;

@end

@implementation BaseViewModel


- (instancetype)init
{
    self = [super init];
    if ([self conformsToProtocol:@protocol(APIManager)]) {
        self.child = (id<APIManager>)self;
    } else {
        // 不遵守这个protocol的就让他crash，防止派生类乱来。
        NSAssert(NO, @"子类必须要实现APIManager这个protocol。");
    }
    return self;
}


@end
