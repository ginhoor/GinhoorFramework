//
//  NSValueTransformer+Unit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const GinRelativePathTransformerName;
extern NSString * const GinTimeIntervalValueValueTransformerName;

@interface NSValueTransformer (Unit)

+ (void)setupRelativePathValueTransformer:(NSString *)basePath;
+ (void)setupTimeIntervalValueTransformer;

@end
